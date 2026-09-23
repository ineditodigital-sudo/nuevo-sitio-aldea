<?php
/* Oficinas Corporativas a la Medida.
   Se activa con el bloque page.plantilla = corporativas.
   $pg (fila de pages) y $PB (bloques por "seccion.clave") vienen en scope.

   Rediseno 2026-09: la pagina tiene que dejar claro que esto NO es coworking,
   sino una oficina completa llave en mano (inmueble, adecuacion, mobiliario,
   personalizacion y operacion). Todo el texto sale del panel. */

function cv($k,$d=''){ global $PB; return isset($PB[$k]) && $PB[$k]['value_es']!==null && $PB[$k]['value_es']!=='' ? $PB[$k]['value_es'] : $d; }
function cn($k,$d=''){ global $PB; return isset($PB[$k]) && $PB[$k]['value_en']!==null && $PB[$k]['value_en']!=='' ? $PB[$k]['value_en'] : cv($k,$d); }
function ch_($k,$d=''){ global $PB; return isset($PB[$k]) && $PB[$k]['href']!==null && $PB[$k]['href']!=='' ? $PB[$k]['href'] : $d; }
function chas($k){ return trim(strip_tags((string)cv($k,'')))!==''; }
function ca($k,$d=''){ return 'data-es="'.esc(strip_tags(cv($k,$d))).'" data-en="'.esc(strip_tags(cn($k,$d))).'" data-blk="'.esc($k).'"'; }
function ct($k,$d=''){ return esc(strip_tags(cv($k,$d))); }
function clist($p,$max=14){ $o=[]; for($i=1;$i<=$max;$i++){ if(chas($p.$i)) $o[]=$p.$i; } return $o; }

site_head(($pg['seo_title_es']?:$pg['title_es'].' | Aldea Networking'),$pg['seo_desc_es'],
          '/'.$pg['slug'].'/',(bool)$pg['noindex'],
          ($pg['seo_title_en']?:($pg['title_en']?:$pg['title_es'])),$pg['seo_desc_en']);
site_header();
jsonld_breadcrumbs([['Inicio','/'],[$pg['title_es'],'/'.$pg['slug'].'/']]);
echo '<main class="corp-page">';

/* ---------- 1. BANNER ---------- */
$__in='<h1 '.ca('hero.title',$pg['title_es']).'>'.ct('hero.title',$pg['title_es']).'</h1>';
if(chas('hero.lead')) $__in.='<p class="lead" '.ca('hero.lead').'>'.ct('hero.lead').'</p>';
$__in.='<div class="hero-cta">';
if(chas('hero.cta1')) $__in.='<a href="'.esc(ch_('hero.cta1','#formulario')).'" class="btn btn-accent" '.ca('hero.cta1').'>'.ct('hero.cta1').'</a>';
if(chas('hero.cta2')) $__in.='<a href="'.esc(ch_('hero.cta2','#proceso')).'" class="btn btn-clear" '.ca('hero.cta2').'>'.ct('hero.cta2').'</a>';
$__in.='</div>';
page_hero(cv('hero.img','/img/corporativas/proyecto/planta-abierta.webp'),strip_tags(cv('hero.img_alt','Oficina corporativa desarrollada por Aldea')),$__in);

/* ---------- 2. EMPRESAS ---------- */
if(chas('empresas.title')) render_clients(cv('empresas.title'),cn('empresas.title'),12);

/* ---------- 3. QUE ES: una oficina completa, llave en mano ----------
   Cada eje es una tarjeta con foto: inmueble, adecuacion, mobiliario y personalizacion. */
if(chas('operacion.title')){
  echo '<section class="section" id="operacion"><div class="container">';
  echo '<div class="sec-head reveal"><h2 '.ca('operacion.title').'>'.ct('operacion.title').'</h2>';
  if(chas('operacion.text')) echo '<p class="lead" '.ca('operacion.text').'>'.ct('operacion.text').'</p>';
  echo '</div>';
  $__e=[]; for($i=1;$i<=6;$i++){ if(chas("operacion.e{$i}_title")) $__e[]=$i; }
  echo '<div class="ejes2 swipe" data-swipe style="--n:'.max(1,min(4,count($__e))).'">';
  foreach($__e as $i){
    echo '<article class="eje2 reveal">';
    if(chas("operacion.e{$i}_img")) echo '<figure>'.pic(cv("operacion.e{$i}_img"),strip_tags(cv("operacion.e{$i}_title")),'(max-width:600px) 100vw, (max-width:1080px) 50vw, 25vw','loading="lazy"').'</figure>';
    echo '<h3 '.ca("operacion.e{$i}_title").'>'.ct("operacion.e{$i}_title").'</h3>';
    if(chas("operacion.e{$i}_text")) echo '<p '.ca("operacion.e{$i}_text").'>'.ct("operacion.e{$i}_text").'</p>';
    echo '</article>';
  }
  echo '</div></div></section>';
}

