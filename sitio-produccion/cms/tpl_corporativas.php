<?php
/* Oficinas Corporativas a la Medida.
   Se activa con el bloque page.plantilla = corporativas.
   $pg (fila de pages) y $PB (bloques por "seccion.clave") vienen en scope. */

function cv($k,$d=''){ global $PB; return isset($PB[$k]) && $PB[$k]['value_es']!==null && $PB[$k]['value_es']!=='' ? $PB[$k]['value_es'] : $d; }
function cn($k,$d=''){ global $PB; return isset($PB[$k]) && $PB[$k]['value_en']!==null && $PB[$k]['value_en']!=='' ? $PB[$k]['value_en'] : cv($k,$d); }
function ch_($k,$d=''){ global $PB; return isset($PB[$k]) && $PB[$k]['href']!==null && $PB[$k]['href']!=='' ? $PB[$k]['href'] : $d; }
function chas($k){ return trim(strip_tags((string)cv($k,'')))!==''; }
function ca($k,$d=''){ return 'data-es="'.esc(strip_tags(cv($k,$d))).'" data-en="'.esc(strip_tags(cn($k,$d))).'" data-blk="'.esc($k).'"'; }
function ct($k,$d=''){ return esc(strip_tags(cv($k,$d))); }
function clist($p,$max=14){ $o=[]; for($i=1;$i<=$max;$i++){ if(chas($p.$i)) $o[]=$p.$i; } return $o; }

$GLOBALS['BODY_CLASS']='has-nhero'; // el hero es oscuro a sangre: header en claro
site_head(($pg['seo_title_es']?:$pg['title_es'].' | Aldea Networking'),$pg['seo_desc_es'],
          '/'.$pg['slug'].'/',(bool)$pg['noindex'],
          ($pg['seo_title_en']?:($pg['title_en']?:$pg['title_es'])),$pg['seo_desc_en']);
site_header();
echo '<main class="corp-page">';

/* ---------- 1. HERO ---------- */
echo '<section class="chero" id="hero">';
echo '<div class="chero-media"><img src="'.esc(cv('hero.img','/img/oficina-privada/op-1.webp')).'" alt="'.esc(strip_tags(cv('hero.img_alt','Oficina corporativa desarrollada por Aldea'))).'"><span class="chero-scrim"></span></div>';
// El contenedor mantiene el margen del sitio; el ancho de lectura se limita
// dentro, no en el contenedor (si no, se centra y pierde la alineacion).
echo '<div class="container chero-in"><div class="chero-copy reveal">';
if(chas('hero.chip')) echo '<span class="chip chip-light" '.ca('hero.chip').'>'.ct('hero.chip').'</span>';
echo '<h1 '.ca('hero.title',$pg['title_es']).'>'.ct('hero.title',$pg['title_es']).'</h1>';
if(chas('hero.lead')) echo '<p class="chero-lead" '.ca('hero.lead').'>'.ct('hero.lead').'</p>';
if(chas('hero.lead2')) echo '<p class="chero-sub" '.ca('hero.lead2').'>'.ct('hero.lead2').'</p>';
if(chas('hero.plazo')) echo '<p class="chero-plazo" '.ca('hero.plazo').'>'.ct('hero.plazo').'</p>';
echo '<div class="hero-cta">';
if(chas('hero.cta1')) echo '<a href="'.esc(ch_('hero.cta1','#formulario')).'" class="btn btn-accent" '.ca('hero.cta1').'>'.ct('hero.cta1').'</a>';
if(chas('hero.cta2')) echo '<a href="'.esc(ch_('hero.cta2','#proceso')).'" class="btn btn-clear" '.ca('hero.cta2').'>'.ct('hero.cta2').'</a>';
echo '</div></div></div></section>';

/* ---------- 2. EMPRESAS ---------- */
if(chas('empresas.title')) render_clients(cv('empresas.title'),cn('empresas.title'),12);

