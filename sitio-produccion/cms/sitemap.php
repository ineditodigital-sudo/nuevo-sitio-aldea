<?php
if(!function_exists('cms_pdo')) require_once __DIR__.'/site.php';
header('Content-Type: application/xml; charset=utf-8');
$pdo=cms_pdo(); $host=$_SERVER['HTTP_HOST']??'aldea.work'; $base='https://'.$host;
$urls=['/','/lo-que-ofrecemos/','/ubicaciones/','/blog/','/acerca-de-aldea/','/contacto/','/preguntas-frecuentes/'];
try{ foreach($pdo->query("SELECT slug FROM pages WHERE published=1 AND slug<>'' AND slug NOT LIKE '\\_\\_%'") as $r) $urls[]='/'.$r['slug'].'/'; }catch(Throwable $e){}
try{ foreach($pdo->query("SELECT slug FROM solutions WHERE published=1") as $r) $urls[]='/'.$r['slug'].'/'; }catch(Throwable $e){}
try{ foreach($pdo->query("SELECT slug FROM locations WHERE published=1") as $r) $urls[]='/'.$r['slug'].'/'; }catch(Throwable $e){}
try{ foreach($pdo->query("SELECT slug FROM posts WHERE status='publish'") as $r) $urls[]='/'.$r['slug'].'/'; }catch(Throwable $e){}
$urls=array_values(array_unique($urls));
function xe($s){ return htmlspecialchars($s,ENT_QUOTES,'UTF-8'); }
echo '<?xml version="1.0" encoding="UTF-8"?>'."\n";
echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xhtml="http://www.w3.org/1999/xhtml">'."\n";
foreach($urls as $u){
  $es=$base.$u; $en=$base.'/en'.$u;
  foreach([$es,$en] as $self){
    echo '<url><loc>'.xe($self).'</loc>';
    echo '<xhtml:link rel="alternate" hreflang="es" href="'.xe($es).'"/>';
    echo '<xhtml:link rel="alternate" hreflang="en" href="'.xe($en).'"/>';
    echo '<xhtml:link rel="alternate" hreflang="x-default" href="'.xe($es).'"/>';
    echo "</url>\n";
  }
}
echo '</urlset>';