/* ---------- 4. COMO TRABAJAMOS: cinco pasos en linea de tiempo ---------- */
if(chas('proceso.title')){
  $__s=[]; for($i=1;$i<=6;$i++){ if(chas("proceso.s{$i}_title")) $__s[]=$i; }
  echo '<section class="section bg-soft" id="proceso"><div class="container">';
  echo '<div class="sec-head reveal"><h2 '.ca('proceso.title').'>'.ct('proceso.title').'</h2>';
  if(chas('proceso.text')) echo '<p class="lead" '.ca('proceso.text').'>'.ct('proceso.text').'</p>';
  echo '</div><ol class="steps reveal" style="--n:'.max(1,count($__s)).'">';
  foreach($__s as $i) echo '<li><b '.ca("proceso.s{$i}_title").'>'.ct("proceso.s{$i}_title").'</b><span '.ca("proceso.s{$i}_text").'>'.ct("proceso.s{$i}_text").'</span></li>';
  echo '</ol></div></section>';
}

/* ---------- 5. TODO EN UNA SOLA RENTA ----------
   El diagrama es un video animado (fuente en /remotion del repositorio), en espanol
   e ingles y en dos formatos: horizontal y vertical para movil. Si los archivos no
   estan, se dibuja la version en HTML. */
if(chas('renta.title')){
  $__lang=site_lang()==='en'?'en':'es';
  $__vb='/video/una-renta/una-renta-'.$__lang;
  $__root=$_SERVER['DOCUMENT_ROOT']??'';
  $__hayVideo=is_file($__root.$__vb.'-16x9.mp4');
  echo '<section class="section bg-navy on-dark" id="renta"><div class="container">';
  echo '<div class="sec-head reveal"><h2 '.ca('renta.title').'>'.ct('renta.title').'</h2>';
  if(chas('renta.text')) echo '<p class="lead" '.ca('renta.text').'>'.ct('renta.text').'</p>';
  echo '</div>';
  $piezas=clist('renta.f',8);
  if($__hayVideo){
    echo '<figure class="renta-video reveal">';
    // Sin autoplay: app6.js lo arranca al entrar en pantalla (y nunca con movimiento reducido).
    echo '<video muted loop playsinline preload="none" poster="'.esc($__vb.'-16x9.webp').'" aria-label="'.esc(strip_tags(cv('renta.title'))).'" data-renta-video>';
    if(is_file($__root.$__vb.'-4x5.mp4')) echo '<source src="'.esc($__vb.'-4x5.mp4').'" type="video/mp4" media="(max-width: 700px)">';
    echo '<source src="'.esc($__vb.'-16x9.mp4').'" type="video/mp4"></video>';
    // Texto equivalente al video para lectores de pantalla y buscadores
    if($piezas){ echo '<figcaption class="sr-only">'; foreach($piezas as $k) echo esc(strip_tags(cv($k))).'. '; echo esc(strip_tags(cv('renta.resultado','Una sola renta mensual'))).'.</figcaption>'; }
    echo '<button type="button" class="renta-pausa" data-renta-pausa aria-label="Pausar animación">'.aldea_icon('pause').'</button>';
    echo '</figure>';
  } elseif($piezas){
    // Respaldo: la ecuacion en HTML
    echo '<div class="formula reveal"><div class="formula-in">';
    foreach($piezas as $n=>$k){ if($n) echo '<span class="formula-op" aria-hidden="true">+</span>'; echo '<div class="formula-p" '.ca($k).'>'.ct($k).'</div>'; }
    echo '</div><span class="formula-eq" aria-hidden="true">=</span>';
    echo '<div class="formula-r" '.ca('renta.resultado','Una sola renta mensual').'>'.ct('renta.resultado','Una sola renta mensual').'</div></div>';
  }
  $bens=clist('renta.b',8);
  if($bens){
    $__nb=count($bens); $__cd=$__nb<=5?$__nb:($__nb%4===0?4:3);
    echo '<ul class="rows renta-rows reveal" style="--cd:'.$__cd.'">';
    foreach($bens as $k) echo '<li>'.aldea_icon('check').'<span '.ca($k).'>'.ct($k).'</span></li>';
    echo '</ul>';
  }
  echo '</div></section>';
}

/* ---------- 6. UN PROYECTO REAL, TERMINADO ----------
   Galeria de un proyecto corporativo entregado por Aldea (fotografia real). */
