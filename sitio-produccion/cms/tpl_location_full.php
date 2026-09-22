<?php
/* Plantilla ampliada de sede, dirigida por bloques.
   Se usa cuando existe una pagina oculta "loc:<slug>" con bloques cargados.
   Si no existe, tpl_location.php sigue con el diseno generico.
   $loc y $LB (bloques indexados por "seccion.clave") vienen en scope. */

function lv($k,$d=''){ global $LB; return isset($LB[$k]) && $LB[$k]['value_es']!==null && $LB[$k]['value_es']!=='' ? $LB[$k]['value_es'] : $d; }
function ln($k,$d=''){ global $LB; return isset($LB[$k]) && $LB[$k]['value_en']!==null && $LB[$k]['value_en']!=='' ? $LB[$k]['value_en'] : lv($k,$d); }
function lh_($k,$d=''){ global $LB; return isset($LB[$k]) && $LB[$k]['href']!==null && $LB[$k]['href']!=='' ? $LB[$k]['href'] : $d; }
function lhas($k){ return trim(strip_tags((string)lv($k,'')))!==''; }
function la($k,$d=''){ return 'data-es="'.esc(strip_tags(lv($k,$d))).'" data-en="'.esc(strip_tags(ln($k,$d))).'" data-blk="'.esc($k).'"'; }
function lt($k,$d=''){ return esc(strip_tags(lv($k,$d))); }
function llist($p,$max=12){ $o=[]; for($i=1;$i<=$max;$i++){ if(lhas($p.$i)) $o[]=$p.$i; } return $o; }

$gal=json_decode($loc['gallery']?:'[]',true); if(!is_array($gal)) $gal=[];
if(!$gal) $gal=array_filter([$loc['hero_image']]);
$near=json_decode($loc['nearby']?:'{}',true); if(!is_array($near)) $near=[];
$city=$loc['city_es']; $cityen=$loc['city_en']?:$city;
$addr=lv('hero.direccion',$loc['address_es']);
$video=trim((string)($loc['video_url']??''));

// La meta description usa el SEO propio; si no hay, la introduccion larga de la
// sede. El subtitulo del hero es demasiado corto para servir de descripcion.
$__desc = $loc['seo_desc_es'] ?: mb_strimwidth(strip_tags((string)$loc['intro_es']),0,155,'…');
site_head(($loc['seo_title_es']?:$loc['name'].' - Aldea Networking'),
          $__desc,
          '/'.$loc['slug'].'/',false,
          ($loc['seo_title_en']?:$loc['name'].' - Aldea Networking'),($loc['seo_desc_en']?:''));
site_header();
jsonld_sede($loc);   // ficha de negocio local para Google
echo '<main>';

/* ---------- 1. HERO + MOSAICO DE GALERIA ---------- */
echo '<section class="lhero" id="hero"><div class="container">';
echo '<div class="crumb"><a href="/" data-es="Inicio" data-en="Home">Inicio</a> / <a href="/ubicaciones/" data-es="Ubicaciones" data-en="Locations">Ubicaciones</a> / <span>'.esc($loc['name']).'</span></div>';
echo '<div class="lhero-top reveal"><div>';
echo '<h1 '.la('hero.titulo',$loc['name']).'>'.lt('hero.titulo',$loc['name']).'</h1>';
if(lhas('hero.subtitulo')) echo '<p class="lead" '.la('hero.subtitulo').'>'.lt('hero.subtitulo').'</p>';
echo '<p class="lhero-addr">'.render_icon('pin').'<span>'.esc($addr).'</span></p>';
// Aviso de apertura para sedes que aun no operan
if(lhas('hero.aviso')) echo '<p class="lhero-aviso" '.la('hero.aviso').'>'.lt('hero.aviso').'</p>';
echo '</div><div class="hero-cta lhero-cta">';
echo '<button type="button" class="btn btn-accent" data-visita '.la('hero.cta1','Agenda tu visita').'>'.lt('hero.cta1','Agenda tu visita').'</button>';
echo '<a href="#formulario" class="btn btn-ghost" '.la('hero.cta2','Cotizar').'>'.lt('hero.cta2','Cotizar').'</a>';
echo '</div></div>';

