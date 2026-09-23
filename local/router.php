<?php
// Enrutador para el servidor integrado de PHP (solo en tu maquina).
// Hace lo mismo que el .htaccess del servidor: si el archivo existe se sirve
// tal cual; si no, todo entra a router.php. Las imagenes que el cliente subio
// desde el panel (/uploads/) no estan en el repo: se piden a temporal.
$root = realpath(__DIR__.'/../sitio-produccion');
$path = rawurldecode(parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH));
$file = $root.str_replace('/', DIRECTORY_SEPARATOR, $path);

if ($path !== '/' && is_file($file)) {
  return false;
}
if (preg_match('#^/(uploads|img|video)/#', $path)) {
  header('Location: https://temporal.aldea.work'.$path, true, 302);
  exit;
}
if (!getenv('ALDEA_DB_DSN')) {
  putenv('ALDEA_DB_DSN=sqlite:'.__DIR__.'/aldea-local.sqlite');
}
$_SERVER['DOCUMENT_ROOT'] = $root;
chdir($root);
require $root.'/router.php';
