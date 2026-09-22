<?php
// Plantilla generica para paginas simples/legales (lee de blocks)
require_once __DIR__.'/site.php';
if(!isset($pg)||!$pg){ $slug=trim(parse_url($_SERVER['REQUEST_URI'],PHP_URL_PATH),'/'); $st=cms_pdo()->prepare("SELECT * FROM pages WHERE slug=? AND published=1"); $st->execute([$slug]); $pg=$st->fetch(); }
if(!$pg){ http_response_code(404); echo '<h1>404</h1>'; return; }
$B=[]; $BS=[];
foreach(cms_pdo()->query("SELECT * FROM blocks WHERE page_id=".(int)$pg['id']) as $r){ $B[$r['skey']]=$r; $BS[$r['section'].'.'.$r['skey']]=$r; }
// Una pagina puede pedir una plantilla propia con el bloque page.plantilla
if(isset($BS['page.plantilla'])){
  $__pl=preg_replace('/[^a-z0-9_-]/','',strtolower((string)$BS['page.plantilla']['value_es']));
  $__f=__DIR__.'/tpl_'.$__pl.'.php';
  if($__pl!=='' && is_file($__f)){ $PB=$BS; include $__f; return; }
}
function pgv($B,$k,$f=''){ return isset($B[$k])?$B[$k]['value_es']:$f; }
function pgvn($B,$k,$f=''){ return isset($B[$k])&&$B[$k]['value_en']!==null&&$B[$k]['value_en']!==''?$B[$k]['value_en']:pgv($B,$k,$f); }
// helper: elemento bilingue (texto plano) con swap data-es/data-en
function bl($tag,$B,$k,$attrs=''){ if(!isset($B[$k]))return '';
  $es=trim(strip_tags((string)$B[$k]['value_es'])); $en=trim(strip_tags((string)($B[$k]['value_en']!==''?$B[$k]['value_en']:$B[$k]['value_es'])));
  return '<'.$tag.' '.$attrs.' data-es="'.esc($es).'" data-en="'.esc($en).'">'.esc($es).'</'.$tag.'>'; }
