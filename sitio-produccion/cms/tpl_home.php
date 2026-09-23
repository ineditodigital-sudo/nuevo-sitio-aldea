<?php
// Home dinamico — lee bloques editables de la tabla blocks (pagina slug='')
// Rediseno 2026-09: hero sin filtro azul, textos a la izquierda, mas fotos y sin etiquetas decorativas.
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
function hhas($k){ return trim(strip_tags((string)hes($k,'')))!==''; }

$p=cms_pdo()->query("SELECT * FROM pages WHERE slug=''")->fetch();
$mt=$p&&$p['seo_title_es']?$p['seo_title_es']:'ALDEA | Oficinas en Renta y Coworking';
$md=$p&&$p['seo_desc_es']?$p['seo_desc_es']:'Oficinas en renta y coworking todo incluido con atencion personalizada en el Bajio. Trabaja a tu manera.';
$mten=($p&&$p['seo_title_en'])?$p['seo_title_en']:'ALDEA | Offices for Rent and Coworking';
$mden=($p&&$p['seo_desc_en'])?$p['seo_desc_en']:'All-inclusive offices for rent and coworking with personal service in the Bajio. Work your way.';
$GLOBALS['BODY_CLASS']='has-nhero'; // header claro sobre el hero oscuro
site_head($mt,$md,'/',$p?(bool)$p['noindex']:false,$mten,$mden);
site_header();
jsonld_organizacion();   // ficha de empresa + sus cuatro sedes
echo block_styles($__pid);
$__arrow=aldea_icon('arrow-right');
?>
<main>

<!-- 1. HERO — foto a sangre (carrusel opcional), sin filtro de color. El texto y los CTAs no cambian. -->
<section class="nhero" id="hero">
  <div class="nhero-media" data-hero>
<?php
$__slides=[];
foreach(['photo_a','photo_b','photo_c','photo_d'] as $__k){ $__u=himg('hero.'.$__k,''); if($__u!=='')$__slides[]=$__u; }
if(!$__slides)$__slides=['/img/home-hero.webp'];
foreach($__slides as $__i=>$__u) echo pic($__u,$__i===0?'Espacios de trabajo Aldea':'','100vw','class="nhero-img'.($__i===0?' on':'').'"'.($__i===0?' fetchpriority="high"':' loading="lazy"'));
?>
    <span class="nhero-scrim"></span>
  </div>
  <div class="container nhero-in">
    <div class="nhero-copy">
      <h1><span <?=ha('hero.title')?>><?=ht('hero.title')?></span> <span class="xhi"><span <?=ha('hero.title2')?>><?=ht('hero.title2')?></span></span></h1>
      <p class="lead" <?=ha('hero.lead')?>><?=ht('hero.lead')?></p>
      <div class="hero-cta">
        <a href="<?=esc(href_('hero.cta1','#ubicaciones'))?>" class="btn btn-accent" <?=ha('hero.cta1','Ver ubicaciones')?>><?=ht('hero.cta1','Ver ubicaciones')?></a>
        <a href="<?=esc(href_('hero.cta2','#soluciones'))?>" class="btn btn-clear" <?=ha('hero.cta2','Conoce nuestros espacios')?>><?=ht('hero.cta2','Conoce nuestros espacios')?></a>
      </div>
    </div>
  </div>
</section>

<!-- 2. CLIENTES -->
<?php render_clients(hes('clients.title','Empresas que confían en Aldea'),hen('clients.title','Companies that trust Aldea'),12); ?>

<!-- 3. ESPACIOS DE TRABAJO -->
<section class="section" id="soluciones"><div class="container">
<div class="sec-row reveal"><div class="sec-head"><h2 <?=ha('soluciones.title','Encuentra el espacio que necesitas')?>><?=ht('soluciones.title','Encuentra el espacio que necesitas')?></h2><?php if(hhas('soluciones.lead')): ?><p class="lead" <?=ha('soluciones.lead')?>><?=ht('soluciones.lead')?></p><?php endif; ?></div>
<a class="sec-link" href="/lo-que-ofrecemos/"><span data-es="Ver todos los espacios" data-en="See all workspaces">Ver todos los espacios</span><?=$__arrow?></a></div>
<?php
$__sol=cms_pdo()->query("SELECT * FROM solutions WHERE published=1 AND in_menu=1 ORDER BY sort,id LIMIT 4")->fetchAll();
echo '<div class="sgrid" style="--n:'.max(1,count($__sol)).'">';
foreach($__sol as $s){
  echo '<a class="scard reveal" href="/'.esc($s['slug']).'/"><div class="scard-img">'.pic($s['hero_image'],($s['hero_image_alt']??'')?:$s['title_es'],'(max-width:560px) 100vw, (max-width:1080px) 50vw, 25vw','loading="lazy"').'</div>'
      .'<div class="scard-b"><h3 data-es="'.esc($s['title_es']).'" data-en="'.esc($s['title_en']?:$s['title_es']).'">'.esc($s['title_es']).'</h3>'
      .'<p data-es="'.esc($s['excerpt_es']).'" data-en="'.esc($s['excerpt_en']?:$s['excerpt_es']).'">'.esc($s['excerpt_es']).'</p>'
      .'<span class="lcard-go"><span data-es="Conoce más" data-en="Learn more">Conoce más</span>'.$__arrow.'</span></div></a>';
}
echo '</div>';
?>
</div></section>

