<?php
/* Plantilla ampliada de sede, dirigida por bloques.
   Se usa cuando existe una pagina oculta "loc:<slug>" con bloques cargados.
   Si no existe, tpl_location.php sigue con el diseno generico.
   $loc y $LB (bloques indexados por "seccion.clave") vienen en scope.

   Orden (rediseno 2026-09, referencia wework.com): la galeria a sangre abre la
   pagina; debajo van el nombre, la direccion discreta y los botones. Sin migas
   de pan visibles (van en datos estructurados). */

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
$name=$loc['name'];

// Piezas del visor: primero las fotos, al final el video (si lo hay).
$__root=$_SERVER['DOCUMENT_ROOT']??'';
$items=[];
foreach(array_values($gal) as $u){
  $sm=preg_replace('/\.webp$/','-sm.webp',(string)$u);
  $items[]=['tipo'=>'img','src'=>$u,'sm'=>($sm!==$u && is_file($__root.$sm))?$sm:$u];
}
$nf=count($items);
$videoIdx=null;
if($video!==''){ $videoIdx=$nf; $items[]=['tipo'=>'video','src'=>$video]; }
// Una foto distinta para cada seccion, sin repetir la portada.
$foto=function($i) use($items,$nf){ return $nf? $items[min($i,$nf-1)]['src'] : ''; };
// Cada foto sale una sola vez en la pagina. La galeria de arriba muestra las 5 primeras;
// "por que", las tarjetas de espacios y el formulario toman de las demas, y el carrusel
// se queda con lo que sobra. "Ver las N fotos" sigue abriendo todas.
$__visibles=min(5,$nf);
$__usadas=[]; for($k=0;$k<$__visibles;$k++) $__usadas[]=$items[$k]['src'];
// Primera foto sin usar; si ya no queda ninguna (sedes con pocas fotos), la menos repetida.
$__libre=function($desdeAtras=false) use(&$__usadas,$items,$nf){
  $cuenta=array_count_values($__usadas); $mejor=''; $min=PHP_INT_MAX;
  for($n=0;$n<$nf;$n++){ $k=$desdeAtras?$nf-1-$n:$n; $c=$cuenta[$items[$k]['src']]??0; if($c<$min){ $min=$c; $mejor=$items[$k]['src']; } }
  return $mejor;
};
$__usa=function($src) use(&$__usadas){ if($src!=='') $__usadas[]=$src; return $src; };
$__porqueImg=$__usa(lv('porque.img','') ?: ($__libre() ?: $foto(1)));
$__espImg=[]; for($i=1;$i<=4;$i++){ if(lhas("espacios.p{$i}_title")) $__espImg[$i]=$__usa(lv("espacios.p{$i}_img",$loc['hero_image'])); }
$__formImg=$__usa(lv('form.img','') ?: ($__libre(true) ?: $foto(3)));
$__rail=[]; for($k=0;$k<$nf;$k++){ if(!in_array($items[$k]['src'],$__usadas,true)) $__rail[]=$k; }

// La meta description usa el SEO propio; si no hay, la introduccion larga de la
// sede. El subtitulo del hero es demasiado corto para servir de descripcion.
$__desc = $loc['seo_desc_es'] ?: mb_strimwidth(strip_tags((string)$loc['intro_es']),0,155,'…');
site_head(($loc['seo_title_es']?:$name.' - Aldea Networking'),
          $__desc,
          '/'.$loc['slug'].'/',false,
          ($loc['seo_title_en']?:$name.' - Aldea Networking'),($loc['seo_desc_en']?:''));
site_header();
jsonld_sede($loc);   // ficha de negocio local para Google
jsonld_breadcrumbs([['Inicio','/'],['Ubicaciones','/ubicaciones/'],[$name,'/'.$loc['slug'].'/']]);
echo '<main>';

