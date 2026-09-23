<?php
// Plantilla generica para paginas simples/legales (lee de blocks)
// Rediseno 2026-09: banner a sangre, textos a la izquierda y sin etiquetas sobre los titulos.
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
function pghas($B,$k){ return isset($B[$k]) && trim(strip_tags((string)$B[$k]['value_es']))!==''; }
// helper: elemento bilingue (texto plano) con swap data-es/data-en
function bl($tag,$B,$k,$attrs=''){ if(!isset($B[$k]))return '';
  $es=trim(strip_tags((string)$B[$k]['value_es'])); $en=trim(strip_tags((string)($B[$k]['value_en']!==''?$B[$k]['value_en']:$B[$k]['value_es'])));
  if($es==='') return '';
  return '<'.$tag.' '.$attrs.' data-es="'.esc($es).'" data-en="'.esc($en).'">'.esc($es).'</'.$tag.'>'; }
// Preguntas frecuentes desde campos faqN_title / faqN_text
function page_faq($B){
  $items=[]; for($i=1;$i<=40;$i++){ if(isset($B["faq{$i}_title"])) $items[]=$i; }
  if(!$items) return false;
  echo '<section class="section"><div class="container"><div class="faq faq-solo reveal">';
  foreach($items as $i){
    $q=$B["faq{$i}_title"]; $a=$B["faq{$i}_text"]??null;
    $qes=trim(strip_tags((string)$q['value_es'])); $qen=trim(strip_tags((string)($q['value_en']?:$q['value_es'])));
    $aes=$a?trim(strip_tags((string)$a['value_es'])):''; $aen=$a?trim(strip_tags((string)($a['value_en']?:$a['value_es']))):'';
    echo '<details><summary data-es="'.esc($qes).'" data-en="'.esc($qen).'">'.esc($qes).'</summary><p data-es="'.esc($aes).'" data-en="'.esc($aen).'">'.esc($aes).'</p></details>';
  }
  echo '</div></div></section>';
  return true;
}
// CTA opcional al final (cta_titulo / cta_texto / cta_boton[href])
function page_cta($B){
  if(!pghas($B,'cta_titulo')) return;
  echo '<section class="section bg-soft"><div class="container"><div class="cta-row reveal"><div>';
  echo bl('h2',$B,'cta_titulo','');
  echo bl('p',$B,'cta_texto',' class="lead"');
  echo '</div>';
  if(pghas($B,'cta_boton')){ $b=$B['cta_boton']; $es=esc(trim(strip_tags($b['value_es']))); $en=esc(trim(strip_tags($b['value_en']?:$b['value_es']))); $href=esc($b['href']?:'/contacto/');
    echo '<a class="btn btn-accent" href="'.$href.'" data-es="'.$es.'" data-en="'.$en.'">'.$es.'</a>'; }
  echo '</div></div></section>';
}
// Acerca de Aldea — orden del brief: numeros, personas, valores, galeria.
// Cada seccion se dibuja solo si tiene contenido, asi que se vacia desde el panel.
function page_about($B){
  if(!isset($B['int_titulo'])) return false;

  // --- 1) Aldea en numeros: columnas con divisor ---
  $stats=[]; for($i=1;$i<=12;$i++){ if(pghas($B,"stat{$i}_title")) $stats[]=$i; }
  if($stats){
    echo '<section class="section" id="numeros"><div class="container">';
    $head=bl('h2',$B,'stats_titulo','');
    if(trim($head)!=='') echo '<div class="sec-head reveal">'.$head.'</div>';
    echo '<div class="nums2 reveal" style="--n:'.count($stats).'">';
    foreach($stats as $i){ $n=$B["stat{$i}_title"]; $l=$B["stat{$i}_text"]??null;
      $nes=esc(trim(strip_tags($n['value_es']))); $nen=esc(trim(strip_tags($n['value_en']?:$n['value_es'])));
      $les=$l?esc(trim(strip_tags($l['value_es']))):''; $len=$l?esc(trim(strip_tags($l['value_en']?:$l['value_es']))):'';
      echo '<div><b data-es="'.$nes.'" data-en="'.$nen.'">'.$nes.'</b><span data-es="'.$les.'" data-en="'.$len.'">'.$les.'</span></div>'; }
    echo '</div></div></section>';
  }

  // --- 2) Las personas son lo mas importante ---
  echo '<section class="section bg-soft" id="personas"><div class="container duo reveal">';
  echo '<figure class="duo-media">'.pic(pgv($B,'int_img','/img/about.webp'),pgv($B,'int_img_alt','Equipo de Aldea'),'(max-width:900px) 100vw, 58vw','loading="lazy"').'</figure>';
  echo '<div class="duo-copy">';
  echo bl('h2',$B,'int_titulo','');
  echo bl('p',$B,'int_texto','');
  if(pghas($B,'int_boton')){
    $b=$B['int_boton']; $es=esc(trim(strip_tags($b['value_es']))); $en=esc(trim(strip_tags($b['value_en']?:$b['value_es'])));
    echo '<div class="hero-cta"><a class="btn btn-primary" href="'.esc($b['href']?:'/contacto/').'" data-es="'.$es.'" data-en="'.$en.'">'.$es.'</a></div>'; }
  echo '</div></div></section>';

  // --- 3) Nuestros valores: la frase manda y el nombre del valor la acompana ---
  $vals=[]; for($i=1;$i<=20;$i++){ if(pghas($B,"val{$i}_title")) $vals[]=$i; }
  if($vals){
    echo '<section class="section" id="valores"><div class="container"><div class="sec-head reveal"><h2 data-es="Nuestros valores" data-en="Our values">Nuestros valores</h2></div><ul class="vlist reveal">';
    foreach($vals as $i){ $t=$B["val{$i}_title"]; $d=$B["val{$i}_text"]??null;
      $tes=esc(trim(strip_tags($t['value_es']))); $ten=esc(trim(strip_tags($t['value_en']?:$t['value_es'])));
      $des=$d?esc(trim(strip_tags($d['value_es']))):''; $den=$d?esc(trim(strip_tags($d['value_en']?:$d['value_es']))):'';
      echo '<li><span data-es="'.$des.'" data-en="'.$den.'">'.$des.'</span><h3 data-es="'.$tes.'" data-en="'.$ten.'">'.$tes.'</h3></li>'; }
    echo '</ul></div></section>';
  }

  // --- 4) Asi se vive Aldea (galeria, sin CTA) ---
  $gals=[]; for($i=1;$i<=8;$i++){ if(pghas($B,"gal{$i}")) $gals[]=$i; }
  if($gals){
    $__root=$_SERVER['DOCUMENT_ROOT']??''; $items=[];
    foreach($gals as $i){ $u=trim((string)$B["gal{$i}"]['value_es']); $sm=preg_replace('/\.webp$/','-sm.webp',$u); $items[]=['tipo'=>'img','src'=>$u,'sm'=>($sm!==$u&&is_file($__root.$sm))?$sm:$u,'alt'=>trim(strip_tags((string)($B["gal{$i}"]['value_en']??'')))]; }
    $v=min(6,count($items));
    echo '<section class="section bg-soft" id="galeria" data-galeria=\''.esc(json_encode($items,JSON_UNESCAPED_SLASHES|JSON_UNESCAPED_UNICODE)).'\' data-titulo="'.esc(pgv($B,'gal_titulo','Así se vive Aldea')).'"><div class="container">';
    $gh=bl('h2',$B,'gal_titulo','').bl('p',$B,'gal_texto',' class="lead"');
    if(trim($gh)!=='') echo '<div class="sec-head reveal">'.$gh.'</div>';
    echo '<div class="mosaic m'.$v.' reveal">';
    for($k=0;$k<$v;$k++) echo '<figure><button type="button" data-i="'.$k.'" aria-label="Ampliar foto '.($k+1).'">'.pic($items[$k]['src'],$items[$k]['alt'],$k===0?'(max-width:760px) 100vw, 50vw':'(max-width:760px) 50vw, 25vw','loading="lazy"').'</button></figure>';
    echo '</div></div></section>';
  }
  return true;
}

