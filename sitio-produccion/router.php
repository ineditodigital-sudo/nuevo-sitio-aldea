<?php
// Aldea: comprimir salida dinamica (nginx al frente no comprime; lo hace PHP)
if(function_exists('ob_gzhandler') && !ini_get('zlib.output_compression') && strpos((string)($_SERVER['HTTP_ACCEPT_ENCODING']??''),'gzip')!==false){ @ob_start('ob_gzhandler'); }
require_once __DIR__.'/cms/site.php';
$path = isset($_GET['path']) ? $_GET['path'] : parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH);
$slug = trim((string)$path,'/');
$GLOBALS['SITE_LANG']='es';
if($slug==='en'||strpos($slug,'en/')===0){ $GLOBALS['SITE_LANG']='en'; $slug=($slug==='en')?'':substr($slug,3); }
if($slug==='robots.txt'){ header('Content-Type: text/plain; charset=utf-8'); $h=$_SERVER['HTTP_HOST']??''; if(strpos($h,'temporal.')===0){ echo "User-agent: *\nDisallow: /\n"; } else { echo "User-agent: *\nAllow: /\nDisallow: /admin/\nDisallow: /cms/\nDisallow: /uploads/\nSitemap: https://".$h."/sitemap.xml\n"; } exit; }
if($slug==='sitemap.xml'){ require_once __DIR__.'/cms/sitemap.php'; exit; }
function serve_static($slug){ $dr=$_SERVER['DOCUMENT_ROOT']; $f=$slug==='' ? $dr.'/index.html' : $dr.'/'.$slug.'/index.html'; if(is_file($f)){ readfile($f); return true; } return false; }
try{
  $pdo=cms_pdo();
  $r=$pdo->prepare("SELECT to_path,code FROM redirects WHERE from_path=?"); $r->execute(['/'.$slug.'/']); $rd=$r->fetch();
  if($rd){ http_response_code((int)($rd['code']?:301)); header('Location: '.$rd['to_path']); exit; }
  if($slug===''){ include __DIR__.'/cms/tpl_home.php'; exit; }
  if($slug==='lo-que-ofrecemos'){ include __DIR__.'/cms/tpl_sol_index.php'; exit; }
  if($slug==='ubicaciones'){ include __DIR__.'/cms/tpl_loc_index.php'; exit; }
  if($slug==='blog'){ include __DIR__.'/cms/tpl_blog_index.php'; exit; }
  if($slug==='formulario-enviado'){ include __DIR__.'/cms/tpl_gracias.php'; exit; } // gracias tras enviar un formulario
  $st=$pdo->prepare("SELECT * FROM solutions WHERE slug=? AND published=1"); $st->execute([$slug]); $sol=$st->fetch();
  if($sol){ include __DIR__.'/cms/tpl_solution.php'; exit; }
  $st=$pdo->prepare("SELECT * FROM locations WHERE slug=? AND published=1"); $st->execute([$slug]); $loc=$st->fetch();
  if($loc){ include __DIR__.'/cms/tpl_location.php'; exit; }
  $st=$pdo->prepare("SELECT * FROM posts WHERE slug=? AND status='publish'"); $st->execute([$slug]); $post=$st->fetch();
  if($post){ include __DIR__.'/cms/tpl_post.php'; exit; }
  $st=$pdo->prepare("SELECT * FROM pages WHERE slug=? AND published=1 AND type IN ('simple','legal','faq','contact')"); $st->execute([$slug]); $pg=$st->fetch();
  if($pg){ include __DIR__.'/cms/tpl_page.php'; exit; }
  if(serve_static($slug)) exit;
  include __DIR__.'/cms/tpl_404.php';
}catch(Throwable $e){
  // Sin base de datos: el error va al log del servidor (mostrarlo podria revelar datos de la conexion)
  // y el visitante ve la copia estatica de la pagina; si no la hay, la del Inicio con estado 503.
  error_log('Aldea router: '.$e->getMessage());
  if(!serve_static($slug)){
    http_response_code(503); header('Retry-After: 300');
    $__ix=$_SERVER['DOCUMENT_ROOT'].'/index.html';
    if(is_file($__ix)) readfile($__ix); else echo 'Estamos haciendo mantenimiento. Intenta de nuevo en unos minutos.';
  }
}