/* ---------- 1. GALERIA A SANGRE ---------- */
$__cls=$nf>=5?'':($nf>=3?' n3':' n1');
echo '<section class="sgal" id="fotos" data-galeria=\''.esc(json_encode($items,JSON_UNESCAPED_SLASHES|JSON_UNESCAPED_UNICODE)).'\' data-titulo="'.esc($name).'">';
echo '<div class="sgal-grid'.$__cls.'">';
foreach($items as $k=>$p){
  if($p['tipo']!=='img') continue;
  // En el telefono la galeria es alta (58 % de la pantalla) y la foto se recorta a lo alto: pide la de 1920 px
  $sizes=$k===0?'(max-width:760px) 150vw, 50vw':'(max-width:760px) 150vw, 25vw';
  echo '<button type="button" class="sgal-it" data-i="'.$k.'" aria-label="'.esc($name).': '.L('foto','photo').' '.($k+1).' '.L('de','of').' '.$nf.'">'
      .pic($p['src'],$name.', '.L('foto','photo').' '.($k+1),$sizes,$k===0?'fetchpriority="high"':'loading="lazy"').'</button>';
}
echo '</div>';
if($nf>1) echo '<span class="sgal-count" aria-hidden="true"><b>1</b> / '.$nf.'</span>';
echo '<div class="sgal-actions">';
if($nf>1) echo '<button type="button" class="pill-btn" data-gal-todas>'.aldea_icon('grid').'<span data-es="Ver las '.$nf.' fotos" data-en="See all '.$nf.' photos">Ver las '.$nf.' fotos</span></button>';
if($videoIdx!==null) echo '<button type="button" class="pill-btn" data-gal-i="'.$videoIdx.'">'.aldea_icon('play').'<span data-es="Ver recorrido" data-en="Watch the tour">Ver recorrido</span></button>';
echo '</div></section>';

/* ---------- 2. FICHA: nombre, direccion discreta y botones ---------- */
echo '<div class="container"><div class="sintro">';
echo '<div><h1 '.la('hero.titulo',$name).'>'.lt('hero.titulo',$name).'</h1>';
if(lhas('hero.subtitulo')) echo '<p class="sintro-sub" '.la('hero.subtitulo').'>'.lt('hero.subtitulo').'</p>';
echo '<a class="saddr" href="#ubicacion">'.aldea_icon('pin').'<span>'.esc($addr).'</span></a>';
// Aviso de apertura para sedes que aun no operan
if(lhas('hero.aviso')) echo '<span class="saviso" '.la('hero.aviso').'>'.lt('hero.aviso').'</span>';
echo '</div><div class="hero-cta">';
echo '<button type="button" class="btn btn-accent" data-visita '.la('hero.cta1','Agenda tu visita').'>'.lt('hero.cta1','Agenda tu visita').'</button>';
echo '<a href="#formulario" class="btn btn-ghost" '.la('hero.cta2','Cotizar').'>'.lt('hero.cta2','Cotizar').'</a>';
echo '</div></div></div>';

/* ---------- 3. EMPRESAS ---------- */
if(lhas('empresas.title')) render_clients(lv('empresas.title'),ln('empresas.title'),10);

/* ---------- 4. POR QUE ESTA SEDE: texto, diferenciadores y una foto grande ---------- */
if(lhas('porque.title')){
  echo '<section class="section" id="porque"><div class="container duo rev reveal">';
  echo '<figure class="duo-media">'.pic($__porqueImg,$name,'(max-width:900px) 100vw, 58vw','loading="lazy"').'</figure>';
  echo '<div class="duo-copy"><h2 '.la('porque.title').'>'.lt('porque.title').'</h2>';
  if(lhas('porque.text')) echo '<p class="lead" '.la('porque.text').'>'.lt('porque.text').'</p>';
  $__d=[]; for($i=1;$i<=4;$i++){ if(lhas("porque.d{$i}")) $__d[]=$i; }
  if($__d){
    echo '<ul class="ilist" style="--cd:1;--ct:1;--cm:1">';
    foreach($__d as $i) echo '<li><span class="ico">'.render_icon(lv("porque.d{$i}_icon",'check')).'</span><span '.la("porque.d{$i}").'>'.lt("porque.d{$i}").'</span></li>';
    echo '</ul>';
  }
  echo '</div></div></section>';
}