$__g=[]; for($i=1;$i<=16;$i++){ $u=trim((string)cv("proyecto.g{$i}",'')); if($u!=='') $__g[]=$u; }
if(chas('proyecto.title') && $__g){
  $__root=$_SERVER['DOCUMENT_ROOT']??'';
  $__items=[];
  foreach($__g as $u){ $sm=preg_replace('/\.webp$/','-sm.webp',$u); $__items[]=['tipo'=>'img','src'=>$u,'sm'=>($sm!==$u&&is_file($__root.$sm))?$sm:$u]; }
  $__n=count($__items); $__v=min(5,$__n);
  echo '<section class="section" id="proyecto" data-galeria=\''.esc(json_encode($__items,JSON_UNESCAPED_SLASHES|JSON_UNESCAPED_UNICODE)).'\' data-titulo="'.esc(strip_tags(cv('proyecto.title'))).'"><div class="container">';
  echo '<div class="sec-row reveal"><div class="sec-head"><h2 '.ca('proyecto.title').'>'.ct('proyecto.title').'</h2>';
  if(chas('proyecto.text')) echo '<p class="lead" '.ca('proyecto.text').'>'.ct('proyecto.text').'</p>';
  echo '</div>';
  if($__n>$__v) echo '<button type="button" class="sec-link" data-gal-todas>'.aldea_icon('grid').'<span data-es="Ver las '.$__n.' fotos" data-en="See all '.$__n.' photos">Ver las '.$__n.' fotos</span></button>';
  echo '</div><div class="mosaic m'.$__v.' reveal">';
  for($k=0;$k<$__v;$k++){
    echo '<figure><button type="button" data-i="'.$k.'" aria-label="Ampliar foto '.($k+1).'">'
        .pic($__items[$k]['src'],strip_tags(cv('proyecto.title')).', foto '.($k+1),$k===0?'(max-width:760px) 100vw, 50vw':'(max-width:760px) 50vw, 25vw','loading="lazy"').'</button></figure>';
  }
  echo '</div></div></section>';
}

/* ---------- 7. SERVICIOS SEGUN LA OPERACION ---------- */
if(chas('servicios.title')){
  $__sv=clist('servicios.s',16);
  echo '<section class="section bg-soft" id="servicios"><div class="container"><div class="sec-head reveal">';
  echo '<h2 '.ca('servicios.title').'>'.ct('servicios.title').'</h2>';
  if(chas('servicios.text')) echo '<p class="lead" '.ca('servicios.text').'>'.ct('servicios.text').'</p>';
  echo '</div><ul class="ilist reveal" style="'.cols_vars(count($__sv)).'">';
  foreach($__sv as $k) echo '<li><span class="ico">'.render_icon(cv($k.'_icon','check')).'</span><span '.ca($k).'>'.ct($k).'</span></li>';
  echo '</ul></div></section>';
}

/* ---------- 8. TECNOLOGIA, SEGURIDAD E INFRAESTRUCTURA ---------- */
if(chas('tech.title')){
  echo '<section class="section" id="tech"><div class="container duo reveal">';
  echo '<figure class="duo-media">'.pic(cv('tech.img','/img/corporativas/corp-panoramica.webp'),strip_tags(cv('tech.title')),'(max-width:900px) 100vw, 58vw','loading="lazy"').'</figure>';
  echo '<div class="duo-copy"><h2 '.ca('tech.title').'>'.ct('tech.title').'</h2>';
  if(chas('tech.text')) echo '<p class="lead" '.ca('tech.text').'>'.ct('tech.text').'</p>';
  echo '<ul class="ilist top" style="--cd:1;--ct:1;--cm:1">';
  for($i=1;$i<=4;$i++){ if(!chas("tech.t{$i}_title")) continue;
    echo '<li><span class="ico">'.render_icon(cv("tech.t{$i}_icon",'check')).'</span><div><span '.ca("tech.t{$i}_title").'>'.ct("tech.t{$i}_title").'</span>'
        .(chas("tech.t{$i}_text")?'<p '.ca("tech.t{$i}_text").'>'.ct("tech.t{$i}_text").'</p>':'').'</div></li>'; }
  echo '</ul></div></div></section>';
}