// Mosaico: hasta 5 piezas. El video ocupa una de ellas si existe.
$piezas=[];
foreach($gal as $u) $piezas[]=['tipo'=>'img','src'=>$u];
if($video!=='') array_splice($piezas,min(1,count($piezas)),0,[['tipo'=>'video','src'=>$video,'poster'=>($loc['video_poster']?:($gal[0]??''))]]);
$vis=array_slice($piezas,0,5);
echo '<div class="lmosaico reveal" data-galeria=\''.esc(json_encode($piezas,JSON_UNESCAPED_SLASHES|JSON_UNESCAPED_UNICODE)).'\'>';
foreach($vis as $i=>$p){
  $src=$p['tipo']==='video' ? ($p['poster']?:'') : $p['src'];
  echo '<button type="button" class="lmos-it'.($p['tipo']==='video'?' lmos-video':'').'" data-i="'.$i.'" aria-label="'.($p['tipo']==='video'?'Ver video de la sede':'Ver fotografia').'">';
  echo '<img src="'.esc($src).'" alt="'.esc($loc['name']).'"'.($i===0?'':' loading="lazy"').'>';
  if($p['tipo']==='video') echo '<span class="lmos-play"><svg viewBox="0 0 24 24"><path d="M8 5v14l11-7z"/></svg></span>';
  echo '</button>';
}
if(count($piezas)>count($vis) || $piezas)
  echo '<button type="button" class="lmos-todas" data-i="0" data-es="Ver todas las fotos" data-en="See all photos">Ver todas las fotos</button>';
echo '</div></div></section>';

/* ---------- 2. EMPRESAS ---------- */
if(lhas('empresas.title')) render_clients(lv('empresas.title'),ln('empresas.title'),10);

/* ---------- 3. POR QUE ESTA SEDE ---------- */
if(lhas('porque.title')){
  echo '<section class="section" id="porque"><div class="container"><div class="sec-head center reveal">';
  echo '<h2 '.la('porque.title').'>'.lt('porque.title').'</h2>';
  if(lhas('porque.text')) echo '<p class="lead" '.la('porque.text').'>'.lt('porque.text').'</p>';
  echo '</div><div class="dif-grid reveal">';
  for($i=1;$i<=4;$i++){ if(!lhas("porque.d{$i}")) continue;
    echo '<div class="dif"><span class="dif-ic">'.render_icon(lv("porque.d{$i}_icon",'check')).'</span>'
        .'<b '.la("porque.d{$i}").'>'.lt("porque.d{$i}").'</b></div>'; }
  echo '</div></div></section>';
}