/* ---------- 5. ESPACIOS DISPONIBLES ---------- */
if(lhas('espacios.title')){
  $precios=[1=>$loc['price_privada'],2=>$loc['price_cowork'],3=>($loc['price_desk']??''),4=>$loc['price_virtual']];
  echo '<section class="section bg-soft" id="espacios"><div class="container"><div class="sec-head reveal">';
  // Rejilla exacta: 4 tarjetas en 2 x 2, 3 en una fila, 2 en una fila, 1 horizontal
  $__nEsp=count($__espImg); $__c=$__nEsp===3?3:($__nEsp===1?1:2);
  echo '<h2 '.la('espacios.title').'>'.lt('espacios.title').'</h2></div><div class="esp-list swipe'.($__c===1?' c1':'').'" data-swipe style="--c:'.$__c.'">';
  for($i=1;$i<=4;$i++){
    if(!lhas("espacios.p{$i}_title")) continue;
    $val=lv("espacios.p{$i}_valor",lv("espacios.p{$i}_title"));
    $precio=trim((string)$precios[$i]);
    echo '<article class="esp-card reveal">';
    echo '<div class="esp-img">'.pic($__espImg[$i],strip_tags(L(lv("espacios.p{$i}_title"),ln("espacios.p{$i}_title"))),'(max-width:640px) 100vw, (max-width:980px) 50vw, '.($__c===3?'420px':'650px'),'loading="lazy"').'</div>';
    echo '<div class="esp-body"><h3 '.la("espacios.p{$i}_title").'>'.lt("espacios.p{$i}_title").'</h3>';
    echo '<p '.la("espacios.p{$i}_text").'>'.lt("espacios.p{$i}_text").'</p>';
    if(lhas("espacios.p{$i}_meta")) echo '<span class="esp-dato">'.aldea_icon('users').'<span '.la("espacios.p{$i}_meta").'>'.lt("espacios.p{$i}_meta").'</span></span>';
    echo '</div><div class="esp-side">';
    if($precio!==''){
      echo '<p class="esp-precio"><small data-es="Desde" data-en="From">Desde</small><b>$'.esc($precio).'</b>'
          .'<small>'.lt("espacios.p{$i}_periodo",'+ IVA / mes').'</small></p>';
    } else {
      echo '<p class="esp-precio esp-precio-na"><small data-es="Precio a consultar" data-en="Price on request">Precio a consultar</small></p>';
    }
    echo '<button type="button" class="btn btn-accent esp-cta" data-producto="'.esc($val).'" data-es="Cotizar" data-en="Get a quote">Cotizar</button>';
    echo '</div></article>';
  }
  echo '</div>';
  if(lhas('espacios.nota')) echo '<p class="fine" '.la('espacios.nota').'>'.lt('espacios.nota').'</p>';
  echo '</div></section>';
}

/* ---------- 6. CONOCE LA SEDE: las fotos que no salen en otra parte ---------- */
if(count($__rail)>=3){
  echo '<section class="section" id="recorrido"><div class="container">';
  echo '<div class="sec-row reveal"><div class="sec-head"><h2 data-es="Conoce '.esc($name).'" data-en="Inside '.esc($name).'">Conoce '.esc($name).'</h2></div>';
  if($videoIdx!==null) echo '<button type="button" class="sec-link" data-gal-i="'.$videoIdx.'">'.aldea_icon('play').'<span data-es="Ver recorrido en video" data-en="Watch the video tour">Ver recorrido en video</span></button>';
  echo '</div><div class="rail" data-rail style="--item:min(620px,84vw)"><div class="rail-track">';
  foreach($__rail as $k){
    $p=$items[$k];
    echo '<button type="button" class="rail-photo" data-gal-i="'.$k.'" aria-label="'.L('Ampliar foto','Enlarge photo').' '.($k+1).'">'.pic($p['src'],$name.', '.L('foto','photo').' '.($k+1),'(max-width:760px) 84vw, 620px','loading="lazy"').'</button>';
  }
  echo '</div>'.rail_ctrl().'</div></div></section>';
}

