<?php
/* Plantilla ampliada de solucion, dirigida por bloques.
   Se usa cuando existe una pagina oculta con slug "sol:<slug>" y bloques cargados.
   Si no existe, tpl_solution.php sigue usando el diseno generico de siempre.
   $sol y $SB (bloques indexados por "seccion.clave") vienen en scope.
   Rediseno 2026-09: banner a sangre, textos a la izquierda, listas sin cajas y
   fotos de la galeria repartidas en las secciones. */

function sv($k,$d=''){ global $SB; return isset($SB[$k]) && $SB[$k]['value_es']!==null && $SB[$k]['value_es']!=='' ? $SB[$k]['value_es'] : $d; }
function sn($k,$d=''){ global $SB; return isset($SB[$k]) && $SB[$k]['value_en']!==null && $SB[$k]['value_en']!=='' ? $SB[$k]['value_en'] : sv($k,$d); }
function sh_($k,$d=''){ global $SB; return isset($SB[$k]) && $SB[$k]['href']!==null && $SB[$k]['href']!=='' ? $SB[$k]['href'] : $d; }
function shas($k){ return trim(strip_tags((string)sv($k,'')))!==''; }
/* etiqueta bilingue lista para incrustar */
function sa($k,$d=''){ return 'data-es="'.esc(strip_tags(sv($k,$d))).'" data-en="'.esc(strip_tags(sn($k,$d))).'" data-blk="'.esc($k).'"'; }
function st($k,$d=''){ return esc(strip_tags(sv($k,$d))); }
/* lista de claves consecutivas con contenido: item1, item2... */
function slist($prefix,$max=12){ $out=[]; for($i=1;$i<=$max;$i++){ if(shas($prefix.$i)) $out[]=$prefix.$i; } return $out; }
/* lista con divisores e icono de palomita */
function srows($keys,$cols=1){ if(!$keys) return ''; $h='<ul class="rows" style="--cd:'.(int)$cols.'">'; foreach($keys as $k) $h.='<li>'.aldea_icon('check').'<span '.sa($k).'>'.st($k).'</span></li>'; return $h.'</ul>'; }

$imgs=json_decode($sol['gallery']?:'[]',true); if(!is_array($imgs)) $imgs=[];
$hero=$sol['hero_image']?:($imgs[0]??'/img/sol-privada.webp');
// Fotos para las secciones: de la galeria, sin repetir la del banner.
$__fotos=array_values(array_filter($imgs,function($u)use($hero){ return $u!==$hero; }));
$foto=function($i) use($__fotos,$hero){ return $__fotos? $__fotos[$i % count($__fotos)] : $hero; };
$titulo=$sol['title_es'];

site_head(($sol['seo_title_es']?:$titulo.' - Aldea Networking'),($sol['seo_desc_es']?:$sol['excerpt_es']),'/'.$sol['slug'].'/',false,(($sol['seo_title_en']?:($sol['title_en']?:$titulo)).' - Aldea Networking'),($sol['seo_desc_en']?:($sol['excerpt_en']?:'')));
site_header();
jsonld_breadcrumbs([['Inicio','/'],['Espacios de trabajo','/lo-que-ofrecemos/'],[$titulo,'/'.$sol['slug'].'/']]);
echo '<main>';

/* ---------- 1. BANNER ---------- */
$__in='<h1 '.sa('hero.h1',$titulo).'>'.st('hero.h1',$titulo).'</h1>';
if(shas('hero.lead')) $__in.='<p class="lead" '.sa('hero.lead').'>'.st('hero.lead').'</p>';
$__in.='<div class="hero-cta">';
if(shas('hero.cta1')) $__in.='<a href="'.esc(sh_('hero.cta1','#formulario')).'" class="btn btn-accent" '.sa('hero.cta1').'>'.st('hero.cta1').'</a>';
if(shas('hero.cta2')) $__in.='<a href="'.esc(sh_('hero.cta2','#incluye')).'" class="btn btn-clear" '.sa('hero.cta2').'>'.st('hero.cta2').'</a>';
$__in.='</div>';
page_hero($hero,($sol['hero_image_alt']??'')?:$titulo,$__in);

/* ---------- 2. EMPRESAS QUE TRABAJAN DESDE ALDEA ---------- */
if(shas('empresas.title')) render_clients(sv('empresas.title'),sn('empresas.title'),10);