/* ---------- 4. ESPACIOS DISPONIBLES ---------- */
if(lhas('espacios.title')){
  $precios=[
    1=>$loc['price_privada'],
    2=>$loc['price_cowork'],
    3=>($loc['price_desk']??''),
    4=>$loc['price_virtual'],
  ];
  echo '<section class="section bg-soft" id="espacios"><div class="container"><div class="sec-head center reveal">';
  echo '<h2 '.la('espacios.title').'>'.lt('espacios.title').'</h2></div><div class="esp-list">';
  for($i=1;$i<=4;$i++){
    if(!lhas("espacios.p{$i}_title")) continue;
    $val=lv("espacios.p{$i}_valor",lv("espacios.p{$i}_title"));
    $precio=trim((string)$precios[$i]);
    echo '<article class="esp-card reveal">';
    echo '<div class="esp-img"><img src="'.esc(lv("espacios.p{$i}_img",$loc['hero_image'])).'" alt="'.lt("espacios.p{$i}_title").'" loading="lazy"></div>';
    echo '<div class="esp-body"><h3 '.la("espacios.p{$i}_title").'>'.lt("espacios.p{$i}_title").'</h3>';
    echo '<p '.la("espacios.p{$i}_text").'>'.lt("espacios.p{$i}_text").'</p>';
    if(lhas("espacios.p{$i}_meta")) echo '<span class="esp-meta" '.la("espacios.p{$i}_meta").'>'.lt("espacios.p{$i}_meta").'</span>';
    if(lhas("espacios.p{$i}_nota")) echo '<span class="esp-nota" '.la("espacios.p{$i}_nota").'>'.lt("espacios.p{$i}_nota").'</span>';
    echo '</div><div class="esp-side">';
    if($precio!==''){
      echo '<p class="esp-precio"><small data-es="Desde" data-en="From">Desde</small><b>$'.esc($precio).'</b>'
          .'<small>'.lt("espacios.p{$i}_periodo",'+ IVA / mes').'</small></p>';
    } else {
      echo '<p class="esp-precio esp-precio-na"><small data-es="Precio a consultar" data-en="Price on request">Precio a consultar</small></p>';
    }
    echo '<button type="button" class="btn btn-accent esp-cta" data-producto="'.esc($val).'" data-es="Cotizar &rarr;" data-en="Get a quote &rarr;">Cotizar &rarr;</button>';
    echo '</div></article>';
  }
  echo '</div>';
  if(lhas('espacios.nota')) echo '<p class="amen-note reveal" '.la('espacios.nota').'>'.lt('espacios.nota').'</p>';
  echo '</div></section>';
}

/* ---------- 5. SERVICIOS INCLUIDOS ---------- */
if(lhas('servicios.title')){
  echo '<section class="section" id="servicios"><div class="container"><div class="sec-head center reveal">';
  echo '<h2 '.la('servicios.title').'>'.lt('servicios.title').'</h2></div><div class="amen-grid reveal">';
  for($i=1;$i<=14;$i++){ if(!lhas("servicios.s{$i}")) continue;
    echo '<div class="amen"><i>'.render_icon(lv("servicios.s{$i}_icon",'check')).'</i><span '.la("servicios.s{$i}").'>'.lt("servicios.s{$i}").'</span></div>'; }
  echo '</div></div></section>';
}

/* ---------- 6. TECNOLOGIA, SEGURIDAD Y SOPORTE ---------- */
if(lhas('tech.title')){
  echo '<section class="section bg-navy" id="tech"><div class="container"><div class="sec-head center on-dark reveal">';
  echo '<h2 '.la('tech.title').'>'.lt('tech.title').'</h2></div><div class="tech-grid reveal">';
  $ic=['wifi','shield','support'];
  for($i=1;$i<=3;$i++){ if(!lhas("tech.t{$i}_title")) continue;
    echo '<article class="tech-card"><div class="bico">'.render_icon(lv("tech.t{$i}_icon",$ic[$i-1])).'</div>'
        .'<h3 '.la("tech.t{$i}_title").'>'.lt("tech.t{$i}_title").'</h3>'
        .'<p '.la("tech.t{$i}_text").'>'.lt("tech.t{$i}_text").'</p></article>'; }
  echo '</div></div></section>';
}

/* ---------- 7. UBICACION + MAPA ---------- */
if(lhas('mapa.title')){
  $q=rawurlencode($loc['map_query']?:($loc['name'].' '.$city));
  echo '<section class="section bg-soft" id="ubicacion"><div class="container"><div class="sec-head center reveal">';
  echo '<h2 '.la('mapa.title').'>'.lt('mapa.title').'</h2>';
  echo '<p class="lead">'.esc($addr).'</p></div><div class="locmap-grid reveal">';
  echo '<div class="locmap-map"><iframe class="map-embed" loading="lazy" title="Mapa de '.esc($loc['name']).'" src="https://maps.google.com/maps?q='.$q.'&t=m&z=15&output=embed&iwloc=near"></iframe></div>';
  echo '<div class="locmap-side"><div class="near-grid">';
  // Solo nombres: el brief pide no mostrar tiempos de traslado
  foreach($near as $cat=>$items){
    echo '<div class="near"><h4>'.esc($cat).'</h4><ul>';
    foreach($items as $it){ $n=is_array($it)?($it[0]??''):$it; if($n==='')continue; echo '<li><span>'.esc($n).'</span></li>'; }
    echo '</ul></div>';
  }
  echo '</div></div></div></div></section>';
}

