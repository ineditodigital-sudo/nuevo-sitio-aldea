"""Deploy de Aldea a temporal.aldea.work por FTP.

    python deploy.py status              que difiere entre local y remoto
    python deploy.py push <ruta>...      sube archivos o carpetas concretos
    python deploy.py push-changed        sube todo lo que difiere
    python deploy.py pull <ruta>...      baja del remoto al local
    python deploy.py ls [ruta]           lista una carpeta remota
    python deploy.py dump                respalda las tablas del CMS a JSON
    python deploy.py sql <archivo.sql>   ejecuta un .sql en el servidor
    python deploy.py restore <carpeta>   revierte usando un respaldo de bak/
    python deploy.py rm <ruta>...        borra del servidor (respalda antes)

Cada push respalda antes lo que va a sobrescribir, en bak/<fecha-hora>/.
Las credenciales estan en deploy/ftp.conf y nunca salen de esta maquina.
"""
import ftplib
import io
import json
import os
import posixpath
import secrets
import ssl
import sys
import time
import urllib.parse
import urllib.request

HERE = os.path.dirname(os.path.abspath(__file__))
PROJECT = os.path.dirname(HERE)
LOCAL_ROOT = os.path.join(PROJECT, "sitio-produccion")
BAK_ROOT = os.path.join(HERE, "bak")
DUMP_ROOT = os.path.join(HERE, "dumps")

# Nunca se suben ni se sobrescriben: son del servidor, no del repo.
EXCLUDE = {
    "cms/config.php",       # credenciales de la base
    ".htaccess",            # lo genera cPanel + reglas del router
    "php.ini",
    ".user.ini",
    "error_log",
}
EXCLUDE_DIRS = {"uploads", ".well-known"}


def log(msg):
    print(msg, flush=True)


def load_conf():
    path = os.path.join(HERE, "ftp.conf")
    if not os.path.isfile(path):
        sys.exit("Falta deploy/ftp.conf")
    conf = {}
    for line in io.open(path, encoding="utf-8"):
        line = line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        k, v = line.split("=", 1)
        conf[k.strip()] = v.strip()
    for key in ("host", "user", "pass", "remote_dir"):
        if not conf.get(key):
            sys.exit("Falta '%s' en deploy/ftp.conf" % key)
    return conf


def connect(conf):
    if conf.get("tls", "si").lower() in ("si", "yes", "true", "1"):
        # El certificado de cPanel suele ser del hostname del servidor.
        # No validamos el nombre, pero el canal va cifrado.
        ctx = ssl.create_default_context()
        ctx.check_hostname = False
        ctx.verify_mode = ssl.CERT_NONE
        ftp = ftplib.FTP_TLS(context=ctx, timeout=60)
    else:
        ftp = ftplib.FTP(timeout=60)
    ftp.connect(conf["host"], int(conf.get("port", 21)))
    ftp.login(conf["user"], conf["pass"])
    if isinstance(ftp, ftplib.FTP_TLS):
        ftp.prot_p()
    ftp.set_pasv(True)
    return ftp


def excluded(rel):
    if rel in EXCLUDE:
        return True
    parts = rel.split("/")
    return parts[0] in EXCLUDE_DIRS


def local_files():
    """Rutas relativas (con /) de todo sitio-produccion, sin exclusiones."""
    out = []
    for root, dirs, files in os.walk(LOCAL_ROOT):
        dirs[:] = [d for d in dirs if d not in EXCLUDE_DIRS]
        for f in files:
            full = os.path.join(root, f)
            rel = os.path.relpath(full, LOCAL_ROOT).replace(os.sep, "/")
            if not excluded(rel):
                out.append(rel)
    return sorted(out)


def expand(paths):
    """Convierte rutas dadas por el usuario en lista de archivos relativos."""
    every = local_files()
    out = []
    for p in paths:
        rel = p.replace(os.sep, "/").strip("/")
        if os.path.isfile(os.path.join(LOCAL_ROOT, rel.replace("/", os.sep))):
            if excluded(rel):
                log("  omitido (excluido): %s" % rel)
            else:
                out.append(rel)
        else:
            hit = [f for f in every if f == rel or f.startswith(rel + "/")]
            if not hit:
                log("  sin coincidencias: %s" % p)
            out.extend(hit)
    seen = set()
    return [x for x in out if not (x in seen or seen.add(x))]


def rsize(ftp, path):
    try:
        return ftp.size(path)
    except Exception:
        return None


def ensure_dirs(ftp, base, rel):
    cur = base
    for part in rel.split("/")[:-1]:
        cur = cur + "/" + part
        try:
            ftp.mkd(cur)
        except Exception:
            pass