<!-- 4. SERVICIOS INCLUIDOS: foto grande y lista de iconos -->
<section class="section bg-soft" id="amenidades"><div class="container duo rev reveal">
<figure class="duo-media tall"><?=pic(himg('amenidades.img','/img/sedes/leon/lounge.webp'),'Áreas comunes de Aldea','(max-width:900px) 100vw, 58vw','loading="lazy"')?></figure>
<div class="duo-copy">
<h2 <?=ha('amenidades.title','Tú te ocupas de tu empresa. Nosotros de tu oficina.')?>><?=ht('amenidades.title','Tú te ocupas de tu empresa. Nosotros de tu oficina.')?></h2>
<?php if(hhas('amenidades.lead')): ?><p class="lead" <?=ha('amenidades.lead')?>><?=ht('amenidades.lead')?></p><?php endif; ?>
<?php
$__am=[]; foreach(amen_defaults() as $__i=>$__a){ $__k=$__i+1; $__am[]=[hes("amenidades.amen{$__k}_icon",$__a[0]),hes("amenidades.amen{$__k}_text",$__a[1]),hen("amenidades.amen{$__k}_text",$__a[2]),$__k]; }
echo '<ul class="ilist" style="--cd:2;--ct:2;--cm:2">';
foreach($__am as $__a) echo '<li><span class="ico">'.render_icon($__a[0]).'</span><span data-es="'.esc($__a[1]).'" data-en="'.esc($__a[2]).'" data-blk="amenidades.amen'.$__a[3].'_text">'.esc($__a[1]).'</span></li>';
echo '</ul>';
?>
</div></div></section>

<!-- 5. UBICACIONES -->
<section class="section" id="ubicaciones"><div class="container">
<div class="sec-row reveal"><div class="sec-head"><h2 <?=ha('ubicaciones.title','Encuentra tu Aldea')?>><?=ht('ubicaciones.title','Encuentra tu Aldea')?></h2><?php if(hhas('ubicaciones.lead')): ?><p class="lead" <?=ha('ubicaciones.lead')?>><?=ht('ubicaciones.lead')?></p><?php endif; ?></div>
<a class="sec-link" href="/ubicaciones/"><span data-es="Ver ubicaciones" data-en="See locations">Ver ubicaciones</span><?=$__arrow?></a></div>
<?php loc_cards('','home'); ?>
</div></section>

<!-- 6. OFICINAS CORPORATIVAS: banda de foto a sangre -->
<section class="band" id="corporativas">
<?=pic(himg('corporativas.img','/img/corporativas/proyecto/planta-abierta.webp'),'Oficina corporativa desarrollada por Aldea','100vw','loading="lazy"')?>
<div class="container"><div class="band-copy reveal">
<h2 <?=ha('corporativas.title','Oficinas Corporativas a la Medida')?>><?=ht('corporativas.title','Oficinas Corporativas a la Medida')?></h2>
<p <?=ha('corporativas.text1','Diseñamos, adecuamos, equipamos y operamos espacios de trabajo exclusivos para grandes equipos.')?>><?=ht('corporativas.text1','Diseñamos, adecuamos, equipamos y operamos espacios de trabajo exclusivos para grandes equipos.')?></p>
<div class="hero-cta"><a href="<?=esc(href_('corporativas.cta',corp_url()))?>" class="btn btn-accent" <?=ha('corporativas.cta','Conoce más')?>><?=ht('corporativas.cta','Conoce más')?></a></div>
</div></div></section>

<!-- 7. TESTIMONIOS -->
<?php
$__t=cms_pdo()->query("SELECT t.*, c.logo AS clogo FROM testimonials t LEFT JOIN clients c ON c.id=t.client_id WHERE t.published=1 ORDER BY t.sort,t.id LIMIT 3")->fetchAll();
if($__t){
  echo '<section class="section bg-soft" id="testimonios"><div class="container"><div class="sec-head reveal"><h2 '.ha('testimonios.title','Lo que dicen nuestros clientes').'>'.ht('testimonios.title','Lo que dicen nuestros clientes').'</h2></div>';
  echo '<div class="tgrid reveal" style="--n:'.count($__t).'">';
  foreach($__t as $t){ $av=$t['avatar']?:''; $co=($t['company_logo']??'')?:($t['clogo']?:'');
    echo '<figure class="tq"><blockquote data-es="'.esc($t['quote_es']).'" data-en="'.esc($t['quote_en']?:$t['quote_es']).'">'.esc($t['quote_es']).'</blockquote><figcaption>'
        .($av?'<img src="'.esc($av).'" alt="" loading="lazy">':'').'<span><b>'.esc($t['name']).'</b><small>'.esc($t['company']).'</small></span>'
        .($co?'<img class="tco" src="'.esc($co).'" alt="'.esc($t['company']).'" loading="lazy">':'').'</figcaption></figure>'; }
  echo '</div></div></section>';
}
?>