/* ---------- 8. TESTIMONIOS DE LA SEDE ---------- */
$tq=llist('testi.q',3);
if($tq){
  echo '<section class="section testi" id="testimonios"><div class="container"><div class="sec-head center on-dark reveal">';
  echo '<h2 '.la('testi.title','Lo que dicen nuestros clientes').'>'.lt('testi.title','Lo que dicen nuestros clientes').'</h2></div><div class="testi-solo reveal">';
  foreach($tq as $k){ $n=substr($k,strlen('testi.q'));
    echo '<figure class="tcard"><div class="q">&ldquo;</div><blockquote '.la($k).'>'.lt($k).'</blockquote>'
        .'<figcaption><span><b '.la('testi.n'.$n).'>'.lt('testi.n'.$n).'</b><small '.la('testi.e'.$n).'>'.lt('testi.e'.$n).'</small></span></figcaption></figure>'; }
  echo '</div></div></section>';
}

/* ---------- 9. FORMULARIO DE COTIZACION ---------- */
// Telefono y correo salen de Ajustes: un solo lugar para las 9 paginas
$tel=setting('phone','+52 449 454 0709'); $telh='tel:'.preg_replace('/[^0-9+]/','',$tel);
echo '<section class="section" id="formulario"><div class="container contact-in"><div class="contact-copy reveal">';
echo '<h2 '.la('form.title','Encuentra tu espacio').'>'.lt('form.title','Encuentra tu espacio').'</h2>';
if(lhas('form.lead')) echo '<p class="lead" '.la('form.lead').'>'.lt('form.lead').'</p>';
echo '<p class="contact-ask" data-es="¿Prefieres hablar con nosotros?" data-en="Would you rather talk to us?">¿Prefieres hablar con nosotros?</p>';
echo '<p class="contact-phone"><a class="contact-tel" href="'.esc($telh).'">'.esc($tel).'</a></p>';
echo '<p class="contact-phone"><button type="button" class="linklike" data-visita data-es="O agenda una visita a la sede" data-en="Or book a visit">O agenda una visita a la sede</button></p>';
echo '</div><form class="contact-form reveal" onsubmit="return aldeaSubmit(event)" data-source="'.esc($loc['slug']).'" data-sede="'.esc($loc['name']).'" data-utm>';
echo '<input type="hidden" name="form_type" value="cotizacion">';
echo '<input type="hidden" name="location" value="'.esc($loc['name']).'">';
echo '<input name="name" type="text" required placeholder="Nombre" data-ph-es="Nombre" data-ph-en="Name">';
echo '<input name="company" type="text" placeholder="Empresa" data-ph-es="Empresa" data-ph-en="Company">';
echo '<input name="phone" type="tel" placeholder="Teléfono / WhatsApp" data-ph-es="Teléfono / WhatsApp" data-ph-en="Phone / WhatsApp">';
echo '<input name="email" type="email" required placeholder="Correo" data-ph-es="Correo" data-ph-en="Email">';
echo '<select name="team_size" required><option value="" disabled selected data-es="Número de personas" data-en="Number of people">Número de personas</option>';
foreach(['1','2-5','6-10','11-20','21-50','51-100'] as $r) echo '<option value="'.$r.'">'.str_replace('-','–',$r).'</option>';
echo '</select>';
echo '<select name="product" id="prodSel" required><option value="" disabled selected data-es="Espacio de interés" data-en="Space of interest">Espacio de interés</option>';
for($i=1;$i<=4;$i++){ if(!lhas("espacios.p{$i}_title")) continue; $v=lv("espacios.p{$i}_valor",lv("espacios.p{$i}_title")); echo '<option value="'.esc($v).'">'.esc($v).'</option>'; }
echo '<option value="No estoy seguro" data-es="No estoy seguro" data-en="Not sure yet">No estoy seguro</option></select>';
echo '<button type="submit" class="btn btn-accent w" '.la('form.boton','Solicitar cotización').'>'.lt('form.boton','Solicitar cotización').'</button>';
echo '<small id="formMsg" data-es="Al enviar aceptas nuestras políticas de privacidad." data-en="By submitting you accept our privacy policy.">Al enviar aceptas nuestras políticas de privacidad.</small>';
echo '</form></div></section>';