/* ---------- 3. UNA OFICINA ALREDEDOR DE TU OPERACION ---------- */
if(chas('operacion.title')){
  echo '<section class="section" id="operacion"><div class="container corp-split reveal">';
  echo '<div><h2 '.ca('operacion.title').'>'.ct('operacion.title').'</h2>';
  if(chas('operacion.text')) echo '<p class="lead" '.ca('operacion.text').'>'.ct('operacion.text').'</p>';
  echo '<ol class="ejes">';
  for($i=1;$i<=6;$i++){ if(!chas("operacion.e{$i}_title")) continue;
    echo '<li><span class="eje-ic">'.render_icon(cv("operacion.e{$i}_icon",'check')).'</span>'
        .'<div><b '.ca("operacion.e{$i}_title").'>'.ct("operacion.e{$i}_title").'</b>'
        .'<span '.ca("operacion.e{$i}_text").'>'.ct("operacion.e{$i}_text").'</span></div></li>'; }
  echo '</ol></div>';
  echo '<figure class="corp-fig"><img src="'.esc(cv('operacion.img','/img/oficina-privada/op-1.webp')).'" alt="'.esc(strip_tags(cv('operacion.img_alt',''))).'" loading="lazy"></figure>';
  echo '</div></section>';
}

/* ---------- 4. UN SOLO EQUIPO ---------- */
if(chas('equipo.title')){
  echo '<section class="section bg-soft" id="equipo"><div class="container"><div class="sec-head center reveal">';
  echo '<h2 '.ca('equipo.title').'>'.ct('equipo.title').'</h2>';
  if(chas('equipo.text')) echo '<p class="lead" '.ca('equipo.text').'>'.ct('equipo.text').'</p>';
  echo '</div><div class="alcance reveal">';
  foreach(clist('equipo.i',12) as $k) echo '<div class="alcance-it"><span class="alcance-n"></span><b '.ca($k).'>'.ct($k).'</b></div>';
  echo '</div>';
  if(chas('equipo.cierre')) echo '<p class="alcance-cierre reveal" '.ca('equipo.cierre').'>'.ct('equipo.cierre').'</p>';
  echo '</div></section>';
}

/* ---------- 5. COMO TRABAJAMOS ---------- */
if(chas('proceso.title')){
  echo '<section class="section" id="proceso"><div class="container"><div class="sec-head center reveal">';
  echo '<h2 '.ca('proceso.title').'>'.ct('proceso.title').'</h2></div><ol class="etapas reveal">';
  for($i=1;$i<=6;$i++){ if(!chas("proceso.s{$i}_title")) continue;
    echo '<li class="etapa"><span class="etapa-n">'.$i.'</span>'
        .'<b '.ca("proceso.s{$i}_title").'>'.ct("proceso.s{$i}_title").'</b>'
        .'<span '.ca("proceso.s{$i}_text").'>'.ct("proceso.s{$i}_text").'</span></li>'; }
  echo '</ol></div></section>';
}

/* ---------- 6. TODO EN UNA SOLA RENTA ---------- */
if(chas('renta.title')){
  echo '<section class="section bg-navy" id="renta"><div class="container"><div class="sec-head center on-dark reveal">';
  echo '<h2 '.ca('renta.title').'>'.ct('renta.title').'</h2>';
  if(chas('renta.text')) echo '<p class="lead" '.ca('renta.text').'>'.ct('renta.text').'</p>';
  echo '</div>';
  $piezas=clist('renta.f',8);
  if($piezas){
    // Ecuacion en dos columnas: los componentes apilados a la izquierda,
    // el resultado a la derecha. Asi no parte de linea ni deja el = suelto.
    echo '<div class="formula reveal">';
    echo '<div class="formula-in">';
    foreach($piezas as $n=>$k){
      if($n) echo '<span class="formula-op" aria-hidden="true">+</span>';
      echo '<div class="formula-p" '.ca($k).'>'.ct($k).'</div>';
    }
    echo '</div>';
    echo '<span class="formula-eq" aria-hidden="true">=</span>';
    echo '<div class="formula-r" '.ca('renta.resultado','Una sola renta mensual').'>'.ct('renta.resultado','Una sola renta mensual').'</div>';
    echo '</div>';
  }
  $bens=clist('renta.b',8);
  if($bens){
    echo '<ul class="renta-bens reveal">';
    foreach($bens as $k) echo '<li '.ca($k).'>'.ct($k).'</li>';
    echo '</ul>';
  }
  echo '</div></section>';
}