/* ---------- 9. FORMULARIO CORPORATIVO ---------- */
// Telefono y correo salen de Ajustes: un solo lugar para las 9 paginas
$tel=setting('phone','+52 449 454 0709'); $telh='tel:'.preg_replace('/[^0-9+]/','',$tel);
echo '<section class="section bg-soft" id="formulario"><div class="container"><div class="formx reveal">';
echo '<figure class="formx-media">'.pic(cv('form.img','/img/corporativas/corp-cabinas.webp'),'Oficina corporativa de Aldea','(max-width:900px) 100vw, 45vw','loading="lazy"').'</figure>';
echo '<div class="formx-body"><h2 '.ca('form.title','Cuéntanos tu proyecto').'>'.ct('form.title','Cuéntanos tu proyecto').'</h2>';
if(chas('form.text')) echo '<p class="lead" '.ca('form.text').'>'.ct('form.text').'</p>';
echo '<form class="contact-form corp-form" onsubmit="return aldeaSubmit(event)" data-source="oficinas-corporativas" data-utm>';
echo '<input type="hidden" name="form_type" value="corporativo">';
echo '<input type="hidden" name="product" value="Proyecto Corporativo">';
echo '<div class="cf-2"><input name="name" type="text" required placeholder="Nombre" data-ph-es="Nombre" data-ph-en="Name" autocomplete="name">';
echo '<input name="company" type="text" required placeholder="Empresa" data-ph-es="Empresa" data-ph-en="Company" autocomplete="organization"></div>';
echo '<div class="cf-2"><input name="email" type="email" required placeholder="Correo corporativo" data-ph-es="Correo corporativo" data-ph-en="Work email" autocomplete="email">';
echo '<input name="phone" type="tel" placeholder="Teléfono / WhatsApp" data-ph-es="Teléfono / WhatsApp" data-ph-en="Phone / WhatsApp" autocomplete="tel"></div>';
echo '<div class="cf-2"><select name="team_size" required><option value="" disabled selected data-es="Tamaño del equipo" data-en="Team size">Tamaño del equipo</option>';
foreach(['100-150','151-250','251-500','+500'] as $r) echo '<option value="'.$r.'">'.$r.'</option>';
echo '</select>';
echo '<input name="city" type="text" placeholder="Ciudad o ubicación requerida" data-ph-es="Ciudad o ubicación requerida" data-ph-en="City or required location"></div>';
// En el telefono los datos opcionales se abren a peticion: el formulario visible queda en 6 campos
echo '<button type="button" class="cf-mas" aria-expanded="false" aria-controls="cfExtra">'.aldea_icon('plus').'<span data-es="Agregar detalles (opcional)" data-en="Add details (optional)">Agregar detalles (opcional)</span></button>';
echo '<div class="cf-extra" id="cfExtra">';
echo '<div class="cf-2"><input name="role" type="text" placeholder="Cargo" data-ph-es="Cargo" data-ph-en="Role" autocomplete="organization-title">';
echo '<label class="cf-month"><span data-es="Fecha objetivo de operación" data-en="Target move-in date">Fecha objetivo de operación</span><input name="target_date" type="month"></label></div>';
echo '<textarea name="message" rows="4" placeholder="Mensaje / necesidades principales" data-ph-es="Mensaje / necesidades principales" data-ph-en="Message / main requirements"></textarea>';
echo '</div>';
echo '<button type="submit" class="btn btn-accent w" '.ca('form.boton','Hablar con nuestro equipo corporativo').'>'.ct('form.boton','Hablar con nuestro equipo corporativo').'</button>';
echo '<small id="formMsg" data-es="Al enviar aceptas nuestras políticas de privacidad." data-en="By submitting you accept our privacy policy.">Al enviar aceptas nuestras políticas de privacidad.</small>';
echo '</form>';
echo '<div class="formx-alt"><span data-es="¿Prefieres hablar con nosotros?" data-en="Would you rather talk to us?">¿Prefieres hablar con nosotros?</span><a href="'.esc($telh).'">'.esc($tel).'</a></div>';
echo '</div></div></div></section>';

/* ---------- 10. PREGUNTAS FRECUENTES ---------- */
$qs=clist('faq.q',12);
if($qs){
  echo '<section class="section" id="faq"><div class="container faq2"><div class="sec-head reveal">';
  echo '<h2 '.ca('faq.title','Preguntas frecuentes').'>'.ct('faq.title','Preguntas frecuentes').'</h2></div><div class="faq reveal">';
  foreach($qs as $k){ $n=substr($k,strlen('faq.q'));
    echo '<details><summary '.ca($k).'>'.ct($k).'</summary><p '.ca('faq.a'.$n).'>'.ct('faq.a'.$n).'</p></details>'; }
  echo '</div></div></section>';
}

// Movil: barra fija con la accion principal
if(chas('hero.cta1')) barra_movil('<a href="'.esc(ch_('hero.cta1','#formulario')).'" class="btn btn-accent" '.ca('hero.cta1').'>'.ct('hero.cta1').'</a>');
echo '</main>';
site_footer();
site_scripts();
