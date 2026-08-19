<?php
// Home dinamico — lee bloques editables de la tabla blocks (pagina slug='')
require_once __DIR__.'/site.php';
$__pid=cms_pdo()->query("SELECT id FROM pages WHERE slug=''")->fetchColumn();
$__HB=[];
if($__pid){ foreach(cms_pdo()->query("SELECT * FROM blocks WHERE page_id=".(int)$__pid) as $r){ $__HB[$r['section'].'.'.$r['skey']]=$r; } }
function hb($k){ global $__HB; return $__HB[$k]??null; }
function hes($k,$d=''){ $r=hb($k); return $r? $r['value_es'] : $d; }
function hen($k,$d=''){ $r=hb($k); return $r? ($r['value_en']!==''&&$r['value_en']!==null?$r['value_en']:$r['value_es']) : $d; }
function href_($k,$d=''){ $r=hb($k); return $r&&$r['href']!==''&&$r['href']!==null? $r['href'] : $d; }
function himg($k,$d=''){ $r=hb($k); return $r&&$r['value_es']? $r['value_es'] : $d; }
// atributos bilingues + texto por defecto ES
function ha($k,$d=''){ return 'data-es="'.esc(strip_tags(hes($k,$d))).'" data-en="'.esc(strip_tags(hen($k,$d))).'" data-blk="'.esc($k).'"'; }
function ht($k,$d=''){ return esc(strip_tags(hes($k,$d))); }