// Contacto: formulario con foto + sedes (desde modulo Ubicaciones)
function page_contact($B){
  if(!isset($B['write_titulo'])) return false;
  echo '<section class="section"><div class="container"><div class="formx reveal">';
  echo '<figure class="formx-media">'.pic(pgv($B,'form_img','/img/sedes/slp/recepcion.webp'),'Recepción de Aldea','(max-width:900px) 100vw, 45vw','loading="lazy"').'</figure>';
  echo '<div class="formx-body">';
  echo bl('h2',$B,'write_titulo','');
  echo bl('p',$B,'write_texto',' class="lead"');
  echo '<form class="contact-form" onsubmit="return aldeaSubmit(event)" data-source="contacto" data-utm>';
  echo '<div class="cf-2"><input name="name" type="text" required placeholder="Nombre" data-ph-es="Nombre" data-ph-en="Name" autocomplete="name">';
  echo '<input name="email" type="email" required placeholder="Correo electrónico" data-ph-es="Correo electrónico" data-ph-en="Email" autocomplete="email"></div>';
  echo '<input name="phone" type="tel" placeholder="Teléfono" data-ph-es="Teléfono" data-ph-en="Phone" autocomplete="tel">';
  echo '<textarea name="message" rows="4" placeholder="¿Qué estás buscando?" data-ph-es="¿Qué estás buscando?" data-ph-en="What are you looking for?"></textarea>';
  echo '<button type="submit" class="btn btn-accent w" data-es="Enviar" data-en="Send">Enviar</button>';
  echo '<small id="formMsg" data-es="Al enviar aceptas nuestras políticas de privacidad." data-en="By submitting you accept our privacy policy.">Al enviar aceptas nuestras políticas de privacidad.</small>';
  echo '</form><div class="formx-alt">';
  if(pghas($B,'tel_num')){ $tel=trim(strip_tags($B['tel_num']['value_es'])); echo '<a href="tel:'.esc(preg_replace('/[^0-9+]/','',$tel)).'">'.esc($tel).'</a>'; }
  if(pghas($B,'email_val')){ $em=trim(strip_tags($B['email_val']['value_es'])); echo '<a href="mailto:'.esc($em).'">'.esc($em).'</a>'; }
  echo '</div></div></div></div></section>';
  echo '<section class="section bg-soft"><div class="container"><div class="sec-head reveal"><h2 data-es="Visítanos" data-en="Visit us">Visítanos</h2></div>';
  if(function_exists('loc_cards')) loc_cards();
  echo '</div></section>';
  return true;
}