/* ---------- 3. QUE ES ---------- */
if(shas('quees.title')){
  echo '<section class="section" id="quees"><div class="container duo reveal">';
  echo '<figure class="duo-media">'.pic(sv('quees.img',$foto(0)),strip_tags(sv('quees.img_alt',$titulo)),'(max-width:900px) 100vw, 58vw','loading="lazy"').'</figure>';
  echo '<div class="duo-copy"><h2 '.sa('quees.title').'>'.st('quees.title').'</h2>';
  echo '<p '.sa('quees.text').'>'.st('quees.text').'</p>';
  // El segundo parrafo del banner vive aqui: el banner se queda con titulo, texto y botones.
  if(shas('hero.lead2')) echo '<p '.sa('hero.lead2').'>'.st('hero.lead2').'</p>';
  if(shas('quees.priv_title')||shas('quees.shared_title')){
    // Cada lado admite una frase (priv_text / shared_text) o una lista (p1.. / s1..)
    $__pl=slist('quees.p',6); $__sl=slist('quees.s',6);
    $__card=function($tk,$txk,$items,$cls){
      $h='<div class="ps-card '.$cls.'"><b '.sa($tk).'>'.st($tk).'</b>';
      if($items){ $h.='<ul class="ps-list">'; foreach($items as $k) $h.='<li '.sa($k).'>'.st($k).'</li>'; $h.='</ul>'; }
      elseif(shas($txk)) $h.='<span '.sa($txk).'>'.st($txk).'</span>';
      return $h.'</div>';
    };
    echo '<div class="ps-grid">';
    if(shas('quees.priv_title'))   echo $__card('quees.priv_title','quees.priv_text',$__pl,'ps-priv');
    if(shas('quees.shared_title')) echo $__card('quees.shared_title','quees.shared_text',$__sl,
      strtolower(trim(sv('quees.shared_estilo','')))==='no' ? 'ps-no' : '');
    echo '</div>';
  }
  // Mensaje destacado opcional: sugiere otra solucion cuando encaja mejor
  if(shas('quees.destacado')){
    $__h=sh_('quees.destacado','');
    $__in2=render_icon('sparkle').'<span '.sa('quees.destacado').'>'.st('quees.destacado').'</span>';
    echo $__h ? '<a class="nota-cruzada" href="'.esc($__h).'">'.$__in2.'</a>' : '<p class="nota-cruzada">'.$__in2.'</p>';
  }
  echo '</div></div></section>';
}

/* ---------- 4. LISTA PARA TRABAJAR DESDE EL PRIMER DIA ---------- */
if(shas('lista.title')){
  echo '<section class="section bg-soft" id="lista"><div class="container duo rev reveal">';
  echo '<figure class="duo-media">'.pic($foto(1),$titulo,'(max-width:900px) 100vw, 58vw','loading="lazy"').'</figure>';
  echo '<div class="duo-copy"><h2 '.sa('lista.title').'>'.st('lista.title').'</h2>';
  if(shas('lista.text')) echo '<p '.sa('lista.text').'>'.st('lista.text').'</p>';
  echo srows(slist('lista.item',8));
  echo '</div></div></section>';
}

/* ---------- 5. QUE INCLUYE ---------- */
if(shas('incluye.title')){
  $own=slist('incluye.own',10); $sh0=slist('incluye.sh',12);
  echo '<section class="section" id="incluye"><div class="container"><div class="sec-head reveal">';
  echo '<h2 '.sa('incluye.title').'>'.st('incluye.title').'</h2></div>';
  echo '<div class="inc2'.(($own && $sh0)?'':' inc2-1').' reveal">';
  if($own) echo '<div><h3 '.sa('incluye.own_title').'>'.st('incluye.own_title').'</h3>'.srows($own).'</div>';
  if($sh0) echo '<div><h3 '.sa('incluye.sh_title').'>'.st('incluye.sh_title').'</h3>'.srows($sh0).'</div>';
  echo '</div></div></section>';
}

/* ---------- 6. TRES PASOS ---------- */
if(shas('pasos.title')){
  $__p=[]; for($i=1;$i<=4;$i++){ if(shas("pasos.s{$i}_title")) $__p[]=$i; }
  echo '<section class="section bg-soft" id="pasos"><div class="container"><div class="sec-head reveal">';
  echo '<h2 '.sa('pasos.title').'>'.st('pasos.title').'</h2></div><ol class="steps reveal" style="--n:'.max(1,count($__p)).'">';
  foreach($__p as $i) echo '<li><b '.sa("pasos.s{$i}_title").'>'.st("pasos.s{$i}_title").'</b><span '.sa("pasos.s{$i}_text").'>'.st("pasos.s{$i}_text").'</span></li>';
  echo '</ol></div></section>';
}