$p=cms_pdo()->query("SELECT * FROM pages WHERE slug=''")->fetch();
$mt=$p&&$p['seo_title_es']?$p['seo_title_es']:'ALDEA | Oficinas en Renta y Coworking';
$md=$p&&$p['seo_desc_es']?$p['seo_desc_es']:'Oficinas en renta y coworking todo incluido con atencion personalizada en el Bajio. Trabaja a tu manera.';
$mten=($p&&$p['seo_title_en'])?$p['seo_title_en']:'ALDEA | Offices for Rent and Coworking';
$mden=($p&&$p['seo_desc_en'])?$p['seo_desc_en']:'All-inclusive offices for rent and coworking with personal service in the Bajio. Work your way.';
site_head($mt,$md,'/',$p?(bool)$p['noindex']:false,$mten,$mden);
site_header();
echo block_styles($__pid);
?>
<main>
<section class="xhero" id="hero"><div class="container xhero-grid">
<div class="xhero-copy reveal">
<h1><span <?=ha('hero.title')?>><?=ht('hero.title')?></span><br><span class="xhi"><span <?=ha('hero.title2')?>><?=ht('hero.title2')?></span></span></h1>
<p class="lead" <?=ha('hero.lead')?>><?=ht('hero.lead')?></p>
<div class="hero-cta"><a href="<?=esc(href_('hero.cta1','/contacto/'))?>" class="btn btn-primary" <?=ha('hero.cta1')?>><?=ht('hero.cta1')?></a><a href="<?=esc(href_('hero.cta2','/ubicaciones/'))?>" class="btn btn-ghost" <?=ha('hero.cta2')?>><?=ht('hero.cta2')?></a></div></div>
<div class="xhero-art reveal"><div class="xstage" id="xstage">
<svg class="xdash" viewBox="0 0 500 520" fill="none" preserveAspectRatio="none"><path d="M120 120 C 40 210, 70 390, 210 440" stroke="currentColor" stroke-width="2" stroke-dasharray="2 8" stroke-linecap="round"/><path d="M300 80 C 470 120, 470 320, 360 470" stroke="currentColor" stroke-width="2" stroke-dasharray="2 8" stroke-linecap="round"/></svg>
<div class="xphoto xphoto-a xfloat" data-z="20" data-depth="14" data-amp="10" data-sp="0.9"><img class="on" src="<?=esc(himg('hero.photo_a','/img/loc-leon.webp'))?>" alt="Oficina Aldea"/><img src="/img/sol-coworking.webp" alt=""/><img src="/img/sala.webp" alt=""/></div>
<div class="xphoto xphoto-b xfloat" data-z="6" data-depth="9" data-amp="8" data-sp="0.7"><img class="on" src="<?=esc(himg('hero.photo_b','/img/espacio.webp'))?>" alt="Espacio de trabajo Aldea"/><img src="/img/sol-privada.webp" alt=""/><img src="/img/loc-slp.webp" alt=""/></div>
<div class="xcard xcard-1 xfloat" data-z="64" data-depth="34" data-amp="9" data-sp="1.1" data-rot="-2"><span class="xcard-ic"><?=render_icon(hes('hero.floatcard_icon','pin'))?></span><div><b <?=ha('hero.floatcard_title','Presencia en el Bajío')?>><?=ht('hero.floatcard_title','Presencia en el Bajío')?></b><small <?=ha('hero.floatcard_sub','León · SLP · Ags · Querétaro')?>><?=ht('hero.floatcard_sub','León · SLP · Ags · Querétaro')?></small></div></div>
<div class="xchip xchip-1 xfloat" data-z="76" data-depth="42" data-amp="11" data-sp="1.3"><i><?=render_icon(hes('hero.floatchip_icon','sparkle'))?></i> <span <?=ha('hero.floatchip_text','Todo incluido, sin letras pequeñas')?>><?=ht('hero.floatchip_text','Todo incluido, sin letras pequeñas')?></span></div>
<div class="xlog xfloat" data-z="52" data-depth="28" data-amp="8" data-sp="1.0" data-rot="2"><div class="xlog-top"><b <?=ha('hero.floatlog_title','Espacios que crecen contigo')?>><?=ht('hero.floatlog_title','Espacios que crecen contigo')?></b></div><div class="xlog-bar"><span <?=ha('hero.floatlog_sub','Oficinas · Coworking · Domicilio virtual')?>><?=ht('hero.floatlog_sub','Oficinas · Coworking · Domicilio virtual')?></span></div></div>
</div></div></div>
</section>
<section class="section" id="nosotros"><div class="container"><div class="sec-head reveal"><span class="chip" <?=ha('nosotros.chip')?>><?=ht('nosotros.chip')?></span>
<h2 <?=ha('nosotros.title')?>><?=ht('nosotros.title')?></h2>
<p class="lead" <?=ha('nosotros.lead')?>><?=ht('nosotros.lead')?></p></div>
<div class="bento">
<figure class="b-img b-lg reveal"><img src="<?=esc(himg('nosotros.img_main','/img/about.webp'))?>" alt=""/><figcaption <?=ha('nosotros.img_main_cap','Una comunidad que trabaja unida')?>><?=ht('nosotros.img_main_cap','Una comunidad que trabaja unida')?></figcaption></figure>
<article class="b-card b-dark reveal" style="<?=($__c1=hes('nosotros.card1_bg'))?'background:'.esc($__c1):''?>"><div class="b-ico"><?=render_icon(hes('nosotros.card1_icon','building'))?></div><h3 <?=ha('nosotros.card1_title','Instalaciones propias')?>><?=ht('nosotros.card1_title','Instalaciones propias')?></h3><p <?=ha('nosotros.card1_text','Espacios modernos con salas de juntas, zonas comunes y servicios incluidos.')?>><?=ht('nosotros.card1_text','Espacios modernos con salas de juntas, zonas comunes y servicios incluidos.')?></p></article>
<article class="b-card b-blue reveal" style="<?=($__c2=hes('nosotros.card2_bg'))?'background:'.esc($__c2):''?>"><div class="b-ico"><?=render_icon(hes('nosotros.card2_icon','user'))?></div><h3 <?=ha('nosotros.card2_title','Atencion personalizada')?>><?=ht('nosotros.card2_title','Atencion personalizada')?></h3><p <?=ha('nosotros.card2_text','Recepcion de visitas, paqueteria y soporte cercano cada dia.')?>><?=ht('nosotros.card2_text','Recepcion de visitas, paqueteria y soporte cercano cada dia.')?></p></article>
<figure class="b-img reveal"><img src="<?=esc(himg('nosotros.img_2','/img/sala.webp'))?>" alt=""/></figure>
<figure class="b-img reveal"><img src="<?=esc(himg('nosotros.img_3','/img/espacio.webp'))?>" alt=""/></figure></div></div></section>
<section class="section bg-soft" id="soluciones"><div class="container"><div class="sec-head center reveal"><span class="chip">Soluciones</span><h2 <?=ha('soluciones.title')?>><?=ht('soluciones.title')?></h2><p class="lead" <?=ha('soluciones.lead')?>><?=ht('soluciones.lead')?></p></div><div class="sol-grid">
<?php
$__sol=cms_pdo()->query("SELECT * FROM solutions WHERE published=1 AND in_menu=1 ORDER BY sort,id LIMIT 4")->fetchAll();
foreach($__sol as $s){ echo '<a class="solc reveal" href="/'.esc($s['slug']).'/"><div class="solc-img"><img src="'.esc($s['hero_image']).'" alt="'.esc(($s['hero_image_alt']??'')?:$s['title_es']).'"/></div><div class="solc-b"><h3 data-es="'.esc($s['title_es']).'" data-en="'.esc($s['title_en']?:$s['title_es']).'">'.esc($s['title_es']).'</h3><p data-es="'.esc($s['excerpt_es']).'" data-en="'.esc($s['excerpt_en']?:$s['excerpt_es']).'">'.esc($s['excerpt_es']).'</p><span class="arrow" data-es="Conoce mas &rarr;" data-en="Learn more &rarr;">Conoce mas &rarr;</span></div></a>'; }
?>
</div><div class="sec-foot reveal" style="text-align:center;margin-top:2.5rem"><a href="/lo-que-ofrecemos/" class="btn btn-ghost" data-es="Ver todas las soluciones" data-en="See all solutions">Ver todas las soluciones</a></div></div></section>
<section class="section" id="amenidades"><div class="container">
<div class="sec-head center reveal"><span class="chip" data-es="Todo incluido" data-en="All included">Todo incluido</span>
<h2 <?=ha('amenidades.title')?>><?=ht('amenidades.title')?></h2>
<p class="lead" <?=ha('amenidades.lead')?>><?=ht('amenidades.lead')?></p></div>
<?php render_amenities($__pid); ?></div></section>
<section class="section bg-navy" id="precios"><div class="container"><div class="sec-head center on-dark reveal"><span class="chip chip-light">Precios</span><h2 <?=ha('precios.title')?>><?=ht('precios.title')?></h2><p class="lead" <?=ha('precios.lead')?>><?=ht('precios.lead')?></p></div>
<?php
$__lp=cms_pdo()->query("SELECT * FROM locations WHERE published=1 ORDER BY sort,id")->fetchAll();
$__def=$__lp?$__lp[0]:['price_virtual'=>'2,400','price_cowork'=>'2,700','price_privada'=>'7,400'];
echo '<div class="city-tabs reveal" id="cityTabs">';
foreach($__lp as $i=>$l){ $c=strtolower(preg_replace('/[^a-z]/i','',substr($l['city_es'],0,3))); echo '<button data-city="'.esc($c).'" data-v="'.esc($l['price_virtual']).'" data-w="'.esc($l['price_cowork']).'" data-p="'.esc($l['price_privada']).'" data-soon="'.($l['soon']?'1':'0').'"'.($i===0?' class="on"':'').'>'.esc($l['city_es']).'</button>'; }
echo '</div>';
echo '<p class="soon-note" id="soonNote"'.($__def&&!empty($__def['soon'])?'':' hidden').' data-es="Apertura proxima. Aparta tu espacio!" data-en="Opening soon. Reserve your space!">Apertura proxima. Aparta tu espacio!</p>';
?>
<div class="plans reveal">
<article class="plan"><h3 <?=ha('precios.plan1_title','Domicilio Virtual')?>><?=ht('precios.plan1_title','Domicilio Virtual')?></h3><p class="plan-d" <?=ha('precios.plan1_desc','Presencia profesional sin oficina fisica.')?>><?=ht('precios.plan1_desc','Presencia profesional sin oficina fisica.')?></p><p class="plan-price"><span data-es="Desde" data-en="From">Desde</span> <b>$<span id="p-virtual"><?=esc($__def['price_virtual'])?></span></b> <small>+ IVA / <span data-es="mes" data-en="mo">mes</span></small></p><ul><li <?=ha('precios.plan1_f1','Domicilio fiscal y comercial')?>><?=ht('precios.plan1_f1','Domicilio fiscal y comercial')?></li><li <?=ha('precios.plan1_f2','Recepcion de paqueteria')?>><?=ht('precios.plan1_f2','Recepcion de paqueteria')?></li><li <?=ha('precios.plan1_f3','Uso de salas por hora')?>><?=ht('precios.plan1_f3','Uso de salas por hora')?></li></ul><a href="<?=esc(href_('precios.plan1_btn','/domicilio-virtual/'))?>" class="btn btn-ghost w" <?=ha('precios.plan1_btn','Ver mas')?>><?=ht('precios.plan1_btn','Ver mas')?></a></article>
<article class="plan plan-pop"><span class="pop" data-es="Mas popular" data-en="Most popular">Mas popular</span><h3 <?=ha('precios.plan2_title','Coworking')?>><?=ht('precios.plan2_title','Coworking')?></h3><p class="plan-d" <?=ha('precios.plan2_desc','Espacio flexible con todo lo esencial.')?>><?=ht('precios.plan2_desc','Espacio flexible con todo lo esencial.')?></p><p class="plan-price"><span data-es="Desde" data-en="From">Desde</span> <b>$<span id="p-cowork"><?=esc($__def['price_cowork'])?></span></b> <small>+ IVA / <span data-es="mes" data-en="mo">mes</span></small></p><ul><li <?=ha('precios.plan2_f1','Acceso a espacios compartidos')?>><?=ht('precios.plan2_f1','Acceso a espacios compartidos')?></li><li <?=ha('precios.plan2_f2','Internet de alta velocidad')?>><?=ht('precios.plan2_f2','Internet de alta velocidad')?></li><li <?=ha('precios.plan2_f3','Cafe y amenidades incluidas')?>><?=ht('precios.plan2_f3','Cafe y amenidades incluidas')?></li></ul><a href="<?=esc(href_('precios.plan2_btn','/coworking/'))?>" class="btn btn-accent w" <?=ha('precios.plan2_btn','Ver mas')?>><?=ht('precios.plan2_btn','Ver mas')?></a></article>
<article class="plan"><h3 <?=ha('precios.plan3_title','Oficina Privada')?>><?=ht('precios.plan3_title','Oficina Privada')?></h3><p class="plan-d" <?=ha('precios.plan3_desc','Tu propio espacio, totalmente equipado.')?>><?=ht('precios.plan3_desc','Tu propio espacio, totalmente equipado.')?></p><p class="plan-price"><span data-es="Desde" data-en="From">Desde</span> <b>$<span id="p-privada"><?=esc($__def['price_privada'])?></span></b> <small>+ IVA / <span data-es="mes" data-en="mo">mes</span></small></p><ul><li <?=ha('precios.plan3_f1','Oficina equipada y privada')?>><?=ht('precios.plan3_f1','Oficina equipada y privada')?></li><li <?=ha('precios.plan3_f2','Capacidad de 1 a 100+')?>><?=ht('precios.plan3_f2','Capacidad de 1 a 100+')?></li><li <?=ha('precios.plan3_f3','Todos los servicios incluidos')?>><?=ht('precios.plan3_f3','Todos los servicios incluidos')?></li></ul><a href="<?=esc(href_('precios.plan3_btn','/oficina-privada/'))?>" class="btn btn-ghost w" <?=ha('precios.plan3_btn','Ver mas')?>><?=ht('precios.plan3_btn','Ver mas')?></a></article></div></div></section>
<section class="section" id="ubicaciones"><div class="container"><div class="sec-head reveal"><span class="chip">Ubicaciones</span><h2 <?=ha('ubicaciones.title')?>><?=ht('ubicaciones.title')?></h2><p class="lead" <?=ha('ubicaciones.lead')?>><?=ht('ubicaciones.lead')?></p></div><?php loc_cards(); ?></div></section>
<?php render_clients(); ?>
<section class="section testi" id="testimonios"><div class="container"><div class="sec-head center on-dark reveal"><span class="chip chip-light">Testimonios</span><h2 <?=ha('testimonios.title')?>><?=ht('testimonios.title')?></h2></div><div class="car testi-car" data-car><button class="car-arw car-prev" data-prev aria-label="Anterior"><svg viewBox="0 0 24 24"><path d="M15 18l-6-6 6-6"/></svg></button><div class="car-track testi-track" data-track>
<?php
$__t=cms_pdo()->query("SELECT t.*, c.logo AS clogo FROM testimonials t LEFT JOIN clients c ON c.id=t.client_id WHERE t.published=1 ORDER BY t.sort,t.id")->fetchAll();
foreach($__t as $t){ $av=$t['avatar']?:''; $co=($t['company_logo']??'')?:($t['clogo']?:''); echo '<figure class="tcard reveal"><div class="q">&ldquo;</div><blockquote>'.esc($t['quote_es']).'</blockquote><figcaption>'.($av?'<img src="'.esc($av).'" alt=""/>':'').'<span><b>'.esc($t['name']).'</b><small>'.esc($t['company']).'</small></span>'.($co?'<img class="tco" src="'.esc($co).'" alt="'.esc($t['company']).'"/>':'').'</figcaption></figure>'; }
?>
</div><button class="car-arw car-next" data-next aria-label="Siguiente"><svg viewBox="0 0 24 24"><path d="M9 6l6 6-6 6"/></svg></button></div></div></section>
<section class="section contact" id="contacto"><div class="container contact-in"><div class="contact-copy reveal"><span class="chip">Contacto</span><h2 <?=ha('contacto.title')?>><?=ht('contacto.title')?></h2><p class="lead" <?=ha('contacto.lead')?>><?=ht('contacto.lead')?></p><p class="contact-phone"><span data-es="O marcanos al" data-en="Or call us at">O marcanos al</span> <a href="<?=esc(href_('contacto.phone','tel:+524494540709'))?>" data-blk="contacto.phone"><?=ht('contacto.phone')?></a></p><p class="contact-phone"><span data-es="O escribenos a" data-en="Or email us at">O escribenos a</span> <a href="<?=esc(href_('contacto.email','mailto:contacto@aldea.work'))?>" data-blk="contacto.email"><?=ht('contacto.email')?></a></p></div><form class="contact-form reveal" onsubmit="return aldeaSubmit(event)" data-source="home">
<input name="name" type="text" required placeholder="Nombre" data-ph-es="Nombre" data-ph-en="Name"/>
<input name="email" type="email" required placeholder="Correo electronico" data-ph-es="Correo electronico" data-ph-en="Email"/>
<input name="phone" type="tel" placeholder="Telefono" data-ph-es="Telefono" data-ph-en="Phone"/>
<textarea name="message" rows="4" placeholder="Que estas buscando?" data-ph-es="Que estas buscando?" data-ph-en="What are you looking for?"></textarea>
<button type="submit" class="btn btn-accent w" data-es="Enviar" data-en="Send">Enviar</button>
<small id="formMsg" data-es="Al enviar aceptas nuestras politicas de privacidad." data-en="By submitting you accept our privacy policy.">Al enviar aceptas nuestras politicas de privacidad.</small></form></div></section>
</main>
<?php site_footer(); site_scripts();
