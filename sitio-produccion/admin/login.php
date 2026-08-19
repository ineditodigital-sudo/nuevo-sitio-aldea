<?php require __DIR__.'/../cms/lib.php'; cms_session();
if(cms_user()){ header('Location: /admin/'); exit; }
$err='';
if($_SERVER['REQUEST_METHOD']==='POST'){
  $usr=trim($_POST['username']??''); $pwd=$_POST['password']??'';
  $st=cms_pdo()->prepare("SELECT * FROM users WHERE username=?"); $st->execute([$usr]); $row=$st->fetch();
  if($row && password_verify($pwd,$row['password_hash'])){
    session_regenerate_id(true);
    $_SESSION['cms_user']=['id'=>$row['id'],'username'=>$row['username'],'name'=>$row['name'],'role'=>$row['role']];
    cms_pdo()->prepare("UPDATE users SET last_login=NOW() WHERE id=?")->execute([$row['id']]);
    header('Location: /admin/'); exit;
  } else { $err='Usuario o contrasena incorrectos.'; }
}
?><!doctype html><html lang="es"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Entrar · Aldea CMS</title><link rel="icon" href="/img/favicon.svg">
<link rel="preconnect" href="https://fonts.googleapis.com"><link href="https://fonts.googleapis.com/css2?family=Jost:wght@400;500;600;700&family=Raleway:wght@300;400;500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/admin/admin.css"></head><body class="adm-login">
<form class="login-card" method="post">
  <img class="login-logo" src="/img/logo-azul.svg" alt="Aldea">
  <h1>Panel de administracion</h1>
  <p class="login-sub">Ingresa para gestionar el contenido del sitio.</p>
  <?php if($err): ?><div class="login-err"><?=e($err)?></div><?php endif; ?>
  <label>Usuario<input name="username" type="text" required autofocus></label>
  <label>Contrasena
    <span class="pw-wrap">
      <input name="password" id="pwd" type="password" required>
      <button type="button" class="pw-eye" id="pwEye" aria-label="Mostrar contrasena" title="Mostrar u ocultar contrasena">
        <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-7 11-7 11 7 11 7-4 7-11 7-11-7-11-7z"/><circle cx="12" cy="12" r="3"/></svg>
      </button>
    </span>
  </label>
  <button type="submit" class="btn-primary">Entrar</button>
</form>
<style>.pw-wrap{position:relative;display:block}.pw-wrap input{width:100%;padding-right:2.6rem;box-sizing:border-box}.pw-eye{position:absolute;right:.55rem;top:50%;transform:translateY(-50%);background:none;border:0;cursor:pointer;color:#9aa3b2;display:flex;align-items:center;padding:.2rem;line-height:0}.pw-eye:hover,.pw-eye.on{color:#2b3a55}</style>
<script>(function(){var b=document.getElementById('pwEye'),p=document.getElementById('pwd');if(b&&p)b.addEventListener('click',function(){var sh=p.type==='password';p.type=sh?'text':'password';b.classList.toggle('on',sh);b.setAttribute('aria-label',sh?'Ocultar contrasena':'Mostrar contrasena');});})();</script>
</body></html>