// Preguntas frecuentes desde campos faqN_title / faqN_text
function page_faq($B){
  $items=[]; for($i=1;$i<=40;$i++){ if(isset($B["faq{$i}_title"])) $items[]=$i; }
  if(!$items) return false;
  echo '<section class="section"><div class="container"><div class="faq reveal">';
  foreach($items as $i){
    $q=$B["faq{$i}_title"]; $a=$B["faq{$i}_text"]??null;
    $qes=trim(strip_tags((string)$q['value_es'])); $qen=trim(strip_tags((string)($q['value_en']?:$q['value_es'])));
    $aes=$a?trim(strip_tags((string)$a['value_es'])):''; $aen=$a?trim(strip_tags((string)($a['value_en']?:$a['value_es']))):'';
    echo '<details class="reveal"><summary data-es="'.esc($qes).'" data-en="'.esc($qen).'">'.esc($qes).'</summary><p data-es="'.esc($aes).'" data-en="'.esc($aen).'">'.esc($aes).'</p></details>';
  }
  echo '</div></div></section>';
  return true;
}
// CTA opcional al final (cta_titulo / cta_texto / cta_boton[href])
function page_cta($B){
  if(!isset($B['cta_titulo'])) return;
  echo '<section class="section bg-soft"><div class="container center reveal" style="max-width:640px">';
  echo bl('h2',$B,'cta_titulo',' class="an-cta-h" style="margin-bottom:.6rem"');
  echo bl('p',$B,'cta_texto',' class="lead" style="margin-bottom:1.4rem"');
  if(isset($B['cta_boton'])){ $b=$B['cta_boton']; $es=esc(trim(strip_tags($b['value_es']))); $en=esc(trim(strip_tags($b['value_en']?:$b['value_es']))); $href=esc($b['href']?:'/contacto/');
    echo '<a class="btn btn-accent" href="'.$href.'" data-es="'.$es.'" data-en="'.$en.'">'.$es.'</a>'; }
  echo '</div></section>';
}
// Acerca de Aldea — orden del brief: numeros, personas, valores, galeria.
// Cada seccion se dibuja solo si tiene contenido, asi que se vacia desde el panel.
function page_about($B){
  if(!isset($B['int_titulo'])) return false;

  // --- 1) Aldea en numeros ---
  $stats=[]; for($i=1;$i<=12;$i++){ if(isset($B["stat{$i}_title"]) && trim(strip_tags((string)$B["stat{$i}_title"]['value_es']))!=='') $stats[]=$i; }
  if($stats){
    echo '<section class="section" id="numeros"><div class="container">';
    $head=bl('span',$B,'stats_chip',' class="chip"').bl('h2',$B,'stats_titulo','');
    if(trim($head)!=='') echo '<div class="sec-head center reveal">'.$head.'</div>';
    echo '<div class="stats stats-'.count($stats).' reveal">';
    foreach($stats as $i){ $n=$B["stat{$i}_title"]; $l=$B["stat{$i}_text"]??null;
      $nes=esc(trim(strip_tags($n['value_es']))); $nen=esc(trim(strip_tags($n['value_en']?:$n['value_es'])));
      $les=$l?esc(trim(strip_tags($l['value_es']))):''; $len=$l?esc(trim(strip_tags($l['value_en']?:$l['value_es']))):'';
      echo '<div class="stat"><b data-es="'.$nes.'" data-en="'.$nen.'">'.$nes.'</b><span data-es="'.$les.'" data-en="'.$len.'">'.$les.'</span></div>'; }
    echo '</div></div></section>';
  }

  // --- 2) Las personas son lo mas importante ---
  echo '<section class="section bg-soft" id="personas"><div class="container split reveal">';
  echo '<img src="'.esc(pgv($B,'int_img','/img/about.webp')).'" alt="'.esc(pgv($B,'int_img_alt','Equipo de Aldea')).'"/>';
  echo '<div>';
  echo bl('span',$B,'int_chip',' class="chip"');
  echo bl('h2',$B,'int_titulo',' style="margin-top:.8rem"');
  echo bl('p',$B,'int_texto','');
  if(isset($B['int_boton']) && trim(strip_tags((string)$B['int_boton']['value_es']))!==''){
    $b=$B['int_boton']; $es=esc(trim(strip_tags($b['value_es']))); $en=esc(trim(strip_tags($b['value_en']?:$b['value_es'])));
    echo '<a class="btn btn-primary" href="'.esc($b['href']?:'/contacto/').'" data-es="'.$es.'" data-en="'.$en.'">'.$es.'</a>'; }
  echo '</div></div></section>';

  // --- 3) Nuestros valores (solo frase + nombre del valor) ---
  $vals=[]; for($i=1;$i<=20;$i++){ if(isset($B["val{$i}_title"]) && trim(strip_tags((string)$B["val{$i}_title"]['value_es']))!=='') $vals[]=$i; }
  if($vals){
    echo '<section class="section" id="valores"><div class="container"><div class="sec-head center reveal"><span class="chip" data-es="Valores" data-en="Values">Valores</span><h2 data-es="Nuestros valores" data-en="Our values">Nuestros valores</h2></div><div class="vals-grid">';
    foreach($vals as $i){ $t=$B["val{$i}_title"]; $d=$B["val{$i}_text"]??null;
      $tes=esc(trim(strip_tags($t['value_es']))); $ten=esc(trim(strip_tags($t['value_en']?:$t['value_es'])));
      $des=$d?esc(trim(strip_tags($d['value_es']))):''; $den=$d?esc(trim(strip_tags($d['value_en']?:$d['value_es']))):'';
      echo '<article class="val-card reveal"><h3 data-es="'.$tes.'" data-en="'.$ten.'">'.$tes.'</h3>'
          .($des!==''?'<span class="val-name" data-es="'.$des.'" data-en="'.$den.'">'.$des.'</span>':'')
          .'</article>'; }
    echo '</div></div></section>';
  }

  // --- 4) Asi se vive Aldea (galeria, sin CTA) ---
  $gals=[]; for($i=1;$i<=8;$i++){ if(isset($B["gal{$i}"]) && trim((string)$B["gal{$i}"]['value_es'])!=='') $gals[]=$i; }
  if($gals){
    echo '<section class="section bg-soft" id="galeria"><div class="container">';
    $gh=bl('span',$B,'gal_chip',' class="chip"').bl('h2',$B,'gal_titulo','').bl('p',$B,'gal_texto',' class="lead"');
    if(trim($gh)!=='') echo '<div class="sec-head center reveal">'.$gh.'</div>';
    echo '<div class="gal-grid reveal">';
    foreach($gals as $i){
      $src=esc(trim((string)$B["gal{$i}"]['value_es']));
      $alt=esc(trim(strip_tags((string)($B["gal{$i}"]['value_en'] ?? '')))); // el campo EN se usa como texto alternativo
      echo '<figure><img src="'.$src.'" alt="'.$alt.'" loading="lazy"></figure>'; }
    echo '</div></div></section>';
  }
  return true;
}

