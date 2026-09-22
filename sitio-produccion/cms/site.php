<?php
require_once __DIR__.'/db.php';
require_once __DIR__.'/icons.php';
function esc($s){ return htmlspecialchars((string)$s,ENT_QUOTES,'UTF-8'); }
function site_lang(){ return $GLOBALS['SITE_LANG'] ?? 'es'; }
function L($es,$en){ return site_lang()==='en' ? ($en!==''&&$en!==null?$en:$es) : $es; }
function tr_en($h){
  // texto bilingue: reemplaza el contenido por la version EN
  $h=preg_replace_callback('/(\sdata-es="[^"]*"\s+data-en="([^"]*)"[^>]*>)([^<]*)</s', function($m){ return $m[1].$m[2].'<'; }, $h);
  // placeholders
  $h=preg_replace_callback('/placeholder="[^"]*"([^>]*?)data-ph-en="([^"]*)"/s', function($m){ return 'placeholder="'.$m[2].'"'.$m[1].'data-ph-en="'.$m[2].'"'; }, $h);
  // enlaces internos -> prefijo /en
  $h=preg_replace_callback('/href="(\/[^"]*)"/', function($m){ $u=$m[1];
    if($u==='/en'||strpos($u,'/en/')===0) return 'href="'.$u.'"';
    if(preg_match('#^/(img|uploads|admin|cms|cgi-bin|wp-|\.well-known|favicon)#',$u)) return 'href="'.$u.'"';
    if(strpos($u,'.')!==false) return 'href="'.$u.'"';
    return 'href="/en'.$u.'"';
  }, $h);
  return $h;
}
function setting($k,$d=''){ static $s=null; if($s===null){$s=[];foreach(cms_pdo()->query("SELECT skey,value FROM settings") as $r)$s[$r['skey']]=$r['value'];} return $s[$k]??$d; }
function site_head($title,$desc='',$canon='',$noindex=false,$title_en='',$desc_en=''){
  $host=$_SERVER['HTTP_HOST']??'temporal.aldea.work';
  $lang=site_lang();
  // rutas ES/EN de la pagina actual (para hreflang y el selector de idioma)
  $rp=parse_url($_SERVER['REQUEST_URI']??'/',PHP_URL_PATH);
  $rp=preg_replace('#^/en(/|$)#','/',$rp);
  $esPath=($rp===''||$rp==='/')?'/':'/'.trim($rp,'/').'/';
  $enPath=$esPath==='/'?'/en/':'/en'.$esPath;
  $GLOBALS['cur_es_path']=$esPath; $GLOBALS['cur_en_path']=$enPath;
  $canonSelf=$lang==='en'?$enPath:$esPath;
  $t=$lang==='en'&&$title_en?$title_en:$title;
  $d=$lang==='en'&&$desc_en?$desc_en:$desc;
  echo '<!doctype html><html lang="'.$lang.'"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">';
  echo '<title>'.esc($t).'</title>';
  if($d)echo '<meta name="description" content="'.esc($d).'">';
  echo '<link rel="canonical" href="https://'.$host.esc($canonSelf).'">';
  echo '<link rel="alternate" hreflang="es" href="https://'.$host.esc($esPath).'">';
  echo '<link rel="alternate" hreflang="en" href="https://'.$host.esc($enPath).'">';
  echo '<link rel="alternate" hreflang="x-default" href="https://'.$host.esc($esPath).'">';
  if($noindex)echo '<meta name="robots" content="noindex, nofollow">';
  // --- Open Graph / Twitter: como se ve el enlace cuando alguien lo comparte ---
  // La imagen sale de /img/og/<slug>.jpg; si la pagina no tiene una propia se
  // usa default.jpg. Son 1200x630 en JPG, la medida que piden Facebook y
  // LinkedIn y el formato que WhatsApp dibuja sin fallar (con WebP a veces no).
  // Una plantilla puede imponer la suya con $GLOBALS['og_image'].
  $__slug=preg_replace('/[^a-z0-9-]/','',strtolower(trim($esPath,'/')));
  $__ogRel='/img/og/'.($__slug===''?'default':$__slug).'.jpg';
  if(!is_file(($_SERVER['DOCUMENT_ROOT']??'').$__ogRel)) $__ogRel='/img/og/default.jpg';
  if(!empty($GLOBALS['og_image'])) $__ogRel=$GLOBALS['og_image'];
  $__ogUrl='https://'.$host.$__ogRel;
  $__ogDesc=$d?:($lang==='en'
    ? 'Private offices, coworking, private desks and virtual address in Leon, San Luis Potosi, Aguascalientes and Queretaro.'
    : 'Oficinas privadas, coworking, escritorios privados y domicilio virtual en Leon, San Luis Potosi, Aguascalientes y Queretaro.');
  echo '<meta property="og:type" content="'.esc($GLOBALS['og_type']??'website').'">';
  echo '<meta property="og:site_name" content="Aldea Networking">';
  echo '<meta property="og:locale" content="'.($lang==='en'?'en_US':'es_MX').'">';
  echo '<meta property="og:locale:alternate" content="'.($lang==='en'?'es_MX':'en_US').'">';
  echo '<meta property="og:title" content="'.esc($t).'">';
  echo '<meta property="og:description" content="'.esc($__ogDesc).'">';
  echo '<meta property="og:url" content="https://'.$host.esc($canonSelf).'">';
  echo '<meta property="og:image" content="'.esc($__ogUrl).'">';
  echo '<meta property="og:image:width" content="1200"><meta property="og:image:height" content="630">';
  echo '<meta property="og:image:alt" content="'.esc($t).'">';
  echo '<meta name="twitter:card" content="summary_large_image">';
  echo '<meta name="twitter:title" content="'.esc($t).'">';
  echo '<meta name="twitter:description" content="'.esc($__ogDesc).'">';
  echo '<meta name="twitter:image" content="'.esc($__ogUrl).'">';
  if($g=setting('gtm_id')) echo "<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src='https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);})(window,document,'script','dataLayer','".esc($g)."');</script>";
  echo '<link rel="icon" href="/img/favicon.svg"><link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>';
  $__v=(int)@filemtime($_SERVER['DOCUMENT_ROOT'].'/s6.css');
  echo '<link href="https://fonts.googleapis.com/css2?family=Jost:wght@400;500;600;700&family=Raleway:wght@300;400;500;600&display=swap" rel="stylesheet"><link rel="stylesheet" href="/s6.css?v='.$__v.'">'.(empty($_GET['pv'])?'<script src="/app6.js?v='.$__v.'" defer></script>':'').'</head><body id="top"'.(!empty($GLOBALS['BODY_CLASS'])?' class="'.esc($GLOBALS['BODY_CLASS']).'"':'').'>';
  if($g=setting('gtm_id')) echo '<noscript><iframe src="https://www.googletagmanager.com/ns.html?id='.esc($g).'" height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>';
  if($lang==='en') ob_start(); // el cuerpo se traduce al vaciar en site_scripts()
}