/* ---------- 7. SERVICIOS INCLUIDOS: iconos sin cajas, rejilla exacta ---------- */
if(lhas('servicios.title')){
  $__s=[]; for($i=1;$i<=14;$i++){ if(lhas("servicios.s{$i}")) $__s[]=$i; }
  echo '<section class="section bg-soft" id="servicios"><div class="container"><div class="sec-head reveal">';
  echo '<h2 '.la('servicios.title').'>'.lt('servicios.title').'</h2></div>';
  echo '<ul class="ilist reveal" style="'.cols_vars(count($__s)).'">';
  foreach($__s as $i) echo '<li><span class="ico">'.render_icon(lv("servicios.s{$i}_icon",'check')).'</span><span '.la("servicios.s{$i}").'>'.lt("servicios.s{$i}").'</span></li>';
  echo '</ul></div></section>';
}
// La seccion "tecnologia" (conectividad, seguridad y soporte) repetia tres servicios
// de la lista de arriba; sus campos siguen en el panel pero ya no se dibujan aqui.

/* ---------- 8. UBICACION + MAPA ---------- */
if(lhas('mapa.title')){
  $q=rawurlencode($loc['map_query']?:($name.' '.$city));
  echo '<section class="section" id="ubicacion"><div class="container">';
  echo '<div class="sec-row reveal"><div class="sec-head"><h2 '.la('mapa.title').'>'.lt('mapa.title').'</h2>';
  echo '<p class="lead">'.esc($addr).'</p></div>';
  echo '<a class="sec-link" href="https://www.google.com/maps/dir/?api=1&amp;destination='.$q.'" target="_blank" rel="noopener">'.aldea_icon('route').'<span data-es="Cómo llegar" data-en="Get directions">Cómo llegar</span></a></div>';
  echo '<div class="locmap-grid reveal">';
  // Debajo del mapa, la direccion: es lo que se ve mientras carga (o si Google Maps no carga)
  echo '<div class="locmap-map"><div class="locmap-ph" aria-hidden="true">'.aldea_icon('pin').'<span>'.esc($addr).'</span></div><iframe class="map-embed" loading="lazy" title="'.L('Mapa de','Map of').' '.esc($name).'" src="https://maps.google.com/maps?q='.$q.'&amp;t=m&amp;z=15&amp;output=embed&amp;iwloc=near"></iframe></div>';
  echo '<div class="locmap-side"><div class="near-grid swipe" data-swipe>';
  // Solo nombres: el brief pide no mostrar tiempos de traslado
  foreach($near as $cat=>$items_){
    echo '<div class="near"><h3>'.esc($cat).'</h3><ul>';
    foreach($items_ as $it){ $n=is_array($it)?($it[0]??''):$it; if($n==='')continue; echo '<li><span>'.esc($n).'</span></li>'; }
    echo '</ul></div>';
  }
  echo '</div></div></div></div></section>';
}

/* ---------- 9. TESTIMONIOS DE LA SEDE ---------- */
$tq=llist('testi.q',3);
if($tq){
  echo '<section class="section bg-soft" id="testimonios"><div class="container"><div class="sec-head reveal">';
  echo '<h2 '.la('testi.title','Lo que dicen nuestros clientes').'>'.lt('testi.title','Lo que dicen nuestros clientes').'</h2></div>';
  // Foto y logo de cada opinion: salen de Testimonios (el mismo registro que usa el inicio), por nombre.
  $__tp=[]; foreach(cms_pdo()->query("SELECT t.name,t.avatar,t.company_logo,c.logo AS clogo FROM testimonials t LEFT JOIN clients c ON c.id=t.client_id") as $r) $__tp[mb_strtolower(trim((string)$r['name']))]=$r;
  echo '<div class="tgrid swipe reveal" data-swipe style="--n:'.count($tq).'">';
  foreach($tq as $k){ $n=substr($k,strlen('testi.q'));
    $__p=$__tp[mb_strtolower(trim(strip_tags((string)lv('testi.n'.$n))))]??null;
    $__av=$__p['avatar']??''; $__co=$__p?(($__p['company_logo']??'')?:($__p['clogo']??'')):'';
    echo '<figure class="tq"><blockquote '.la($k).'>'.lt($k).'</blockquote><figcaption>'
        .($__av?'<img src="'.esc($__av).'" alt="" width="48" height="48" loading="lazy">':'<span class="tq-ini" aria-hidden="true">'.esc(iniciales(lv('testi.n'.$n))).'</span>')
        .'<span><b '.la('testi.n'.$n).'>'.lt('testi.n'.$n).'</b><small '.la('testi.e'.$n).'>'.lt('testi.e'.$n).'</small></span>'
        .($__co?'<img class="tco" src="'.esc($__co).'" alt="" loading="lazy">':'').'</figcaption></figure>'; }
  echo '</div></div></section>';
}

