<?php
/* Plantilla ampliada de solucion, dirigida por bloques.
   Se usa cuando existe una pagina oculta con slug "sol:<slug>" y bloques cargados.
   Si no existe, tpl_solution.php sigue usando el diseno generico de siempre.
   $sol y $SB (bloques indexados por "seccion.clave") vienen en scope. */

function sv($k,$d=''){ global $SB; return isset($SB[$k]) && $SB[$k]['value_es']!==null && $SB[$k]['value_es']!=='' ? $SB[$k]['value_es'] : $d; }
function sn($k,$d=''){ global $SB; return isset($SB[$k]) && $SB[$k]['value_en']!==null && $SB[$k]['value_en']!=='' ? $SB[$k]['value_en'] : sv($k,$d); }
function sh_($k,$d=''){ global $SB; return isset($SB[$k]) && $SB[$k]['href']!==null && $SB[$k]['href']!=='' ? $SB[$k]['href'] : $d; }
function shas($k){ return trim(strip_tags((string)sv($k,'')))!==''; }
/* etiqueta bilingue lista para incrustar */
function sa($k,$d=''){ return 'data-es="'.esc(strip_tags(sv($k,$d))).'" data-en="'.esc(strip_tags(sn($k,$d))).'" data-blk="'.esc($k).'"'; }
function st($k,$d=''){ return esc(strip_tags(sv($k,$d))); }
/* lista de claves consecutivas con contenido: item1, item2... */
function slist($prefix,$max=12){ $out=[]; for($i=1;$i<=$max;$i++){ if(shas($prefix.$i)) $out[]=$prefix.$i; } return $out; }

$imgs=json_decode($sol['gallery']?:'[]',true); if(!is_array($imgs)) $imgs=[];
$hero=$sol['hero_image']?:($imgs[0]??'/img/sol-privada.webp');

site_head(($sol['seo_title_es']?:$sol['title_es'].' - Aldea Networking'),($sol['seo_desc_es']?:$sol['excerpt_es']),'/'.$sol['slug'].'/',false,(($sol['seo_title_en']?:($sol['title_en']?:$sol['title_es'])).' - Aldea Networking'),($sol['seo_desc_en']?:($sol['excerpt_en']?:'')));
site_header();
echo '<main>';

/* ---------- 1. HERO ---------- */
echo '<section class="solhero" id="hero"><div class="container"><div class="solhero-card"><div class="sg-imgs">';
echo '<img class="sg-img on" src="'.esc($hero).'" alt="'.esc(($sol['hero_image_alt']??'')?:$sol['title_es']).'">';
echo '</div><div class="solhero-ov"></div><div class="solhero-body reveal">';
echo '<div class="crumb"><a href="/" data-es="Inicio" data-en="Home">Inicio</a> / <a href="/lo-que-ofrecemos/" data-es="Espacios de trabajo" data-en="Workspaces">Espacios de trabajo</a> / <span data-es="'.esc($sol['title_es']).'" data-en="'.esc($sol['title_en']?:$sol['title_es']).'">'.esc($sol['title_es']).'</span></div>';
echo '<h1 '.sa('hero.h1',$sol['title_es']).'>'.st('hero.h1',$sol['title_es']).'</h1>';
echo '<p class="lead" '.sa('hero.lead').'>'.st('hero.lead').'</p>';
if(shas('hero.lead2')) echo '<p class="solhero-sub" '.sa('hero.lead2').'>'.st('hero.lead2').'</p>';
$hb=slist('hero.bullet',6);
if($hb){ echo '<ul class="solhero-bullets">';
  foreach($hb as $k) echo '<li '.sa($k).'>'.st($k).'</li>';
  echo '</ul>'; }
echo '<div class="hero-cta">';
if(shas('hero.cta1')) echo '<a href="'.esc(sh_('hero.cta1','#formulario')).'" class="btn btn-accent" '.sa('hero.cta1').'>'.st('hero.cta1').'</a>';
if(shas('hero.cta2')) echo '<a href="'.esc(sh_('hero.cta2','#incluye')).'" class="btn btn-clear" '.sa('hero.cta2').'>'.st('hero.cta2').'</a>';
echo '</div></div></div></div></section>';

/* ---------- 2. EMPRESAS QUE TRABAJAN DESDE ALDEA ---------- */
if(shas('empresas.title')) render_clients(sv('empresas.title'),sn('empresas.title'),10);

