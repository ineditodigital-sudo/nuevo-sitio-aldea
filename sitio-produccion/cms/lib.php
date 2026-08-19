<?php
require_once __DIR__.'/db.php';
function cms_session(){ if(session_status()!==PHP_SESSION_ACTIVE){ @session_set_cookie_params(['httponly'=>true,'samesite'=>'Lax','secure'=>!empty($_SERVER['HTTPS'])]); @session_start(); } }
function cms_user(){ cms_session(); return $_SESSION['cms_user']??null; }
function cms_require_login(){ if(!cms_user()){ header('Location: /admin/login.php'); exit; } }
function e($s){ return htmlspecialchars((string)$s,ENT_QUOTES,'UTF-8'); }
function csrf(){ cms_session(); if(empty($_SESSION['csrf'])) $_SESSION['csrf']=bin2hex(random_bytes(16)); return $_SESSION['csrf']; }
function csrf_ok(){ cms_session(); return isset($_POST['csrf']) && hash_equals($_SESSION['csrf']??'', $_POST['csrf']); }
function flash($m=null){ cms_session(); if($m!==null){$_SESSION['flash']=$m;return;} $f=$_SESSION['flash']??null; unset($_SESSION['flash']); return $f; }
function setting($k,$d=''){ static $s=null; if($s===null){ $s=[]; foreach(cms_pdo()->query("SELECT skey,value FROM settings") as $r) $s[$r['skey']]=$r['value']; } return $s[$k]??$d; }
function count_rows($t){ try{ return (int)cms_pdo()->query("SELECT COUNT(*) FROM `$t`")->fetchColumn(); }catch(Throwable $e){ return 0; } }