function site_header(){
  $pdo=cms_pdo();
  $nav=$pdo->query("SELECT * FROM menu_items WHERE menu='header' AND published=1 ORDER BY sort,id")->fetchAll();
  $sol=$pdo->query("SELECT slug,title_es,title_en FROM solutions WHERE published=1 AND in_menu=1 ORDER BY sort,id")->fetchAll();
  $loc=$pdo->query("SELECT slug,city_es,city_en,name FROM locations WHERE published=1 AND in_menu=1 ORDER BY sort,id")->fetchAll();
  echo '<header class="hdr" id="hdr"><div class="container hdr-in"><a href="/" class="hdr-logo"><img src="/img/logo-azul.svg" alt="Aldea"></a><nav class="hdr-nav" id="nav">';
  foreach($nav as $n){
    if($n['href']==='/lo-que-ofrecemos/'){
      echo '<div class="hdr-drop"><a href="/lo-que-ofrecemos/" data-es="'.esc($n['label_es']).'" data-en="'.esc($n['label_en']).'">'.esc($n['label_es']).'</a><span class="hdr-ar">&#9662;</span><div class="hdr-menu">';
      foreach($sol as $x) echo '<a href="/'.esc($x['slug']).'/" data-es="'.esc($x['title_es']).'" data-en="'.esc($x['title_en']?:$x['title_es']).'">'.esc($x['title_es']).'</a>';
      echo '</div></div>';
    } elseif($n['href']==='/ubicaciones/'){
      echo '<div class="hdr-drop"><a href="/ubicaciones/" data-es="'.esc($n['label_es']).'" data-en="'.esc($n['label_en']).'">'.esc($n['label_es']).'</a><span class="hdr-ar">&#9662;</span><div class="hdr-menu">';
      // El brief del Home pide "Ciudad - Sede" en el desplegable
      foreach($loc as $x){
        $sede=preg_replace('/^Aldea\s+/u','',(string)$x['name']);
        $es=$x['city_es'].($sede!==''?' — '.$sede:'');
        $en=($x['city_en']?:$x['city_es']).($sede!==''?' — '.$sede:'');
        echo '<a href="/'.esc($x['slug']).'/" data-es="'.esc($es).'" data-en="'.esc($en).'">'.esc($es).'</a>';
      }
      echo '<a href="/ubicaciones/" class="hdr-all" data-es="Ver todas las ubicaciones" data-en="See all locations">Ver todas las ubicaciones</a></div></div>';
    } else echo '<a href="'.esc($n['href']).'" data-es="'.esc($n['label_es']).'" data-en="'.esc($n['label_en']).'">'.esc($n['label_es']).'</a>';
  }
  $__l=site_lang();$__es=$GLOBALS['cur_es_path']??'/';$__en=$GLOBALS['cur_en_path']??'/en/';
  echo '</nav><div class="hdr-act"><div class="lang" id="lang" data-es-url="'.esc($__es).'" data-en-url="'.esc($__en).'"><button data-lang="es" class="'.($__l==='es'?'on':'').'">ES</button><span>/</span><button data-lang="en" class="'.($__l==='en'?'on':'').'">EN</button></div>';
  echo '<a href="/contacto/" class="btn btn-primary hdr-cta" data-es="Cotizar" data-en="Get a quote">Cotizar</a><button class="burger" id="burger" aria-label="Menu"><span></span><span></span><span></span></button></div></div></header>';
}
// $style='home' -> tarjeta simplificada: ciudad, nombre de la sede y un enlace (sin direccion ni precio).
// $cta_es/$cta_en permiten cambiar la etiqueta ("Ver sede", "Ver oficinas"...).
function loc_cards($exclude='',$style='',$cta_es='Ver sede',$cta_en='See location'){
  $locs=cms_pdo()->query("SELECT * FROM locations WHERE published=1 ORDER BY sort,id")->fetchAll();
  echo '<div class="loc-grid">';
  foreach($locs as $l){ if($l['slug']===$exclude)continue;
    $soon=$l['soon']?'<span class="locc-soon" data-es="Próximamente" data-en="Coming soon">Próximamente</span>':'';
    $img='<div class="locc-img"><img src="'.esc($l['hero_image']).'" alt="'.esc(($l['hero_image_alt']??'')?:$l['name']).'"><span class="locc-tag" data-es="'.esc($l['city_es']).'" data-en="'.esc($l['city_en']?:$l['city_es']).'">'.esc($l['city_es']).'</span>'.$soon.'</div>';
    if($style==='home'){
      echo '<a class="locc locc-simple reveal" href="/'.esc($l['slug']).'/">'.$img.'<div class="locc-b"><h3>'.esc($l['name']).'</h3><span class="arrow" data-es="'.esc($cta_es).' &rarr;" data-en="'.esc($cta_en?:$cta_es).' &rarr;">'.esc($cta_es).' &rarr;</span></div></a>';
      continue;
    }
    // Sin precio: los briefs eliminan los comparativos de precios por ciudad.
    echo '<a class="locc reveal" href="/'.esc($l['slug']).'/">'.$img.'<div class="locc-b"><h3>'.esc($l['name']).'</h3><p>'.esc(mb_strimwidth((string)$l['address_es'],0,80,'…')).'</p><span class="arrow" data-es="'.esc($cta_es).' &rarr;" data-en="'.esc($cta_en?:$cta_es).' &rarr;">'.esc($cta_es).' &rarr;</span></div></a>';
  }
  echo '</div>';
}
// URL de la landing de Oficinas Corporativas (editable en Ajustes con la clave corp_url)
function corp_url(){ return setting('corp_url','/oficinas-personalizadas/'); }
function site_footer(){
  $pdo=cms_pdo();
  $sol=$pdo->query("SELECT slug,title_es,title_en FROM solutions WHERE published=1 AND in_menu=1 ORDER BY sort,id LIMIT 4")->fetchAll();
  $loc=$pdo->query("SELECT slug,city_es,city_en FROM locations WHERE published=1 ORDER BY sort,id")->fetchAll();
  $leg=$pdo->query("SELECT * FROM menu_items WHERE menu='footer' AND published=1 ORDER BY sort,id")->fetchAll();
  echo '<footer class="ftr"><div class="container ftr-grid ftr-grid-4">';
  echo '<div class="ftr-brand"><img src="/img/logo-blanco.svg" alt="Aldea" class="ftr-logo"><p data-es="Oficinas en renta y coworking. Trabaja a tu manera." data-en="Offices for rent and coworking. Work your way.">Oficinas en renta y coworking. Trabaja a tu manera.</p></div>';
  echo '<div class="ftr-col"><h4 data-es="Espacios de trabajo" data-en="Workspaces">Espacios de trabajo</h4>';
  foreach($sol as $s) echo '<a href="/'.esc($s['slug']).'/" data-es="'.esc($s['title_es']).'" data-en="'.esc($s['title_en']?:$s['title_es']).'">'.esc($s['title_es']).'</a>';
  echo '</div>';
  echo '<div class="ftr-col"><h4 data-es="Ubicaciones" data-en="Locations">Ubicaciones</h4>';
  foreach($loc as $l) echo '<a href="/'.esc($l['slug']).'/" data-es="'.esc($l['city_es']).'" data-en="'.esc($l['city_en']?:$l['city_es']).'">'.esc($l['city_es']).'</a>';
  echo '</div>';
  echo '<div class="ftr-col"><h4>Aldea</h4>'
    .'<a href="'.esc(corp_url()).'" data-es="Oficinas Corporativas" data-en="Corporate Offices">Oficinas Corporativas</a>'
    .'<a href="/acerca-de-aldea/" data-es="Acerca de Aldea" data-en="About Aldea">Acerca de Aldea</a>'
    .'<a href="/contacto/" data-es="Contacto" data-en="Contact">Contacto</a>'
    .'<a href="/blog/">Blog</a></div>';
  echo '<div class="ftr-col"><h4>Legal</h4>';
  foreach($leg as $l) echo '<a href="'.esc($l['href']).'" data-es="'.esc($l['label_es']).'" data-en="'.esc($l['label_en']).'">'.esc($l['label_es']).'</a>';
  echo '</div></div><div class="container ftr-bot"><span>&copy; <span id="yr"></span> Aldea Networking. <span data-es="Todos los derechos reservados." data-en="All rights reserved.">Todos los derechos reservados.</span></span><span class="ftr-note" data-es="Sitio dinamico" data-en="Dynamic site">Sitio dinamico</span></div></footer>';
}
function site_scripts(){ if(site_lang()==='en'){ $h=ob_get_clean(); echo tr_en($h); } if(!empty($_GET['pv'])){ echo '<style>html,body{overflow:visible !important;height:auto !important}.reveal{opacity:1 !important;transform:none !important}[data-pv]{scroll-margin-top:84px}[data-pv].pv-flash{outline:3px solid #e0a13c;outline-offset:6px;border-radius:10px;transition:outline .15s}</style><script>window.addEventListener("message",function(e){var d=e.data||{};if(d&&d.aldeaPv){var el=document.querySelector("[data-pv=\x27"+d.aldeaPv+"\x27]")||document.querySelector("[data-pv]");if(el){el.scrollIntoView({behavior:"smooth",block:"start"});el.classList.add("pv-flash");setTimeout(function(){el.classList.remove("pv-flash");},1700);}}},false);</script>'; }
  echo '</body></html>'; }
