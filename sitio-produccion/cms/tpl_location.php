<?php /* $loc en scope */
// Si la sede tiene contenido ampliado (pagina oculta "loc:<slug>" con bloques),
// se usa la plantilla por secciones del brief. Si no, sigue el diseno generico.
$__lp=cms_pdo()->prepare("SELECT id FROM pages WHERE slug=?"); $__lp->execute(['loc:'.$loc['slug']]);
$__lpid=$__lp->fetchColumn();
if($__lpid){
  $LB=[];
  foreach(cms_pdo()->query("SELECT * FROM blocks WHERE page_id=".(int)$__lpid) as $r) $LB[$r['section'].'.'.$r['skey']]=$r;
  if($LB){ include __DIR__.'/tpl_location_full.php'; return; }
}
$gal=json_decode($loc['gallery']?:'[]',true); if(!$gal)$gal=array_filter([$loc['hero_image']]);
$near=json_decode($loc['nearby']?:'{}',true); if(!is_array($near))$near=[];
$city=$loc['city_es']; $addr=$loc['address_es'];
$__cityen=$loc['city_en']?:$loc['city_es'];
$__ten=$loc['seo_title_en']?:('Offices for rent '.$__cityen.' - Aldea Networking');
$__inten=$loc['intro_en']?:$loc['intro_es']; $__adren=$loc['address_en']?:$loc['address_es']; $__h1en=$loc['title_en']?:('Offices for rent '.$__cityen);
site_head(($loc['seo_title_es']?:$loc['title_es'].' - Aldea Networking'),mb_strimwidth(strip_tags((string)$loc['intro_es']),0,150,'…'),'/'.$loc['slug'].'/',false,$__ten,($loc['seo_desc_en']?:''));
site_header();
$L='<svg viewBox="0 0 24 24"><path d="M15 18l-6-6 6-6"/></svg>'; $R='<svg viewBox="0 0 24 24"><path d="M9 6l6 6-6 6"/></svg>';
$soonflag = $loc['soon'] ? '<span class="subhero-flag" data-es="Próximamente - Apertura próxima" data-en="Coming soon">Próximamente - Apertura próxima</span>' : '';
// LOCHERO
echo '<section class="lochero"><div class="container lochero-in"><div class="lochero-info reveal">';
echo '<div class="crumb"><a href="/" data-es="Inicio" data-en="Home">Inicio</a> / <a href="/ubicaciones/" data-es="Ubicaciones" data-en="Locations">Ubicaciones</a> / <span data-es="'.esc($city).'" data-en="'.esc($__cityen).'">'.esc($city).'</span></div>';
echo '<span class="chip" data-es="'.esc($loc['name'].' - '.$loc['city_es']).'" data-en="'.esc($loc['name'].' - '.$__cityen).'">'.esc($loc['name']).' - '.esc($city).'</span><h1 data-es="'.esc($loc['title_es']?:$loc['name']).'" data-en="'.esc($__h1en).'">'.esc($loc['title_es']?:$loc['name']).'</h1>';
echo '<p class="lochero-addr" data-es="'.esc($addr).'" data-en="'.esc($__adren).'">'.esc($addr).'</p>'.$soonflag;
echo '<div class="hero-cta reveal" style="margin-top:1.4rem"><a href="/contacto/" class="btn btn-accent" data-es="Agenda tu visita" data-en="Book a visit">Agenda tu visita</a><a href="#precios" class="btn btn-ghost" data-es="Ver precios" data-en="See pricing">Ver precios</a></div></div>';
echo '<div class="lochero-gal reveal"><div class="lg-stage">';
foreach($gal as $k=>$u) echo '<img class="lg-img'.($k===0?' on':'').'" src="'.esc($u).'" '.($k===0?'loading="eager"':'loading="lazy"').'>';
echo '<button class="lg-nav lg-prev" aria-label="Anterior">'.$L.'</button><button class="lg-nav lg-next" aria-label="Siguiente">'.$R.'</button><span class="lg-count"><b>1</b>/'.count($gal).'</span></div>';
echo '<div class="lg-thumbs">'; foreach($gal as $k=>$u) echo '<button class="lg-thumb'.($k===0?' on':'').'" aria-label="Foto '.($k+1).'"><img src="'.esc($u).'"></button>'; echo '</div></div></div></section>';
// SPLIT "La sede"
echo '<section class="section"><div class="container split reveal"><div><span class="chip" data-es="La sede" data-en="The location">La sede</span><h2 style="margin-top:.8rem">'.esc($loc['name']).'</h2>';
echo '<p data-es="'.esc($loc['intro_es']).'" data-en="'.esc($__inten).'">'.esc($loc['intro_es']).'</p><p style="color:var(--muted)"><b data-es="Direccion:" data-en="Address:">Direccion:</b> '.esc($addr).'</p>';
echo '<a href="/contacto/" class="btn btn-primary" data-es="Quiero mas informacion" data-en="I want more info">Quiero mas informacion</a></div><img src="'.esc($loc['hero_image']).'" alt="'.esc($loc['name']).'"></div></section>';
// TECH (estatico, con ciudad)
render_tech($city);
// PRECIOS
$soonnote = $loc['soon'] ? '<p class="soon-note" data-es="Apertura proxima. Aparta tu espacio!" data-en="Opening soon. Reserve your space!">Apertura proxima. Aparta tu espacio!</p>' : '';
function plan_card($t_es,$t_en,$d_es,$d_en,$price,$feats,$pop=false){
  $cls=$pop?'plan plan-pop':'plan'; $tag=$pop?'<span class="pop" data-es="Mas popular" data-en="Most popular">Mas popular</span>':''; $btn=$pop?'btn-accent':'btn-ghost';
  $lis=''; foreach($feats as $f) $lis.='<li data-es="'.esc($f[0]).'" data-en="'.esc($f[1]).'">'.esc($f[0]).'</li>';
  return '<article class="'.$cls.'">'.$tag.'<h3 data-es="'.esc($t_es).'" data-en="'.esc($t_en).'">'.esc($t_es).'</h3><p class="plan-d" data-es="'.esc($d_es).'" data-en="'.esc($d_en).'">'.esc($d_es).'</p><p class="plan-price"><span data-es="Desde" data-en="From">Desde</span> <b>$'.esc($price).'</b> <small>+ IVA / <span data-es="mes" data-en="mo">mes</span></small></p><ul>'.$lis.'</ul><a href="/contacto/" class="btn '.$btn.' w" data-es="Solicitar" data-en="Request">Solicitar</a></article>';
}
$pv=plan_card('Domicilio Virtual','Virtual Address','Presencia profesional sin oficina fisica.','Professional presence without a physical office.',$loc['price_virtual'],[['Domicilio fiscal y comercial','Business & tax address'],['Recepcion de paqueteria','Parcel reception'],['Uso de salas por hora','Hourly meeting rooms']]);
$pc=plan_card('Coworking','Coworking','Espacio flexible con todo lo esencial.','Flexible space with all the essentials.',$loc['price_cowork'],[['Acceso a espacios compartidos','Access to shared spaces'],['Internet de alta velocidad','High-speed internet'],['Cafe y amenidades incluidas','Coffee & amenities included']],true);
$pp=plan_card('Oficina Privada','Private Office','Tu propio espacio, totalmente equipado.','Your own space, fully equipped.',$loc['price_privada'],[['Oficina equipada y privada','Private, equipped office'],['Capacidad de 1 a 100+','Capacity from 1 to 100+'],['Todos los servicios incluidos','All services included']]);
echo '<section class="section bg-navy" id="precios"><div class="container"><div class="sec-head center on-dark reveal"><span class="chip chip-light">Precios</span><h2 data-es="Precios claros, todo incluido" data-en="Clear pricing, all included">Precios claros, todo incluido</h2><p class="lead" data-es="El precio inicial de cada solucion en esta sede. Sin sorpresas." data-en="The starting price for each solution at this location.">El precio inicial de cada solucion en esta sede. Sin sorpresas.</p></div>'.$soonnote.'<div class="plans reveal">'.$pv.$pc.$pp.'</div></div></section>';
// AMENIDADES
render_amenities();
// MAPA + CERCANIAS
$q=rawurlencode($loc['map_query']?:($loc['name'].' '.$city));
echo '<section class="section bg-soft" id="ubicacion"><div class="container"><div class="sec-head reveal"><span class="chip" data-es="Ubicacion" data-en="Location">Ubicacion</span><h2 data-es="Como llegar y que hay cerca" data-en="How to get here and what is nearby">Como llegar y que hay cerca</h2></div><div class="locmap-grid reveal">';
echo '<div class="locmap-map"><iframe class="map-embed" loading="lazy" src="https://maps.google.com/maps?q='.$q.'&t=m&z=16&output=embed&iwloc=near"></iframe></div>';
echo '<div class="locmap-side"><div class="locmap-addr"><span class="locmap-pin"><svg viewBox="0 0 24 24"><path d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 0 1 16 0z"/><circle cx="12" cy="10" r="3"/></svg></span><div><b data-es="Aqui estamos" data-en="We are here">Aqui estamos</b><p data-es="'.esc($addr).'" data-en="'.esc($__adren).'">'.esc($addr).'</p></div></div><div class="near-grid">';
foreach($near as $cat=>$items){ echo '<div class="near"><h4>'.esc($cat).'</h4><ul>'; foreach($items as $it) echo '<li><span>'.esc($it[0]).'</span><b>'.esc($it[1]).'</b></li>'; echo '</ul></div>'; }
echo '</div></div></div></div></section>';
// OTRAS SEDES
echo '<section class="section"><div class="container"><div class="sec-head reveal"><span class="chip" data-es="Mas ubicaciones" data-en="More locations">Mas ubicaciones</span><h2 data-es="Otras sedes de Aldea" data-en="Other Aldea locations">Otras sedes de Aldea</h2></div>';
loc_cards($loc['slug']); echo '</div></section>';
render_clients();
// CONTACTO (estatico, con ciudad)
render_loc_contact($city,$loc['slug']);
site_footer(); site_scripts();