<!-- 8. ALDEA EN NUMEROS -->
<section class="section" id="numeros"><div class="container">
<div class="sec-row reveal"><div class="sec-head"><h2 <?=ha('numeros.title','Aldea en números')?>><?=ht('numeros.title','Aldea en números')?></h2></div>
<?php if(($__nc=ht('numeros.cta','Conoce Aldea'))!==''): ?><a class="sec-link" href="<?=esc(href_('numeros.cta','/acerca-de-aldea/'))?>"><span <?=ha('numeros.cta','Conoce Aldea')?>><?=esc(trim(str_replace('→','',$__nc)))?></span><?=$__arrow?></a><?php endif; ?></div>
<div class="nums2 reveal" style="--n:5">
<?php
$__nums=[['n1','4','Ciudades','Cities'],['n2','2017','Desde','Since'],['n3','+X','Empresas','Companies'],['n4','+X','Miembros','Members'],['n5','+X','m² de espacio','sq m of space']];
foreach($__nums as $__n){
  echo '<div><b '.ha('numeros.'.$__n[0].'_value',$__n[1]).'>'.ht('numeros.'.$__n[0].'_value',$__n[1]).'</b>'
      .'<span '.ha('numeros.'.$__n[0].'_label',$__n[2]).'>'.ht('numeros.'.$__n[0].'_label',$__n[2]).'</span></div>';
}
?>
</div>
</div></section>

<!-- 9. FORMULARIO -->
<section class="section bg-soft contact" id="contacto"><div class="container"><div class="formx reveal">
<figure class="formx-media"><?=pic(himg('contacto.img','/img/sedes/ags/recepcion.webp'),'Recepción de Aldea','(max-width:900px) 100vw, 45vw','loading="lazy"')?></figure>
<div class="formx-body">
<h2 <?=ha('contacto.title','Hablemos sobre tu próximo espacio de trabajo')?>><?=ht('contacto.title','Hablemos sobre tu próximo espacio de trabajo')?></h2>
<p class="lead" <?=ha('contacto.lead','Déjanos tus datos y nuestro equipo comercial se pondrá en contacto contigo para conocer lo que necesitas.')?>><?=ht('contacto.lead','Déjanos tus datos y nuestro equipo comercial se pondrá en contacto contigo para conocer lo que necesitas.')?></p>
<form class="contact-form" onsubmit="return aldeaSubmit(event)" data-source="home" data-utm>
<div class="cf-2"><input name="name" type="text" required placeholder="Nombre" data-ph-es="Nombre" data-ph-en="Name" autocomplete="name">
<input name="company" type="text" placeholder="Empresa" data-ph-es="Empresa" data-ph-en="Company" autocomplete="organization"></div>
<div class="cf-2"><input name="phone" type="tel" placeholder="Teléfono / WhatsApp" data-ph-es="Teléfono / WhatsApp" data-ph-en="Phone / WhatsApp" autocomplete="tel">
<input name="email" type="email" required placeholder="Correo" data-ph-es="Correo" data-ph-en="Email" autocomplete="email"></div>
<div class="cf-2"><select name="city" required>
  <option value="" disabled selected data-es="Ciudad de interés" data-en="City of interest">Ciudad de interés</option>
  <option value="Querétaro">Querétaro</option>
  <option value="León">León</option>
  <option value="San Luis Potosí">San Luis Potosí</option>
  <option value="Aguascalientes">Aguascalientes</option>
  <option value="Proyecto Corporativo" data-es="Proyecto Corporativo" data-en="Corporate project">Proyecto Corporativo</option>
</select>
<select name="team_size" required>
  <option value="" disabled selected data-es="Número de personas" data-en="Number of people">Número de personas</option>
  <option value="1">1</option>
  <option value="2-5">2-5</option>
  <option value="6-10">6-10</option>
  <option value="11-20">11-20</option>
  <option value="21-50">21-50</option>
  <option value="51-100">51-100</option>
  <option value="+100">+100</option>
</select></div>
<button type="submit" class="btn btn-accent w" data-es="Enviar solicitud" data-en="Send request">Enviar solicitud</button>
<small id="formMsg" data-es="Al enviar aceptas nuestras políticas de privacidad." data-en="By submitting you accept our privacy policy.">Al enviar aceptas nuestras políticas de privacidad.</small></form>
<div class="formx-alt"><span data-es="¿Prefieres hablar con nosotros?" data-en="Would you rather talk to us?">¿Prefieres hablar con nosotros?</span><a href="<?=esc(href_('contacto.phone','tel:+524494540709'))?>" data-blk="contacto.phone"><?=ht('contacto.phone','+52 449 454 0709')?></a><a href="<?=esc(href_('contacto.email','mailto:contacto@aldea.work'))?>" data-blk="contacto.email"><?=ht('contacto.email','contacto@aldea.work')?></a></div>
</div></div></div></section>
</main>
<?php site_footer(); site_scripts();