/* ---------- 7. SERVICIOS SEGUN LA OPERACION ---------- */
if(chas('servicios.title')){
  echo '<section class="section" id="servicios"><div class="container"><div class="sec-head center reveal">';
  echo '<h2 '.ca('servicios.title').'>'.ct('servicios.title').'</h2>';
  if(chas('servicios.text')) echo '<p class="lead" '.ca('servicios.text').'>'.ct('servicios.text').'</p>';
  echo '</div><div class="serv-tags reveal">';
  foreach(clist('servicios.s',16) as $k) echo '<span class="serv-tag" '.ca($k).'>'.ct($k).'</span>';
  echo '</div></div></section>';
}

/* ---------- 8. TECNOLOGIA, SEGURIDAD E INFRAESTRUCTURA ---------- */
if(chas('tech.title')){
  echo '<section class="section bg-soft" id="tech"><div class="container"><div class="sec-head center reveal">';
  echo '<h2 '.ca('tech.title').'>'.ct('tech.title').'</h2>';
  if(chas('tech.text')) echo '<p class="lead" '.ca('tech.text').'>'.ct('tech.text').'</p>';
  echo '</div><div class="infra-grid reveal">';
  for($i=1;$i<=4;$i++){ if(!chas("tech.t{$i}_title")) continue;
    echo '<article class="infra-card"><div class="bico">'.render_icon(cv("tech.t{$i}_icon",'check')).'</div>'
        .'<h3 '.ca("tech.t{$i}_title").'>'.ct("tech.t{$i}_title").'</h3>'
        .'<p '.ca("tech.t{$i}_text").'>'.ct("tech.t{$i}_text").'</p></article>'; }
  echo '</div>';
  if(chas('tech.nota')) echo '<p class="amen-note reveal" '.ca('tech.nota').'>'.ct('tech.nota').'</p>';
  echo '</div></section>';
}

/* ---------- 9. DEL PROYECTO AL ESPACIO TERMINADO ---------- */
// El brief pide una GALERIA con material real de proyectos ("demostrar
// capacidad de desarrollo"). Sin imagenes no hay nada que demostrar, asi que
// la seccion no se dibuja hasta que se cargue al menos una. Mismo criterio
// que la galeria de Acerca de Aldea y los testimonios por sede.
$__conFoto=false;
for($i=1;$i<=6;$i++){ if(trim((string)cv("proyecto.e{$i}_img",''))!==''){ $__conFoto=true; break; } }
if(chas('proyecto.title') && $__conFoto){
  echo '<section class="section" id="proyecto"><div class="container"><div class="sec-head center reveal">';
  echo '<h2 '.ca('proyecto.title').'>'.ct('proyecto.title').'</h2>';
  if(chas('proyecto.text')) echo '<p class="lead" '.ca('proyecto.text').'>'.ct('proyecto.text').'</p>';
  echo '</div><ol class="secuencia reveal">';
  for($i=1;$i<=6;$i++){ if(!chas("proyecto.e{$i}")) continue;
    $img=cv("proyecto.e{$i}_img",'');
    echo '<li class="sec-paso">';
    echo $img!=='' ? '<div class="sec-img"><img src="'.esc($img).'" alt="'.ct("proyecto.e{$i}").'" loading="lazy"></div>'
                   : '<div class="sec-img sec-img-vacia"><span>'.$i.'</span></div>';
    echo '<b '.ca("proyecto.e{$i}").'>'.ct("proyecto.e{$i}").'</b></li>'; }
  echo '</ol>';
  // Aclaracion de que material es ilustrativo y cual es de un proyecto real.
  if(chas('proyecto.nota')) echo '<p class="amen-note reveal" '.ca('proyecto.nota').'>'.ct('proyecto.nota').'</p>';
  echo '</div></section>';
}