// Contacto: info + formulario (estructural) + sedes (desde modulo Ubicaciones)
function page_contact($B){
  if(!isset($B['write_titulo'])) return false;
  echo '<section class="section"><div class="container contact-in">';
  echo '<div class="contact-copy reveal">';
  echo bl('h2',$B,'write_titulo','');
  echo bl('p',$B,'write_texto',' class="lead"');
  if(isset($B['tel_num'])){ $tel=trim(strip_tags($B['tel_num']['value_es'])); echo '<p class="contact-phone"><span data-es="Teléfono" data-en="Phone">Teléfono</span> <a href="tel:'.esc(preg_replace('/[^0-9+]/','',$tel)).'">'.esc($tel).'</a></p>'; }
  if(isset($B['email_val'])){ $em=trim(strip_tags($B['email_val']['value_es'])); echo '<p class="contact-phone">Email <a href="mailto:'.esc($em).'">'.esc($em).'</a></p>'; }
  echo '</div>';
  echo '<form class="contact-form reveal" onsubmit="return aldeaSubmit(event)" data-source="contacto">';
  echo '<input name="name" type="text" required placeholder="Nombre" data-ph-es="Nombre" data-ph-en="Name">';
  echo '<input name="email" type="email" required placeholder="Correo electronico" data-ph-es="Correo electronico" data-ph-en="Email">';
  echo '<input name="phone" type="tel" placeholder="Telefono" data-ph-es="Telefono" data-ph-en="Phone">';
  echo '<textarea name="message" rows="4" placeholder="Que estas buscando?" data-ph-es="Que estas buscando?" data-ph-en="What are you looking for?"></textarea>';
  echo '<button type="submit" class="btn btn-accent w" data-es="Enviar" data-en="Send">Enviar</button>';
  echo '<small id="formMsg" data-es="Al enviar aceptas nuestras politicas de privacidad." data-en="By submitting you accept our privacy policy.">Al enviar aceptas nuestras politicas de privacidad.</small>';
  echo '</form>';
  echo '</div></section>';
  echo '<section class="section bg-soft"><div class="container"><div class="sec-head reveal"><span class="chip" data-es="Ubicaciones" data-en="Locations">Ubicaciones</span><h2 data-es="Visitanos" data-en="Visit us">Visitanos</h2></div>';
  if(function_exists('loc_cards')) loc_cards();
  echo '</div></section>';
  return true;
}

$title=$pg['seo_title_es']?:$pg['title_es'].' | Aldea Networking';
$title_en=$pg['seo_title_en']?:(($pg['title_en']?:$pg['title_es']).' | Aldea Networking');
site_head($title,$pg['seo_desc_es'],'/'.$pg['slug'].'/',(bool)$pg['noindex'],$title_en,$pg['seo_desc_en']);
site_header();
echo '<main>';
$crumb='<a href="/" data-es="Inicio" data-en="Home">Inicio</a> / <span data-es="'.esc($pg['title_es']).'" data-en="'.esc($pg['title_en']?:$pg['title_es']).'">'.esc($pg['title_es']).'</span>';
// El boton del hero se controla con el bloque hero_cta: vacio = sin boton.
banner($crumb, pgv($B,'chip',$pg['title_es']), pgv($B,'h1',$pg['title_es']), pgvn($B,'h1',$pg['title_es']), pgv($B,'lead'), pgvn($B,'lead'), pgv($B,'hero_img','/img/sala.webp'),
       pgv($B,'hero_cta','Cotizar'), pgvn($B,'hero_cta','Get a quote'), (isset($B['hero_cta']) && $B['hero_cta']['href']) ? $B['hero_cta']['href'] : '/contacto/');
// cuerpo: si hay campos estructurados (FAQ) usarlos; si no, el bloque body (legales)
echo '<div id="pv-body" data-pv="body">';
$rendered = page_about($B);
if(!$rendered) $rendered = page_contact($B);
if(!$rendered) $rendered = page_faq($B);
if($rendered){ page_cta($B); }
elseif(isset($B['body'])){ echo $B['body']['value_es']; }
echo '</div>';
echo '</main>';
site_footer(); site_scripts();