def backup(ftp, base, rels, stamp):
    """Baja al local los archivos remotos que se van a pisar."""
    dest_root = os.path.join(BAK_ROOT, stamp)
    saved = 0
    for rel in rels:
        size = rsize(ftp, base + "/" + rel)
        if size is None:
            continue
        dest = os.path.join(dest_root, rel.replace("/", os.sep))
        os.makedirs(os.path.dirname(dest), exist_ok=True)
        with open(dest, "wb") as fh:
            ftp.retrbinary("RETR " + base + "/" + rel, fh.write)
        saved += 1
    if saved:
        log("respaldo de %d archivos en bak/%s" % (saved, stamp))
    return dest_root


def do_push(conf, rels):
    if not rels:
        log("nada que subir")
        return
    ftp = connect(conf)
    base = conf["remote_dir"].rstrip("/")
    stamp = time.strftime("%Y%m%d-%H%M%S")
    backup(ftp, base, rels, stamp)
    ok = 0
    for rel in rels:
        local = os.path.join(LOCAL_ROOT, rel.replace("/", os.sep))
        ensure_dirs(ftp, base, rel)
        with open(local, "rb") as fh:
            ftp.storbinary("STOR " + base + "/" + rel, fh)
        remote = rsize(ftp, base + "/" + rel)
        local_size = os.path.getsize(local)
        mark = "OK" if remote == local_size else "REVISAR (remoto=%s)" % remote
        if remote == local_size:
            ok += 1
        log("  %-42s %8d b  %s" % (rel, local_size, mark))
    ftp.quit()
    log("\n%d/%d subidos y verificados. Respaldo: bak/%s" % (ok, len(rels), stamp))


def cmd_status(conf, args):
    ftp = connect(conf)
    base = conf["remote_dir"].rstrip("/")
    same, diff, missing = [], [], []
    for rel in local_files():
        lsize = os.path.getsize(os.path.join(LOCAL_ROOT, rel.replace("/", os.sep)))
        r = rsize(ftp, base + "/" + rel)
        if r is None:
            missing.append(rel)
        elif r == lsize:
            same.append(rel)
        else:
            diff.append((rel, lsize, r))
    ftp.quit()
    log("Distinto tamano que el remoto (%d):" % len(diff))
    for rel, l, r in diff:
        log("  %-42s local=%-8d remoto=%-8d" % (rel, l, r))
    log("\nNo existen en el remoto (%d):" % len(missing))
    for rel in missing:
        log("  %s" % rel)
    log("\nIguales: %d" % len(same))


def cmd_push(conf, args):
    do_push(conf, expand(args))


def cmd_push_changed(conf, args):
    ftp = connect(conf)
    base = conf["remote_dir"].rstrip("/")
    rels = []
    for rel in local_files():
        lsize = os.path.getsize(os.path.join(LOCAL_ROOT, rel.replace("/", os.sep)))
        if rsize(ftp, base + "/" + rel) != lsize:
            rels.append(rel)
    ftp.quit()
    log("Van a subirse %d archivos:" % len(rels))
    for rel in rels:
        log("  %s" % rel)
    if not rels:
        return
    if input("\nConfirmas? (si/no) ").strip().lower() not in ("si", "s", "yes", "y"):
        log("cancelado")
        return
    do_push(conf, rels)


def cmd_pull(conf, args):
    ftp = connect(conf)
    base = conf["remote_dir"].rstrip("/")
    for p in args:
        rel = p.replace(os.sep, "/").strip("/")
        dest = os.path.join(LOCAL_ROOT, rel.replace("/", os.sep))
        os.makedirs(os.path.dirname(dest), exist_ok=True)
        with open(dest, "wb") as fh:
            ftp.retrbinary("RETR " + base + "/" + rel, fh.write)
        log("bajado %s (%d b)" % (rel, os.path.getsize(dest)))
    ftp.quit()


def cmd_ls(conf, args):
    ftp = connect(conf)
    base = conf["remote_dir"].rstrip("/")
    path = base + "/" + args[0].strip("/") if args else base
    log("Listando %s\n" % path)
    ftp.cwd(path)
    ftp.retrlines("LIST")
    ftp.quit()


# ---------- ejecucion de SQL en el servidor ----------