/* ---------- 10. MODAL: AGENDA TU VISITA ---------- */
echo '<div class="vmodal" id="vmodal" hidden><div class="vmodal-bg" data-vclose></div><div class="vmodal-card" role="dialog" aria-modal="true" aria-labelledby="vmTitle">';
echo '<button class="vmodal-x" data-vclose aria-label="Cerrar"><svg viewBox="0 0 24 24"><path d="M6 6l12 12M18 6L6 18"/></svg></button>';
echo '<h3 id="vmTitle" '.la('visita.title','Agenda tu visita').'>'.lt('visita.title','Agenda tu visita').'</h3>';
echo '<p '.la('visita.lead','Elige el día y horario que mejor te acomode y te esperamos en la sede.').'>'.lt('visita.lead','Elige el día y horario que mejor te acomode y te esperamos en la sede.').'</p>';
echo '<form class="contact-form" onsubmit="return aldeaSubmit(event)" data-source="'.esc($loc['slug']).'-visita" data-utm>';
echo '<input type="hidden" name="form_type" value="visita">';
echo '<input type="hidden" name="location" value="'.esc($loc['name']).'">';
echo '<div class="vmodal-2"><input name="visit_date" type="date" required aria-label="Fecha">';
echo '<select name="visit_time" required aria-label="Horario"><option value="" disabled selected data-es="Horario" data-en="Time">Horario</option>';
foreach(['09:00','10:00','11:00','12:00','13:00','16:00','17:00','18:00'] as $hh) echo '<option value="'.$hh.'">'.$hh.'</option>';
echo '</select></div>';
echo '<input name="name" type="text" required placeholder="Nombre" data-ph-es="Nombre" data-ph-en="Name">';
echo '<input name="company" type="text" placeholder="Empresa" data-ph-es="Empresa" data-ph-en="Company">';
echo '<input name="phone" type="tel" placeholder="Teléfono / WhatsApp" data-ph-es="Teléfono / WhatsApp" data-ph-en="Phone / WhatsApp">';
echo '<input name="email" type="email" required placeholder="Correo" data-ph-es="Correo" data-ph-en="Email">';
echo '<select name="team_size" required><option value="" disabled selected data-es="Número de personas" data-en="Number of people">Número de personas</option>';
foreach(['1','2-5','6-10','11-20','21-50','51-100'] as $r) echo '<option value="'.$r.'">'.str_replace('-','–',$r).'</option>';
echo '</select>';
echo '<button type="submit" class="btn btn-accent w" '.la('visita.boton','Agendar visita').'>'.lt('visita.boton','Agendar visita').'</button>';
echo '<small data-es="Te confirmaremos la visita por teléfono o correo." data-en="We will confirm your visit by phone or email.">Te confirmaremos la visita por teléfono o correo.</small>';
echo '</form></div></div>';

/* ---------- 11. PREGUNTAS FRECUENTES ---------- */
$qs=llist('faq.q',10);
if($qs){
  echo '<section class="section bg-soft" id="faq"><div class="container"><div class="sec-head center reveal">';
  echo '<h2 '.la('faq.title','Preguntas frecuentes').'>'.lt('faq.title','Preguntas frecuentes').'</h2></div><div class="faq reveal">';
  foreach($qs as $k){ $n=substr($k,strlen('faq.q'));
    echo '<details><summary '.la($k).'>'.lt($k).'</summary><p '.la('faq.a'.$n).'>'.lt('faq.a'.$n).'</p></details>'; }
  echo '</div></div></section>';
}

echo '</main>';
site_footer();
site_scripts();