/* ---------- 10. FORMULARIO DE COTIZACION ---------- */
// Telefono y correo salen de Ajustes: un solo lugar para las 9 paginas
$tel=setting('phone','+52 449 454 0709'); $telh='tel:'.preg_replace('/[^0-9+]/','',$tel);
echo '<section class="section" id="formulario"><div class="container"><div class="formx reveal">';
echo '<figure class="formx-media">'.pic($__formImg,$name,'(max-width:900px) 100vw, 45vw','loading="lazy"').'</figure>';
echo '<div class="formx-body"><h2 '.la('form.title','Encuentra tu espacio').'>'.lt('form.title','Encuentra tu espacio').'</h2>';
if(lhas('form.lead')) echo '<p class="lead" '.la('form.lead').'>'.lt('form.lead').'</p>';
echo '<form class="contact-form" onsubmit="return aldeaSubmit(event)" data-source="'.esc($loc['slug']).'" data-sede="'.esc($name).'" data-utm>';
echo '<input type="hidden" name="form_type" value="cotizacion">';
echo '<input type="hidden" name="location" value="'.esc($name).'">';
echo '<div class="cf-2"><input name="name" type="text" required placeholder="Nombre" data-ph-es="Nombre" data-ph-en="Name" autocomplete="name">';
echo '<input name="company" type="text" placeholder="Empresa" data-ph-es="Empresa" data-ph-en="Company" autocomplete="organization"></div>';
echo '<div class="cf-2"><input name="phone" type="tel" placeholder="Teléfono / WhatsApp" data-ph-es="Teléfono / WhatsApp" data-ph-en="Phone / WhatsApp" autocomplete="tel">';
echo '<input name="email" type="email" required placeholder="Correo" data-ph-es="Correo" data-ph-en="Email" autocomplete="email"></div>';
echo '<div class="cf-2"><select name="team_size" required><option value="" disabled selected data-es="Número de personas" data-en="Number of people">Número de personas</option>';
foreach(['1','2-5','6-10','11-20','21-50','51-100'] as $r) echo '<option value="'.$r.'">'.$r.'</option>';
echo '</select>';
echo '<select name="product" id="prodSel" required><option value="" disabled selected data-es="Espacio de interés" data-en="Space of interest">Espacio de interés</option>';
for($i=1;$i<=4;$i++){ if(!lhas("espacios.p{$i}_title")) continue; $v=lv("espacios.p{$i}_valor",lv("espacios.p{$i}_title")); echo '<option value="'.esc($v).'">'.esc($v).'</option>'; }
echo '<option value="No estoy seguro" data-es="No estoy seguro" data-en="Not sure yet">No estoy seguro</option></select></div>';
echo '<button type="submit" class="btn btn-accent w" '.la('form.boton','Solicitar cotización').'>'.lt('form.boton','Solicitar cotización').'</button>';
echo '<small id="formMsg" data-es="Al enviar aceptas nuestras políticas de privacidad." data-en="By submitting you accept our privacy policy.">Al enviar aceptas nuestras políticas de privacidad.</small>';
echo '</form>';
echo '<div class="formx-alt"><a href="'.esc($telh).'">'.esc($tel).'</a><button type="button" data-visita data-es="Agendar una visita" data-en="Book a visit">Agendar una visita</button></div>';
echo '</div></div></div></section>';