$title=$pg['seo_title_es']?:$pg['title_es'].' | Aldea Networking';
$title_en=$pg['seo_title_en']?:(($pg['title_en']?:$pg['title_es']).' | Aldea Networking');
site_head($title,$pg['seo_desc_es'],'/'.$pg['slug'].'/',(bool)$pg['noindex'],$title_en,$pg['seo_desc_en']);
site_header();
jsonld_breadcrumbs([['Inicio','/'],[$pg['title_es'],'/'.$pg['slug'].'/']]);
echo '<main>';
// El boton del banner se controla con el bloque hero_cta: vacio = sin boton.
banner('', '', pgv($B,'h1',$pg['title_es']), pgvn($B,'h1',$pg['title_es']), pgv($B,'lead'), pgvn($B,'lead'), pgv($B,'hero_img','/img/sala.webp'),
       pgv($B,'hero_cta','Cotizar'), pgvn($B,'hero_cta','Get a quote'), (isset($B['hero_cta']) && $B['hero_cta']['href']) ? $B['hero_cta']['href'] : '/contacto/');
// cuerpo: si hay campos estructurados (FAQ) usarlos; si no, el bloque body (legales)
echo '<div id="pv-body" data-pv="body">';
$rendered = page_about($B);
if(!$rendered) $rendered = page_contact($B);
if(!$rendered) $rendered = page_faq($B);
if($rendered){ page_cta($B); }
elseif(isset($B['body'])){ echo $B['body']['value_es']; } // las legales ya traen su seccion y contenedor
echo '</div>';
echo '</main>';
site_footer(); site_scripts();