/* ---------- 3. QUE ES ---------- */
if(shas('quees.title')){
  echo '<section class="section" id="quees"><div class="container split reveal">';
  echo '<img src="'.esc(sv('quees.img',$hero)).'" alt="'.esc(strip_tags(sv('quees.img_alt','Oficina privada en Aldea'))).'">';
  echo '<div>';
  if(shas('quees.chip')) echo '<span class="chip" '.sa('quees.chip').'>'.st('quees.chip').'</span>';
  echo '<h2 style="margin-top:.8rem" '.sa('quees.title').'>'.st('quees.title').'</h2>';
  echo '<p '.sa('quees.text').'>'.st('quees.text').'</p>';
  if(shas('quees.priv_title')||shas('quees.shared_title')){
    // Cada lado admite una frase (priv_text / shared_text) o una lista (p1.. / s1..)
    $__pl=slist('quees.p',6); $__sl=slist('quees.s',6);
    $__card=function($tk,$txk,$items,$cls) use (&$__card){
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
    $__in=render_icon('sparkle').'<span '.sa('quees.destacado').'>'.st('quees.destacado').'</span>';
    echo $__h ? '<a class="nota-cruzada" href="'.esc($__h).'">'.$__in.'</a>' : '<p class="nota-cruzada">'.$__in.'</p>';
  }
  echo '</div></div></section>';
}

/* ---------- 4. LISTA PARA TRABAJAR DESDE EL PRIMER DIA ---------- */
if(shas('lista.title')){
  echo '<section class="section bg-soft" id="lista"><div class="container"><div class="sec-head center reveal">';
  echo '<h2 '.sa('lista.title').'>'.st('lista.title').'</h2>';
  if(shas('lista.text')) echo '<p class="lead" '.sa('lista.text').'>'.st('lista.text').'</p>';
  echo '</div>';
  $li=slist('lista.item',8);
  // lista.estilo = no  -> tachas (lo que NO tienes que hacer). si -> palomitas.
  $__lc = strtolower(trim(sv('lista.estilo','no')))==='si' ? 'nolist nolist-si' : 'nolist';
  if($li){ echo '<ul class="'.$__lc.' reveal">';
    foreach($li as $k) echo '<li '.sa($k).'>'.st($k).'</li>';
    echo '</ul>'; }
  if(shas('lista.cierre')) echo '<p class="lista-cierre reveal" '.sa('lista.cierre').'>'.st('lista.cierre').'</p>';
  echo '</div></section>';
}

/* ---------- 5. QUE INCLUYE ---------- */
if(shas('incluye.title')){
  echo '<section class="section" id="incluye"><div class="container"><div class="sec-head center reveal">';
  echo '<h2 '.sa('incluye.title').'>'.st('incluye.title').'</h2></div>';
  $own=slist('incluye.own',10);
  $sh0=slist('incluye.sh',12);
  // Con una sola columna la rejilla se centra en vez de dejar medio ancho vacio
  echo '<div class="inc-grid'.(($own && $sh0)?'':' inc-grid-1').' reveal">';
  if($own){ echo '<div class="inc-col inc-own"><h3 '.sa('incluye.own_title').'>'.st('incluye.own_title').'</h3><ul class="checklist">';
    foreach($own as $k) echo '<li '.sa($k).'>'.st($k).'</li>';
    echo '</ul></div>'; }
  $sh=$sh0;
  if($sh){ echo '<div class="inc-col"><h3 '.sa('incluye.sh_title').'>'.st('incluye.sh_title').'</h3><ul class="checklist">';
    foreach($sh as $k) echo '<li '.sa($k).'>'.st($k).'</li>';
    echo '</ul></div>'; }
  echo '</div>';
  if(shas('incluye.nota')) echo '<p class="amen-note reveal" '.sa('incluye.nota').'>'.st('incluye.nota').'</p>';
  echo '</div></section>';
}

/* ---------- 6. TU NUEVA OFICINA EN 3 PASOS ---------- */
if(shas('pasos.title')){
  echo '<section class="section bg-soft" id="pasos"><div class="container"><div class="sec-head center reveal">';
  echo '<h2 '.sa('pasos.title').'>'.st('pasos.title').'</h2></div><ol class="pasos reveal">';
  for($i=1;$i<=4;$i++){ if(!shas("pasos.s{$i}_title")) continue;
    echo '<li><span class="paso-n">'.$i.'</span><div><b '.sa("pasos.s{$i}_title").'>'.st("pasos.s{$i}_title").'</b>'
        .'<span '.sa("pasos.s{$i}_text").'>'.st("pasos.s{$i}_text").'</span></div></li>'; }
  echo '</ol></div></section>';
}

/* ---------- 7. FLEXIBILIDAD ---------- */
if(shas('flex.title')){
  $ff0=slist('flex.f',6);
  echo '<section class="section" id="flex"><div class="container"><div class="flex-in'.($ff0?'':' flex-solo').' reveal"><div class="flex-copy">';
  echo '<h2 '.sa('flex.title').'>'.st('flex.title').'</h2>';
  if(shas('flex.text')) echo '<p class="lead" '.sa('flex.text').'>'.st('flex.text').'</p>';
  if(shas('flex.text2')) echo '<p '.sa('flex.text2').'>'.st('flex.text2').'</p>';
  echo '</div>';
  $ff=$ff0;
  if($ff){ echo '<ul class="flex-tags">';
    foreach($ff as $k) echo '<li '.sa($k).'>'.st($k).'</li>';
    echo '</ul>'; }
  echo '</div></div></section>';
}

/* ---------- 8. TECNOLOGIA, SEGURIDAD Y SOPORTE ---------- */
if(shas('tech.title')){
  echo '<section class="section bg-navy" id="tech"><div class="container"><div class="sec-head center on-dark reveal">';
  echo '<h2 '.sa('tech.title').'>'.st('tech.title').'</h2></div><div class="tech-grid reveal">';
  $ic=['wifi','shield','support'];
  for($i=1;$i<=3;$i++){ if(!shas("tech.t{$i}_title")) continue;
    $icon=sv("tech.t{$i}_icon",$ic[$i-1]);
    echo '<article class="tech-card"><div class="bico">'.render_icon($icon).'</div>'
        .'<h3 '.sa("tech.t{$i}_title").'>'.st("tech.t{$i}_title").'</h3>'
        .'<p '.sa("tech.t{$i}_text").'>'.st("tech.t{$i}_text").'</p></article>'; }
  echo '</div></div></section>';
}

/* ---------- 9. GALERIA (usa la galeria de la solucion) ---------- */
if(shas('galeria.title') && $imgs){
  echo '<section class="section" id="galeria"><div class="container"><div class="sec-head center reveal">';
  echo '<h2 '.sa('galeria.title').'>'.st('galeria.title').'</h2>';
  if(shas('galeria.lead')) echo '<p class="lead" '.sa('galeria.lead').'>'.st('galeria.lead').'</p>';
  echo '</div><div class="gal-grid reveal">';
  foreach(array_slice($imgs,0,8) as $u) echo '<figure><img src="'.esc($u).'" alt="'.esc($sol['title_es']).' Aldea" loading="lazy"></figure>';
  echo '</div></div></section>';
}

/* ---------- 10. UBICACIONES (sin precios) ---------- */
if(shas('ubicaciones.title')){
  echo '<section class="section bg-soft" id="ubicaciones"><div class="container"><div class="sec-head center reveal">';
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
  echo '<section class="section" id="formulario"><div class="container contact-in"><div class="contact-copy reveal">';
  echo '<h2 '.sa('form.title').'>'.st('form.title').'</h2>';
  if(shas('form.lead')) echo '<p class="lead" '.sa('form.lead').'>'.st('form.lead').'</p>';
  echo '<p class="contact-ask" data-es="¿Prefieres hablar con nosotros?" data-en="Would you rather talk to us?">¿Prefieres hablar con nosotros?</p>';
  echo '<p class="contact-phone"><a class="contact-tel" href="'.esc($telh).'">'.esc($tel).'</a></p>';
  echo '</div><form class="contact-form reveal" onsubmit="return aldeaSubmit(event)" data-source="'.esc($sol['slug']).'">';
  echo '<input name="name" type="text" required placeholder="Nombre" data-ph-es="Nombre" data-ph-en="Name">';
  echo '<input name="company" type="text" placeholder="Empresa" data-ph-es="Empresa" data-ph-en="Company">';
  echo '<input name="phone" type="tel" placeholder="Teléfono / WhatsApp" data-ph-es="Teléfono / WhatsApp" data-ph-en="Phone / WhatsApp">';
  echo '<input name="email" type="email" required placeholder="Correo" data-ph-es="Correo" data-ph-en="Email">';
  echo '<select name="city" required><option value="" disabled selected data-es="Ciudad de interés" data-en="City of interest">Ciudad de interés</option>';
  foreach(cms_pdo()->query("SELECT city_es,city_en FROM locations WHERE published=1 ORDER BY sort,id") as $l)
    echo '<option value="'.esc($l['city_es']).'">'.esc($l['city_es']).'</option>';
  echo '</select>';
  // El campo "numero de personas" se oculta poniendo form.personas = no
  if(strtolower(trim(sv('form.personas','si')))!=='no'){
    echo '<select name="team_size" required><option value="" disabled selected data-es="Número de personas" data-en="Number of people">Número de personas</option>';
    foreach(['1','2-5','6-10','11-20','21-50','51-100'] as $r) echo '<option value="'.$r.'">'.str_replace('-','–',$r).'</option>';
    echo '</select>';
  }
  echo '<button type="submit" class="btn btn-accent w" '.sa('form.boton','Cotizar').'>'.st('form.boton','Cotizar').'</button>';
  echo '<small id="formMsg" data-es="Al enviar aceptas nuestras políticas de privacidad." data-en="By submitting you accept our privacy policy.">Al enviar aceptas nuestras políticas de privacidad.</small>';
  echo '</form></div></section>';
}

/* ---------- 12. PREGUNTAS FRECUENTES ---------- */
$qs=slist('faq.q',10);
if($qs){
  echo '<section class="section bg-soft" id="faq"><div class="container"><div class="sec-head center reveal">';
  echo '<h2 '.sa('faq.title','Preguntas frecuentes').'>'.st('faq.title','Preguntas frecuentes').'</h2></div><div class="faq reveal">';
  foreach($qs as $k){ $n=substr($k,strlen('faq.q'));
    echo '<details><summary '.sa($k).'>'.st($k).'</summary><p '.sa('faq.a'.$n).'>'.st('faq.a'.$n).'</p></details>'; }
  echo '</div></div></section>';
}

echo '</main>';
site_footer();
site_scripts();