/* ---------- 11. MODAL: AGENDA TU VISITA ---------- */
echo '<div class="vmodal" id="vmodal" hidden><div class="vmodal-bg" data-vclose></div><div class="vmodal-card" role="dialog" aria-modal="true" aria-labelledby="vmTitle">';
echo '<button class="vmodal-x" data-vclose aria-label="'.L('Cerrar','Close').'"><svg viewBox="0 0 24 24"><path d="M6 6l12 12M18 6L6 18"/></svg></button>';
echo '<h3 id="vmTitle" '.la('visita.title','Agenda tu visita').'>'.lt('visita.title','Agenda tu visita').'</h3>';
echo '<p '.la('visita.lead','Elige el día y horario que mejor te acomode y te esperamos en la sede.').'>'.lt('visita.lead','Elige el día y horario que mejor te acomode y te esperamos en la sede.').'</p>';
echo '<form class="contact-form" onsubmit="return aldeaSubmit(event)" data-source="'.esc($loc['slug']).'-visita" data-utm>';
echo '<input type="hidden" name="form_type" value="visita">';
echo '<input type="hidden" name="location" value="'.esc($name).'">';
echo '<div class="vmodal-2"><input name="visit_date" type="date" required aria-label="'.L('Fecha','Date').'">';
echo '<select name="visit_time" required aria-label="'.L('Horario','Time').'"><option value="" disabled selected data-es="Horario" data-en="Time">Horario</option>';
foreach(['09:00','10:00','11:00','12:00','13:00','16:00','17:00','18:00'] as $hh) echo '<option value="'.$hh.'">'.$hh.'</option>';
echo '</select></div>';
echo '<input name="name" type="text" required placeholder="Nombre" data-ph-es="Nombre" data-ph-en="Name" autocomplete="name">';
echo '<input name="company" type="text" placeholder="Empresa" data-ph-es="Empresa" data-ph-en="Company" autocomplete="organization">';
echo '<input name="phone" type="tel" placeholder="Teléfono / WhatsApp" data-ph-es="Teléfono / WhatsApp" data-ph-en="Phone / WhatsApp" autocomplete="tel">';
echo '<input name="email" type="email" required placeholder="Correo" data-ph-es="Correo" data-ph-en="Email" autocomplete="email">';
echo '<select name="team_size" required><option value="" disabled selected data-es="Número de personas" data-en="Number of people">Número de personas</option>';
foreach(['1','2-5','6-10','11-20','21-50','51-100'] as $r) echo '<option value="'.$r.'">'.$r.'</option>';
echo '</select>';
echo '<button type="submit" class="btn btn-accent w" '.la('visita.boton','Agendar visita').'>'.lt('visita.boton','Agendar visita').'</button>';
echo '<small data-es="Te confirmaremos la visita por teléfono o correo." data-en="We will confirm your visit by phone or email.">Te confirmaremos la visita por teléfono o correo.</small>';
echo '</form></div></div>';

/* ---------- 12. PREGUNTAS FRECUENTES ---------- */
$qs=llist('faq.q',10);
if($qs){
  echo '<section class="section bg-soft" id="faq"><div class="container faq2"><div class="sec-head reveal">';
  echo '<h2 '.la('faq.title','Preguntas frecuentes').'>'.lt('faq.title','Preguntas frecuentes').'</h2></div><div class="faq reveal">';
  foreach($qs as $k){ $n=substr($k,strlen('faq.q'));
    echo '<details><summary '.la($k).'>'.lt($k).'</summary><p '.la('faq.a'.$n).'>'.lt('faq.a'.$n).'</p></details>'; }
  echo '</div></div></section>';
}

/* ---------- 13. OTRAS SEDES ---------- */
echo '<section class="section" id="otras-sedes"><div class="container"><div class="sec-row reveal"><div class="sec-head">';
echo '<h2 data-es="Otras sedes de Aldea" data-en="Other Aldea locations">Otras sedes de Aldea</h2></div>';
echo '<a class="sec-link" href="/ubicaciones/"><span data-es="Ver ubicaciones" data-en="See locations">Ver ubicaciones</span>'.aldea_icon('arrow-right').'</a></div>';
loc_cards($loc['slug']);
echo '</div></section>';

// Movil: barra fija con las dos acciones del inicio (visita y cotizacion)
barra_movil('<button type="button" class="btn btn-accent" data-visita '.la('hero.cta1','Agenda tu visita').'>'.lt('hero.cta1','Agenda tu visita').'</button>',
            '<a href="#formulario" class="btn btn-ghost" '.la('hero.cta2','Cotizar').'>'.lt('hero.cta2','Cotizar').'</a>');
echo '</main>';
site_footer();
site_scripts();