/* ---------- 10. FORMULARIO CORPORATIVO ---------- */
// Telefono y correo salen de Ajustes: un solo lugar para las 9 paginas
$tel=setting('phone','+52 449 454 0709'); $telh='tel:'.preg_replace('/[^0-9+]/','',$tel);
echo '<section class="section bg-soft" id="formulario"><div class="container"><div class="corp-form-wrap reveal">';
echo '<div class="corp-form-copy">';
echo '<h2 '.ca('form.title','Cuéntanos tu proyecto').'>'.ct('form.title','Cuéntanos tu proyecto').'</h2>';
if(chas('form.text')) echo '<p class="lead" '.ca('form.text').'>'.ct('form.text').'</p>';
echo '<p class="contact-ask" data-es="¿Prefieres hablar con nosotros?" data-en="Would you rather talk to us?">¿Prefieres hablar con nosotros?</p>';
echo '<p class="contact-phone"><a class="contact-tel" href="'.esc($telh).'">'.esc($tel).'</a></p>';
echo '</div>';
echo '<form class="contact-form corp-form" onsubmit="return aldeaSubmit(event)" data-source="oficinas-corporativas" data-utm>';
echo '<input type="hidden" name="form_type" value="corporativo">';
echo '<input type="hidden" name="product" value="Proyecto Corporativo">';
echo '<div class="cf-2">';
echo '<input name="name" type="text" required placeholder="Nombre" data-ph-es="Nombre" data-ph-en="Name">';
echo '<input name="company" type="text" required placeholder="Empresa" data-ph-es="Empresa" data-ph-en="Company">';
echo '</div><div class="cf-2">';
echo '<input name="role" type="text" placeholder="Cargo" data-ph-es="Cargo" data-ph-en="Role">';
echo '<input name="email" type="email" required placeholder="Correo corporativo" data-ph-es="Correo corporativo" data-ph-en="Work email">';
echo '</div><div class="cf-2">';
echo '<input name="phone" type="tel" placeholder="Teléfono / WhatsApp" data-ph-es="Teléfono / WhatsApp" data-ph-en="Phone / WhatsApp">';
echo '<input name="city" type="text" placeholder="Ciudad o ubicación requerida" data-ph-es="Ciudad o ubicación requerida" data-ph-en="City or required location">';
echo '</div><div class="cf-2">';
echo '<select name="team_size" required><option value="" disabled selected data-es="Número aproximado de personas" data-en="Approximate headcount">Número aproximado de personas</option>';
foreach(['100-150','151-250','251-500','+500'] as $r) echo '<option value="'.$r.'">'.str_replace('-','–',$r).'</option>';
echo '</select>';
echo '<input name="target_date" type="month" aria-label="Fecha objetivo de operación" placeholder="Fecha objetivo">';
echo '</div>';
echo '<textarea name="message" rows="4" placeholder="Mensaje / necesidades principales" data-ph-es="Mensaje / necesidades principales" data-ph-en="Message / main requirements"></textarea>';
echo '<button type="submit" class="btn btn-accent w" '.ca('form.boton','Hablar con nuestro equipo corporativo').'>'.ct('form.boton','Hablar con nuestro equipo corporativo').'</button>';
echo '<small id="formMsg" data-es="Al enviar aceptas nuestras políticas de privacidad." data-en="By submitting you accept our privacy policy.">Al enviar aceptas nuestras políticas de privacidad.</small>';
echo '</form></div></div></section>';

/* ---------- 11. PREGUNTAS FRECUENTES ---------- */
$qs=clist('faq.q',12);
if($qs){
  echo '<section class="section" id="faq"><div class="container"><div class="sec-head center reveal">';
  echo '<h2 '.ca('faq.title','Preguntas frecuentes').'>'.ct('faq.title','Preguntas frecuentes').'</h2></div><div class="faq reveal">';
  foreach($qs as $k){ $n=substr($k,strlen('faq.q'));
    echo '<details><summary '.ca($k).'>'.ct($k).'</summary><p '.ca('faq.a'.$n).'>'.ct('faq.a'.$n).'</p></details>'; }
  echo '</div></div></section>';
}

echo '</main>';
site_footer();
site_scripts();
