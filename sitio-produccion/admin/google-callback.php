<?php require __DIR__.'/_init.php'; require_once __DIR__.'/google_lib.php';
if(!empty($_GET['error'])){ flash('Google devolvio: '.$_GET['error']); header('Location: /admin/conexiones.php'); exit; }
if(!empty($_GET['code'])){
  $ok=g_exchange_code($_GET['code']);
  flash($ok?'¡Google conectado! Ya puedes ver las metricas en Analitica.':'No se pudo completar la conexion. Revisa el Client ID/Secret y la URI de redireccion.');
  header('Location: /admin/conexiones.php'); exit;
}
header('Location: /admin/conexiones.php'); exit;