RUNNER = r'''<?php
header('Content-Type: application/json; charset=utf-8');
$T='%(token)s';
if(($_GET['token']??'')!==$T){ http_response_code(404); echo '{"e":"no"}'; exit; }
require_once __DIR__.'/cms/db.php';
$pdo=cms_pdo(); $pdo->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
$a=$_GET['action']??'dump';
if($a==='dump'){
  $o=[];
  foreach(['blocks','menu_items','solutions','locations','testimonials','settings','pages','redirects','clients','posts','media'] as $t){
    try{ $o[$t]=$pdo->query("SELECT * FROM `$t`")->fetchAll(PDO::FETCH_ASSOC); }catch(Throwable $e){ $o[$t]=['__error'=>$e->getMessage()]; }
  }
  try{ $o['__leads_cols']=$pdo->query("SHOW COLUMNS FROM `leads`")->fetchAll(PDO::FETCH_COLUMN); }catch(Throwable $e){}
  echo json_encode($o,JSON_UNESCAPED_UNICODE); exit;
}
if($a!=='run'){ echo '{"e":"accion"}'; exit; }
$rel=preg_replace('#[^A-Za-z0-9_./-]#','',(string)($_GET['file']??''));
if($rel==='' || strpos($rel,'..')!==false){ echo '{"e":"ruta invalida"}'; exit; }
$f=__DIR__.'/'.$rel;
if(!is_file($f)){ echo json_encode(['e'=>'no encuentro el sql','buscado'=>$rel]); exit; }
$sql=file_get_contents($f);
$ls=[]; foreach(preg_split('/\R/',$sql) as $l){ if(preg_match('/^\s*--/',$l)) continue; $ls[]=$l; }
$sql=implode("\n",$ls);
$st=[]; $b=''; $s=false; $k=false; $n=strlen($sql);
for($i=0;$i<$n;$i++){ $c=$sql[$i];
  if($s){ $b.=$c; if($c==="'"){ if($i+1<$n && $sql[$i+1]==="'"){ $b.=$sql[++$i]; } else { $s=false; } } continue; }
  if($k){ $b.=$c; if($c==='`') $k=false; continue; }
  if($c==="'"){ $s=true; $b.=$c; continue; }
  if($c==='`'){ $k=true; $b.=$c; continue; }
  if($c===';'){ $t=trim($b); if($t!=='') $st[]=$t; $b=''; continue; }
  $b.=$c;
}
if(trim($b)!=='') $st[]=trim($b);
$r=['total'=>count($st),'ok'=>0,'ya'=>0,'errores'=>[],'filas'=>[]];
foreach($st as $i=>$q){ $lab=preg_replace('/\s+/',' ',substr($q,0,90));
  try{ $af=$pdo->exec($q); $r['ok']++; if($af) $r['filas'][]=['n'=>$i+1,'sql'=>$lab,'filas'=>$af]; }
  catch(Throwable $e){ $m=$e->getMessage();
    if(stripos($m,'Duplicate column')!==false){ $r['ya']++; continue; }
    $r['errores'][]=['n'=>$i+1,'sql'=>$lab,'error'=>$m]; }
}
echo json_encode($r,JSON_UNESCAPED_UNICODE);
'''


def site_url(conf):
    return conf.get("site_url", "https://temporal.aldea.work").rstrip("/")


def with_runner(conf, fn):
    """Sube el runner, ejecuta fn(url_base), y lo borra pase lo que pase."""
    token = secrets.token_hex(16)
    name = "_deploy_%s.php" % token[:10]
    ftp = connect(conf)
    base = conf["remote_dir"].rstrip("/")
    ftp.storbinary("STOR " + base + "/" + name, io.BytesIO((RUNNER % {"token": token}).encode("utf-8")))
    ftp.quit()
    url = "%s/%s?token=%s" % (site_url(conf), name, token)
    try:
        return fn(url)
    finally:
        ftp = connect(conf)
        try:
            ftp.delete(base + "/" + name)
            log("runner temporal borrado")
        finally:
            ftp.quit()


def fetch(url, timeout=180):
    req = urllib.request.Request(url, headers={"User-Agent": "aldea-deploy"})
    with urllib.request.urlopen(req, timeout=timeout) as resp:
        return resp.read().decode("utf-8", "replace")


def save_dump(conf, tag):
    os.makedirs(DUMP_ROOT, exist_ok=True)
    stamp = time.strftime("%Y%m%d-%H%M%S")
    path = os.path.join(DUMP_ROOT, "%s-%s.json" % (stamp, tag))

    def go(url):
        return fetch(url + "&action=dump")

    raw = with_runner(conf, go)
    io.open(path, "w", encoding="utf-8").write(raw)
    try:
        d = json.loads(raw)
        log("respaldo de base: %s" % os.path.relpath(path, PROJECT))
        for t in ("blocks", "menu_items", "solutions", "locations", "testimonials"):
            if isinstance(d.get(t), list):
                log("   %-14s %d filas" % (t, len(d[t])))
    except Exception:
        log("respaldo guardado en %s (no pude leerlo como JSON)" % path)
    return path