/* ---------- 7. FLEXIBILIDAD ---------- */
if(shas('flex.title')){
  echo '<section class="section" id="flex"><div class="container duo reveal">';
  echo '<figure class="duo-media">'.pic($foto(2),$titulo,'(max-width:900px) 100vw, 58vw','loading="lazy"').'</figure>';
  echo '<div class="duo-copy"><h2 '.sa('flex.title').'>'.st('flex.title').'</h2>';
  if(shas('flex.text')) echo '<p class="lead" '.sa('flex.text').'>'.st('flex.text').'</p>';
  if(shas('flex.text2')) echo '<p '.sa('flex.text2').'>'.st('flex.text2').'</p>';
  echo srows(slist('flex.f',6));
  echo '</div></div></section>';
}

/* ---------- 8. TECNOLOGIA, SEGURIDAD Y SOPORTE ---------- */
if(shas('tech.title')){
  $ic=['wifi','shield','support']; $__t=[]; for($i=1;$i<=3;$i++){ if(shas("tech.t{$i}_title")) $__t[]=$i; }
  echo '<section class="section bg-navy on-dark" id="tech"><div class="container"><div class="sec-head reveal">';
  echo '<h2 '.sa('tech.title').'>'.st('tech.title').'</h2></div>';
  echo '<ul class="ilist top reveal" style="--cd:'.max(1,count($__t)).';--ct:1;--cm:1">';
  foreach($__t as $i) echo '<li><span class="ico">'.render_icon(sv("tech.t{$i}_icon",$ic[$i-1])).'</span><div><span '.sa("tech.t{$i}_title").'>'.st("tech.t{$i}_title").'</span><p '.sa("tech.t{$i}_text").'>'.st("tech.t{$i}_text").'</p></div></li>';
  echo '</ul></div></section>';
}

/* ---------- 9. GALERIA (usa la galeria de la solucion) ---------- */
if(shas('galeria.title') && $imgs){
  $__root=$_SERVER['DOCUMENT_ROOT']??'';
  $__items=[];
  foreach($imgs as $u){ $sm=preg_replace('/\.webp$/','-sm.webp',$u); $__items[]=['tipo'=>'img','src'=>$u,'sm'=>($sm!==$u&&is_file($__root.$sm))?$sm:$u]; }
  $__n=count($__items); $__v=min(5,$__n);
  echo '<section class="section" id="galeria" data-galeria=\''.esc(json_encode($__items,JSON_UNESCAPED_SLASHES|JSON_UNESCAPED_UNICODE)).'\' data-titulo="'.esc(strip_tags(sv('galeria.title'))).'"><div class="container">';
  echo '<div class="sec-row reveal"><div class="sec-head"><h2 '.sa('galeria.title').'>'.st('galeria.title').'</h2>';
  if(shas('galeria.lead')) echo '<p class="lead" '.sa('galeria.lead').'>'.st('galeria.lead').'</p>';
  echo '</div>';
  if($__n>$__v) echo '<button type="button" class="sec-link" data-gal-todas>'.aldea_icon('grid').'<span data-es="Ver las '.$__n.' fotos" data-en="See all '.$__n.' photos">Ver las '.$__n.' fotos</span></button>';
  echo '</div><div class="mosaic m'.$__v.' reveal">';
  for($k=0;$k<$__v;$k++){
    echo '<figure><button type="button" data-i="'.$k.'" aria-label="Ampliar foto '.($k+1).'">'
        .pic($__items[$k]['src'],$titulo.' en Aldea, foto '.($k+1),$k===0?'(max-width:760px) 100vw, 50vw':'(max-width:760px) 50vw, 25vw','loading="lazy"').'</button></figure>';
  }
  echo '</div></div></section>';
}