// $cta_es vacio => el hero se dibuja sin boton (lo pide el brief de Acerca de Aldea)
function banner($crumb,$chip,$h1es,$h1en,$lees,$leen,$img,$cta_es='Cotizar',$cta_en='Get a quote',$cta_href='/contacto/'){
  $cta = trim((string)$cta_es)!==''
    ? '<div class="hero-cta" style="margin-top:1.4rem"><a href="'.esc($cta_href?:'/contacto/').'" class="btn btn-accent" data-es="'.esc($cta_es).'" data-en="'.esc($cta_en?:$cta_es).'">'.esc($cta_es).'</a></div>'
    : '';
  echo '<section class="subhero" id="pv-hero" data-pv="hero"><div class="container subhero-in"><div class="subhero-copy reveal"><div class="crumb">'.$crumb.'</div><span class="chip" data-es="'.esc($chip).'" data-en="'.esc($chip).'">'.esc($chip).'</span><h1 data-es="'.esc($h1es).'" data-en="'.esc($h1en).'">'.esc($h1es).'</h1><p class="lead" data-es="'.esc($lees).'" data-en="'.esc($leen).'">'.esc($lees).'</p>'.$cta.'</div><div class="subhero-media reveal"><span class="subhero-blob"></span><img src="'.(strpos($img,"/")===0?esc($img):"/img/".esc($img).".webp").'" alt=""></div></div></section>';
}
// $tes/$ten: titulo editable (el Home lo manda desde el bloque clients.title). $limit: maximo de logos (0 = todos)
function render_clients($tes='',$ten='',$limit=0){
  $sql="SELECT * FROM clients WHERE published=1 ORDER BY sort,id".($limit>0?" LIMIT ".(int)$limit:"");
  $cl=cms_pdo()->query($sql)->fetchAll();
  $L='<svg viewBox="0 0 24 24"><path d="M15 18l-6-6 6-6"/></svg>'; $R='<svg viewBox="0 0 24 24"><path d="M9 6l6 6-6 6"/></svg>';
  if($tes==='')$tes='Empresas que ya confian en Aldea';
  if($ten==='')$ten='Companies that already trust Aldea';
  echo '<section class="clients" id="clientes"><div class="container"><p class="clients-t reveal" data-es="'.esc($tes).'" data-en="'.esc($ten).'" data-blk="clients.title">'.esc($tes).'</p>';
  echo '<div class="car clients-car reveal" data-car data-auto><button class="car-arw car-prev" data-prev aria-label="Anterior">'.$L.'</button><div class="car-track clients-track" data-track>';
  foreach($cl as $c) echo '<span class="client-chip"><img class="clg" src="'.esc($c['logo']).'" alt="'.esc(($c['logo_alt']??'')?:$c['name']).'" loading="lazy"></span>';
  echo '</div><button class="car-arw car-next" data-next aria-label="Siguiente">'.$R.'</button></div></div></section>';
}
function block_styles($pid){
  $css='';
  foreach(cms_pdo()->query("SELECT section,skey,meta FROM blocks WHERE page_id=".(int)$pid." AND meta IS NOT NULL AND meta<>''") as $r){
    $m=json_decode($r['meta'],true); if(!is_array($m))continue;
    $sel='[data-blk="'.$r['section'].'.'.$r['skey'].'"]'; $d='';
    $clean=function($v){ return preg_replace('/[^#a-zA-Z0-9(),.%\s]/','',(string)$v); };
    if(!empty($m['color']))$d.='color:'.$clean($m['color']).' !important;';
    if(!empty($m['bg']))$d.='background:'.$clean($m['bg']).' !important;border-color:'.$clean($m['bg']).' !important;';
    if(!empty($m['size'])){ $sz=['pequeno'=>'.85em','grande'=>'1.22em','xl'=>'1.5em']; if(isset($sz[$m['size']]))$d.='font-size:'.$sz[$m['size']].' !important;'; }
    if(!empty($m['align'])&&in_array($m['align'],['left','center','right']))$d.='text-align:'.$m['align'].' !important;';
    if(!empty($m['radius'])){ $rd=['cuadrado'=>'4px','redondo'=>'16px','pildora'=>'999px']; if(isset($rd[$m['radius']]))$d.='border-radius:'.$rd[$m['radius']].' !important;'; }
    if($d!=='')$css.=$sel.'{'.$d.'}';
  }
  return $css!==''?'<style id="blkstyles">'.$css.'</style>':'';
}
function gblk(){ static $m=null; if($m===null){ $m=[]; $pid=cms_pdo()->query("SELECT id FROM pages WHERE slug='__global'")->fetchColumn(); if($pid) foreach(cms_pdo()->query("SELECT section,skey,value_es,value_en,href FROM blocks WHERE page_id=".(int)$pid) as $r)$m[$r['section'].'.'.$r['skey']]=$r; } return $m; }
function gv($k,$d=''){ $m=gblk(); return isset($m[$k])&&$m[$k]['value_es']!==''&&$m[$k]['value_es']!==null?$m[$k]['value_es']:$d; }
function gvn($k,$d=''){ $m=gblk(); return isset($m[$k])&&$m[$k]['value_en']!==''&&$m[$k]['value_en']!==null?$m[$k]['value_en']:gv($k,$d); }
function gh($k,$d=''){ $m=gblk(); return isset($m[$k])&&$m[$k]['href']!==''&&$m[$k]['href']!==null?$m[$k]['href']:$d; }
function amen_defaults(){ return [['wifi','Internet','Internet'],['furniture','Mobiliario','Furniture'],['sparkle','Limpieza','Cleaning'],['pin','Recepción','Reception'],['shield','Seguridad','Security'],['users','Salas de juntas','Meeting rooms'],['heart','Áreas comunes','Common areas'],['coffee','Café y bebidas','Coffee & drinks'],['box','Paquetería','Parcel handling'],['support','Soporte','Support']]; }
function render_benefits(){
  $icons=array('<path d="M20 6 9 17l-5-5"/>','<circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 2"/>','<path d="M20.8 5.6a5.5 5.5 0 0 0-7.8 0L12 6.6l-1-1a5.5 5.5 0 0 0-7.8 7.8l1 1L12 21l7.8-7.6 1-1a5.5 5.5 0 0 0 0-7.8z"/>');
  $def=array(array('Todo incluido','All included','Internet, salas, cafe, limpieza y mas, sin costos ocultos.','Internet, rooms, coffee, cleaning and more, with no hidden costs.'),array('Contratos flexibles','Flexible terms','Escala tu espacio segun crece tu equipo, sin ataduras.','Scale your space as your team grows, with no strings attached.'),array('Atencion personalizada','Personalized service','Un equipo pendiente de ti cada dia, con recepcion y soporte.','A team that looks out for you every day, with reception and support.'));
  echo '<section class="section bg-soft"><div class="container"><div class="benefits reveal">';
  foreach($def as $i=>$d){ $n=$i+1;
    $tes=gv("benefits.ben{$n}_title",$d[0]); $ten=gvn("benefits.ben{$n}_title",$d[1]);
    $pes=gv("benefits.ben{$n}_text",$d[2]); $pen=gvn("benefits.ben{$n}_text",$d[3]);
    echo '<div class="benefit"><div class="bico"><svg viewBox="0 0 24 24">'.$icons[$i].'</svg></div><h3 data-es="'.esc($tes).'" data-en="'.esc($ten).'">'.esc($tes).'</h3><p data-es="'.esc($pes).'" data-en="'.esc($pen).'">'.esc($pes).'</p></div>'; }
  echo '</div></div></section>';
}
function render_cta(){
  $tes=gv('cta.cta_titulo','Encuentra tu espacio ideal en Aldea'); $ten=gvn('cta.cta_titulo','Find your ideal space at Aldea');
  $pes=gv('cta.cta_texto','Cuéntanos qué necesita tu equipo y te ayudamos a encontrar el espacio adecuado en la sede que mejor te convenga.'); $pen=gvn('cta.cta_texto','Tell us what your team needs and we will help you find the right space at the location that suits you best.');
  $bes=gv('cta.cta_boton','Cotizar'); $ben=gvn('cta.cta_boton','Get a quote'); $href=gh('cta.cta_boton','/contacto/');
  echo '<section class="section"><div class="container"><div class="ctaband reveal"><h2 data-es="'.esc($tes).'" data-en="'.esc($ten).'">'.esc($tes).'</h2><p data-es="'.esc($pes).'" data-en="'.esc($pen).'">'.esc($pes).'</p><a href="'.esc($href).'" class="btn btn-accent" data-es="'.esc($bes).'" data-en="'.esc($ben).'">'.esc($bes).'</a></div></div></section>';
}
function render_amenities($pid=null){
  if($pid===null)$pid=cms_pdo()->query("SELECT id FROM pages WHERE slug=''")->fetchColumn();
  $st=cms_pdo()->prepare("SELECT skey,value_es,value_en FROM blocks WHERE page_id=? AND section='amenidades'"); $st->execute([$pid]);
  $m=[]; foreach($st as $r)$m[$r['skey']]=$r;
  echo '<div class="amen-grid reveal">';
  foreach(amen_defaults() as $i=>$a){ $k=$i+1; $ic=$m["amen{$k}_icon"]['value_es']??$a[0]; $es=$m["amen{$k}_text"]['value_es']??$a[1]; $en=($m["amen{$k}_text"]['value_en']??'')?:$a[2];
    echo '<div class="amen"><i>'.render_icon($ic).'</i><span data-es="'.esc($es).'" data-en="'.esc($en).'" data-blk="amenidades.amen'.$k.'_text">'.esc($es).'</span></div>'; }
  echo '</div>';
}
function render_tech($city){
  $sub=str_replace('{ciudad}',$city,gv('tech.lead','Tu trabajo merece una infraestructura solida para trabajar sin interrupciones en {ciudad}.'));
  $suben=str_replace('{ciudad}',$city,gvn('tech.lead','Your work deserves solid infrastructure to work without interruptions in {ciudad}.'));
  echo '<section class="section bg-soft"><div class="container"><div class="sec-head reveal"><span class="chip" data-es="'.esc(gv('tech.chip','Tecnologia')).'" data-en="'.esc(gvn('tech.chip','Technology')).'">'.esc(gv('tech.chip','Tecnologia')).'</span>';
  echo '<h2 data-es="'.esc(gv('tech.title','Tecnologia confiable en cada espacio')).'" data-en="'.esc(gvn('tech.title','Reliable technology in every space')).'">'.esc(gv('tech.title','Tecnologia confiable en cada espacio')).'</h2>';
  echo '<p class="lead" data-es="'.esc($sub).'" data-en="'.esc($suben).'">'.esc($sub).'</p></div><div class="mini-grid reveal">';
  for($i=1;$i<=7;$i++){ $lb=gv("tech.tech{$i}_label"); if($lb==='')continue; $ic=gv("tech.tech{$i}_icon",'wifi'); $lben=gvn("tech.tech{$i}_label",$lb);
    echo '<div class="mini-card"><i class="mc-ic">'.render_icon($ic).'</i><span data-es="'.esc($lb).'" data-en="'.esc($lben).'">'.esc($lb).'</span></div>'; }
  echo '</div></div></section>';
}
function render_loc_contact($city,$slug){
  $lead=str_replace('{ciudad}',$city,gv('contacto.lead','Un asesor te contactara para mostrarte las opciones en {ciudad}.'));
  $leaden=str_replace('{ciudad}',$city,gvn('contacto.lead','An advisor will contact you to show options in {ciudad}.'));
  $ph=gv('contacto.phone','+52 449 454 0709'); $phh=gh('contacto.phone','tel:+524494540709');
  $em=gv('contacto.email','contacto@aldea.work'); $emh=gh('contacto.email','mailto:contacto@aldea.work');
  echo '<section class="section bg-soft" id="contacto"><div class="container contact-in"><div class="contact-copy reveal"><span class="chip">Contacto</span>';
  echo '<h2 data-es="'.esc(gv('contacto.title','Dejanos ayudarte a encontrar tu oficina')).'" data-en="'.esc(gvn('contacto.title','Let us help you find your office')).'">'.esc(gv('contacto.title','Dejanos ayudarte a encontrar tu oficina')).'</h2>';
  echo '<p class="lead" data-es="'.esc($lead).'" data-en="'.esc($leaden).'">'.esc($lead).'</p>';
  echo '<p class="contact-phone"><span data-es="O marcanos al" data-en="Or call us at">O marcanos al</span> <a href="'.esc($phh).'">'.esc($ph).'</a></p>';
  echo '<p class="contact-phone"><span data-es="O escribenos a" data-en="Or email us at">O escribenos a</span> <a href="'.esc($emh).'">'.esc($em).'</a></p></div>';
  echo '<form class="contact-form reveal" onsubmit="return aldeaSubmit(event)" data-source="'.esc($slug).'">'
    .'<input name="name" type="text" required placeholder="Nombre" data-ph-es="Nombre" data-ph-en="Name"/>'
    .'<input name="email" type="email" required placeholder="Correo electronico" data-ph-es="Correo electronico" data-ph-en="Email"/>'
    .'<input name="phone" type="tel" placeholder="Telefono" data-ph-es="Telefono" data-ph-en="Phone"/>'
    .'<textarea name="message" rows="4" placeholder="Que estas buscando?" data-ph-es="Que estas buscando?" data-ph-en="What are you looking for?"></textarea>'
    .'<button type="submit" class="btn btn-accent w" data-es="Enviar" data-en="Send">Enviar</button>'
    .'<small id="formMsg" data-es="Al enviar aceptas nuestras politicas de privacidad." data-en="By submitting you accept our privacy policy.">Al enviar aceptas nuestras politicas de privacidad.</small></form></div></section>';
}
function fmt_date($d){ $m=['01'=>'ene','02'=>'feb','03'=>'mar','04'=>'abr','05'=>'may','06'=>'jun','07'=>'jul','08'=>'ago','09'=>'sep','10'=>'oct','11'=>'nov','12'=>'dic']; if(!$d)return ''; $p=explode('-',substr($d,0,10)); if(count($p)<3)return $d; return intval($p[2]).' '.($m[$p[1]]??$p[1]).' '.$p[0]; }
