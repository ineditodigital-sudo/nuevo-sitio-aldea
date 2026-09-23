"""
Crea local/aldea-local.sqlite a partir de sitio-produccion/cms/contenido.sql.

Sirve para ver el sitio en tu maquina sin MySQL: el CMS solo lee en las
paginas publicas, y esas consultas funcionan igual en SQLite.

    python local/crear-base.py

Vuelve a correrlo cada vez que se regenere contenido.sql o apliques una
migracion nueva (pasala como argumento para cargarla encima):

    python local/crear-base.py sitio-produccion/cms/migracion-algo.sql
"""
import os
import re
import sqlite3
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
DUMP = os.path.join(ROOT, "sitio-produccion", "cms", "contenido.sql")
DB = os.path.join(HERE, "aldea-local.sqlite")

# Tablas que no vienen en el volcado (datos personales o del panel).
# Solo se crean vacias para que el sitio no falle al consultarlas.
EXTRA = {
    "leads": "id INTEGER PRIMARY KEY AUTOINCREMENT, name, email, phone, company, city, "
             "team_size, message, source, url, ip, status DEFAULT 'new', "
             "created_at DEFAULT CURRENT_TIMESTAMP",
    "media": "id INTEGER PRIMARY KEY AUTOINCREMENT, filename, path, alt, width, height, bytes, "
             "created_at DEFAULT CURRENT_TIMESTAMP",
    "users": "id INTEGER PRIMARY KEY AUTOINCREMENT, name, username, email, password_hash, role, "
             "last_login, created_at DEFAULT CURRENT_TIMESTAMP",
}

ESC = {"n": "\n", "r": "\r", "t": "\t", "0": "\0", "Z": "\x1a", "b": "\b"}


def statements(sql):
    """Parte el archivo en sentencias, respetando los ; dentro de cadenas."""
    out, buf, i, n, quote = [], [], 0, len(sql), None
    while i < n:
        c = sql[i]
        if quote:
            buf.append(c)
            if c == "\\" and i + 1 < n:
                buf.append(sql[i + 1])
                i += 2
                continue
            if c == quote:
                if i + 1 < n and sql[i + 1] == quote:
                    buf.append(sql[i + 1])
                    i += 2
                    continue
                quote = None
        elif c in "'\"":
            quote = c
            buf.append(c)
        elif c == "-" and sql.startswith("--", i):
            j = sql.find("\n", i)
            i = n if j < 0 else j + 1
            continue
        elif c == ";":
            s = "".join(buf).strip()
            if s:
                out.append(s)
            buf = []
        else:
            buf.append(c)
        i += 1
    s = "".join(buf).strip()
    if s:
        out.append(s)
    return out


def values(text):
    """Convierte "(1,'a\\'b',NULL),(2,...)" en listas de valores de Python."""
    rows, row, i, n = [], None, 0, len(text)
    while i < n:
        c = text[i]
        if c == "(" and row is None:
            row = []
        elif c == ")" and row is not None:
            rows.append(row)
            row = None
        elif c == "'" and row is not None:
            j, s = i + 1, []
            while j < n:
                d = text[j]
                if d == "\\" and j + 1 < n:
                    e = text[j + 1]
                    s.append(ESC.get(e, e))
                    j += 2
                    continue
                if d == "'":
                    if j + 1 < n and text[j + 1] == "'":
                        s.append("'")
                        j += 2
                        continue
                    break
                s.append(d)
                j += 1
            row.append("".join(s))
            i = j
        elif row is not None and (c.isdigit() or c == "-" or c.isalpha()):
            m = re.match(r"-?\d+(?:\.\d+)?|NULL|null|TRUE|FALSE", text[i:])
            tok = m.group(0)
            if tok.upper() == "NULL":
                row.append(None)
            elif tok.upper() in ("TRUE", "FALSE"):
                row.append(1 if tok.upper() == "TRUE" else 0)
            else:
                row.append(float(tok) if "." in tok else int(tok))
            i += len(tok)
            continue
        i += 1
    return rows


def cargar(con, path, created):
    sql = open(path, encoding="utf-8").read()
    total = 0
    for st in statements(sql):
        head = st.lstrip()[:12].upper()
        if head.startswith("SET "):
            continue
        m = re.match(r"INSERT\s+INTO\s+`?(\w+)`?\s*\(([^)]*)\)\s*VALUES\s*(.*)$", st, re.S | re.I)
        if m:
            table = m.group(1)
            cols = [c.strip().strip("`") for c in m.group(2).split(",")]
            if table not in created:
                defs = ", ".join(
                    ("id INTEGER PRIMARY KEY" if c == "id" else '"%s"' % c) for c in cols
                )
                con.execute('CREATE TABLE "%s" (%s)' % (table, defs))
                created[table] = set(cols)
            for c in cols:
                if c not in created[table]:
                    con.execute('ALTER TABLE "%s" ADD COLUMN "%s"' % (table, c))
                    created[table].add(c)
            rows = values(m.group(3))
            ph = ",".join("?" * len(cols))
            qcols = ",".join('"%s"' % c for c in cols)
            con.executemany(
                'INSERT OR REPLACE INTO "%s" (%s) VALUES (%s)' % (table, qcols, ph), rows
            )
            total += len(rows)
            continue
        m = re.match(r"DELETE\s+FROM\s+`?(\w+)`?", st, re.I)
        if m:
            if m.group(1) in created:
                con.execute(st.replace("`", '"'))
            continue
        # Migraciones: UPDATE / DELETE con WHERE / INSERT ... SELECT. Se intentan
        # tal cual (con comillas dobles en lugar de acentos graves) y se avisa si fallan.
        try:
            con.execute(st.replace("`", '"').replace("\\'", "''"))
        except sqlite3.Error as e:
            print("  aviso, no se aplico: %s ... (%s)" % (st[:90].replace("\n", " "), e))
    return total


def main():
    if os.path.exists(DB):
        os.remove(DB)
    con = sqlite3.connect(DB)
    created = {}
    n = cargar(con, DUMP, created)
    for table, cols in EXTRA.items():
        if table not in created:
            con.execute('CREATE TABLE "%s" (%s)' % (table, cols))
    # Las plantillas nunca usan DUAL, pero seedhome.php si; asi no truena.
    con.execute("CREATE TABLE IF NOT EXISTS dual (x)")
    con.execute("INSERT INTO dual VALUES (1)")
    for extra in sys.argv[1:]:
        print("Aplicando", extra)
        cargar(con, extra, created)
    con.commit()
    con.close()
    print("Listo: %d filas en %s" % (n, DB))


if __name__ == "__main__":
    main()