/* ---------- 10. UBICACIONES (sin precios) ---------- */
if(shas('ubicaciones.title')){
  echo '<section class="section bg-soft" id="ubicaciones"><div class="container"><div class="sec-head reveal">';
  echo '<h2 '.sa('ubicaciones.title').'>'.st('ubicaciones.title').'</h2>';
  if(shas('ubicaciones.lead')) echo '<p class="lead" '.sa('ubicaciones.lead').'>'.st('ubicaciones.lead').'</p>';
  echo '</div>';
  loc_cards('','home',sv('ubicaciones.cta','Ver oficinas'),sn('ubicaciones.cta','See offices'));
  echo '</div></section>';
}

/* ---------- 11. FORMULARIO ---------- */
if(shas('form.title')){
  // Telefono y correo salen de Ajustes: un solo lugar para las 9 paginas
  $tel=setting('phone','+52 449 454 0709'); $telh='tel:'.preg_replace('/[^0-9+]/','',$tel);
  echo '<section class="section" id="formulario"><div class="container"><div class="formx reveal">';
  echo '<figure class="formx-media">'.pic($foto(3),$titulo,'(max-width:900px) 100vw, 45vw','loading="lazy"').'</figure>';
  echo '<div class="formx-body"><h2 '.sa('form.title').'>'.st('form.title').'</h2>';
  if(shas('form.lead')) echo '<p class="lead" '.sa('form.lead').'>'.st('form.lead').'</p>';
  echo '<form class="contact-form" onsubmit="return aldeaSubmit(event)" data-source="'.esc($sol['slug']).'" data-utm>';
  echo '<div class="cf-2"><input name="name" type="text" required placeholder="Nombre" data-ph-es="Nombre" data-ph-en="Name" autocomplete="name">';
  echo '<input name="company" type="text" placeholder="Empresa" data-ph-es="Empresa" data-ph-en="Company" autocomplete="organization"></div>';
  echo '<div class="cf-2"><input name="phone" type="tel" placeholder="Teléfono / WhatsApp" data-ph-es="Teléfono / WhatsApp" data-ph-en="Phone / WhatsApp" autocomplete="tel">';
  echo '<input name="email" type="email" required placeholder="Correo" data-ph-es="Correo" data-ph-en="Email" autocomplete="email"></div>';
  $__personas=strtolower(trim(sv('form.personas','si')))!=='no';
  echo $__personas?'<div class="cf-2">':'';
  echo '<select name="city" required><option value="" disabled selected data-es="Ciudad de interés" data-en="City of interest">Ciudad de interés</option>';
  foreach(cms_pdo()->query("SELECT city_es,city_en FROM locations WHERE published=1 ORDER BY sort,id") as $l)
    echo '<option value="'.esc($l['city_es']).'">'.esc($l['city_es']).'</option>';
  echo '</select>';
  // El campo "numero de personas" se oculta poniendo form.personas = no
  if($__personas){
    echo '<select name="team_size" required><option value="" disabled selected data-es="Número de personas" data-en="Number of people">Número de personas</option>';
    foreach(['1','2-5','6-10','11-20','21-50','51-100'] as $r) echo '<option value="'.$r.'">'.$r.'</option>';
    echo '</select></div>';
  }
  echo '<button type="submit" class="btn btn-accent w" '.sa('form.boton','Cotizar').'>'.st('form.boton','Cotizar').'</button>';
  echo '<small id="formMsg" data-es="Al enviar aceptas nuestras políticas de privacidad." data-en="By submitting you accept our privacy policy.">Al enviar aceptas nuestras políticas de privacidad.</small>';
  echo '</form>';
  echo '<div class="formx-alt"><span data-es="¿Prefieres hablar con nosotros?" data-en="Would you rather talk to us?">¿Prefieres hablar con nosotros?</span><a href="'.esc($telh).'">'.esc($tel).'</a></div>';
  echo '</div></div></div></section>';
}

/* ---------- 12. PREGUNTAS FRECUENTES ---------- */
$qs=slist('faq.q',10);
if($qs){
  echo '<section class="section bg-soft" id="faq"><div class="container faq2"><div class="sec-head reveal">';
  echo '<h2 '.sa('faq.title','Preguntas frecuentes').'>'.st('faq.title','Preguntas frecuentes').'</h2></div><div class="faq reveal">';
  foreach($qs as $k){ $n=substr($k,strlen('faq.q'));
    echo '<details><summary '.sa($k).'>'.st($k).'</summary><p '.sa('faq.a'.$n).'>'.st('faq.a'.$n).'</p></details>'; }
  echo '</div></div></section>';
}

echo '</main>';
site_footer();
site_scripts();