def cmd_dump(conf, args):
    save_dump(conf, "manual")


def cmd_sql(conf, args):
    if not args:
        sys.exit("Indica el archivo .sql (ruta relativa a sitio-produccion/)")
    rel = args[0].replace(os.sep, "/").strip("/")
    local = os.path.join(LOCAL_ROOT, rel.replace("/", os.sep))
    if not os.path.isfile(local):
        sys.exit("No existe %s" % local)

    log("1) subiendo el .sql")
    do_push(conf, [rel])
    log("\n2) respaldando la base antes de ejecutar")
    save_dump(conf, "antes")
    log("\n3) ejecutando %s en el servidor" % rel)

    def go(url):
        return fetch(url + "&action=run&file=" + urllib.parse.quote(rel))

    raw = with_runner(conf, go)
    try:
        r = json.loads(raw)
    except Exception:
        log("respuesta inesperada:\n" + raw[:2000])
        return
    if "total" not in r:
        log("   EL SERVIDOR NO EJECUTO NADA: %s" % raw[:400])
        return
    log("   sentencias=%s  ok=%s  ya_aplicado=%s  errores=%d"
        % (r.get("total"), r.get("ok"), r.get("ya"), len(r.get("errores", []))))
    for e in r.get("errores", []):
        log("   ERROR #%s %s\n      %s" % (e["n"], e["error"][:160], e["sql"][:90]))
    for f in r.get("filas", [])[:40]:
        log("   #%-3s filas=%-4s %s" % (f["n"], f["filas"], f["sql"][:70]))


def cmd_restore(conf, args):
    if not args:
        sets = sorted(os.listdir(BAK_ROOT)) if os.path.isdir(BAK_ROOT) else []
        sys.exit("Indica un respaldo. Disponibles:\n  " + "\n  ".join(sets))
    src_root = os.path.join(BAK_ROOT, args[0])
    if not os.path.isdir(src_root):
        sys.exit("No existe bak/%s" % args[0])
    rels = []
    for root, _dirs, files in os.walk(src_root):
        for f in files:
            rels.append(os.path.relpath(os.path.join(root, f), src_root).replace(os.sep, "/"))
    log("Se restauraran %d archivos desde bak/%s:" % (len(rels), args[0]))
    for rel in rels:
        log("  %s" % rel)
    if input("\nConfirmas? (si/no) ").strip().lower() not in ("si", "s", "yes", "y"):
        log("cancelado")
        return
    ftp = connect(conf)
    base = conf["remote_dir"].rstrip("/")
    for rel in rels:
        with open(os.path.join(src_root, rel.replace("/", os.sep)), "rb") as fh:
            ftp.storbinary("STOR " + base + "/" + rel, fh)
        log("  restaurado %s" % rel)
    ftp.quit()


def cmd_rm(conf, args):
    """Borra archivos del servidor. Siempre respalda antes en bak/<fecha>."""
    rels = [a.replace("\\", "/").lstrip("/") for a in args]
    if not rels:
        log("uso: deploy.py rm <ruta> [ruta...]")
        return
    ftp = connect(conf)
    base = conf["remote_dir"].rstrip("/")
    existen = [r for r in rels if rsize(ftp, base + "/" + r) is not None]
    faltan = [r for r in rels if r not in existen]
    for r in faltan:
        log("  %-42s no existe en el servidor" % r)
    if not existen:
        ftp.quit()
        return
    stamp = time.strftime("%Y%m%d-%H%M%S")
    backup(ftp, base, existen, stamp)
    for r in existen:
        try:
            ftp.delete(base + "/" + r)
            log("  %-42s BORRADO" % r)
        except Exception as e:
            log("  %-42s ERROR: %s" % (r, e))
    ftp.quit()
    log("")
    log("Respaldo en bak/%s (deploy.py restore %s para revertir)" % (stamp, stamp))


COMMANDS = {
    "status": cmd_status,
    "push": cmd_push,
    "push-changed": cmd_push_changed,
    "pull": cmd_pull,
    "ls": cmd_ls,
    "dump": cmd_dump,
    "sql": cmd_sql,
    "restore": cmd_restore,
    "rm": cmd_rm,
}

if __name__ == "__main__":
    if len(sys.argv) < 2 or sys.argv[1] not in COMMANDS:
        sys.exit(__doc__)
    COMMANDS[sys.argv[1]](load_conf(), sys.argv[2:])
