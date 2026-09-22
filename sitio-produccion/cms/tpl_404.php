<?php
/* Pagina 404. La llama router.php cuando ninguna ruta coincide.
   Lleva cabecera y pie para que el visitante pueda seguir navegando
   en vez de quedarse en un callejon sin salida. */
http_response_code(404);
site_head('Pagina no encontrada | Aldea Networking',
  'La pagina que buscas no existe o cambio de direccion.',
  '/404/', true,
  'Page not found | Aldea Networking',
  'The page you are looking for does not exist or has moved.');
site_header();
echo '<main>';

echo '<section class="section e404"><div class="container">';
echo '<div class="e404-in reveal">';
echo '<span class="e404-code" aria-hidden="true">404</span>';
echo '<h1 data-es="Esta página no existe" data-en="This page does not exist">Esta página no existe</h1>';
echo '<p class="lead" data-es="Puede que el enlace esté mal escrito o que hayamos movido el contenido. Desde aquí puedes seguir." '
    .'data-en="The link may be misspelled or the content may have moved. You can continue from here.">'
    .'Puede que el enlace esté mal escrito o que hayamos movido el contenido. Desde aquí puedes seguir.</p>';
echo '<div class="hero-cta">'
    .'<a class="btn btn-accent" href="/" data-es="Ir al inicio" data-en="Go to homepage">Ir al inicio</a>'
    .'<a class="btn btn-ghost" href="/contacto/" data-es="Cotizar" data-en="Get a quote">Cotizar</a>'
    .'</div>';
echo '</div>';

// Atajos a lo que la gente suele buscar, sacados de la propia base.
try {
  $pdo = cms_pdo();
  $sol = $pdo->query("SELECT slug,title_es,title_en FROM solutions WHERE published=1 AND in_menu=1 ORDER BY sort,id")->fetchAll();
  $loc = $pdo->query("SELECT slug,city_es,city_en,name FROM locations WHERE published=1 ORDER BY sort,id")->fetchAll();
} catch (Throwable $e) { $sol = []; $loc = []; }

if ($sol || $loc) {
  echo '<div class="e404-cols reveal">';
  if ($sol) {
    echo '<div><h2 data-es="Espacios de trabajo" data-en="Workspaces">Espacios de trabajo</h2><ul class="e404-list">';
    foreach ($sol as $s)
      echo '<li><a href="/'.esc($s['slug']).'/" data-es="'.esc($s['title_es']).'" data-en="'.esc($s['title_en'] ?: $s['title_es']).'">'.esc($s['title_es']).'</a></li>';
    echo '</ul></div>';
  }
  if ($loc) {
    echo '<div><h2 data-es="Ubicaciones" data-en="Locations">Ubicaciones</h2><ul class="e404-list">';
    foreach ($loc as $l) {
      $sede = preg_replace('/^Aldea\s+/u', '', (string)$l['name']);
      $es = $l['city_es'].($sede !== '' ? ' — '.$sede : '');
      $en = ($l['city_en'] ?: $l['city_es']).($sede !== '' ? ' — '.$sede : '');
      echo '<li><a href="/'.esc($l['slug']).'/" data-es="'.esc($es).'" data-en="'.esc($en).'">'.esc($es).'</a></li>';
    }
    echo '</ul></div>';
  }
  echo '<div><h2 data-es="Aldea" data-en="Aldea">Aldea</h2><ul class="e404-list">'
      .'<li><a href="/oficinas-corporativas/" data-es="Oficinas Corporativas" data-en="Corporate Offices">Oficinas Corporativas</a></li>'
      .'<li><a href="/acerca-de-aldea/" data-es="Acerca de Aldea" data-en="About Aldea">Acerca de Aldea</a></li>'
      .'<li><a href="/preguntas-frecuentes/" data-es="Preguntas frecuentes" data-en="FAQ">Preguntas frecuentes</a></li>'
      .'<li><a href="/blog/" data-es="Blog" data-en="Blog">Blog</a></li>'
      .'</ul></div>';
  echo '</div>';
}

echo '</div></section>';
echo '</main>';
site_footer();
site_scripts();
