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
$GLOBALS['BODY_CLASS']='has-nhero'; // header claro sobre el hero oscuro
site_head($mt,$md,'/',$p?(bool)$p['noindex']:false,$mten,$mden);
site_header();
jsonld_organizacion();   // ficha de empresa + sus cuatro sedes
echo block_styles($__pid);
?>
<main>

<!-- 1. HERO — imagen de gran formato (carrusel opcional). El texto y los CTAs no cambian. -->
<section class="nhero" id="hero">
  <div class="nhero-media" data-hero>
<?php
$__slides=[];
foreach(['photo_a','photo_b','photo_c','photo_d'] as $__k){ $__u=himg('hero.'.$__k,''); if($__u!=='')$__slides[]=$__u; }
if(!$__slides)$__slides=['/img/home-hero.webp'];
foreach($__slides as $__i=>$__u) echo '<img class="nhero-img'.($__i===0?' on':'').'" src="'.esc($__u).'" alt="'.($__i===0?'Espacios de trabajo Aldea':'').'"'.($__i===0?'':' loading="lazy"').'>';
?>
    <span class="nhero-scrim"></span>
  </div>
  <div class="container nhero-in">
    <div class="nhero-copy reveal">
      <h1><span <?=ha('hero.title')?>><?=ht('hero.title')?></span> <span class="xhi"><span <?=ha('hero.title2')?>><?=ht('hero.title2')?></span></span></h1>
      <p class="lead" <?=ha('hero.lead')?>><?=ht('hero.lead')?></p>
      <p class="nhero-sub" <?=ha('hero.lead2','Para equipos desde 1 hasta más de 100 personas en Querétaro, León, San Luis Potosí y Aguascalientes.')?>><?=ht('hero.lead2','Para equipos desde 1 hasta más de 100 personas en Querétaro, León, San Luis Potosí y Aguascalientes.')?></p>
      <div class="hero-cta">
        <a href="<?=esc(href_('hero.cta1','#ubicaciones'))?>" class="btn btn-primary" <?=ha('hero.cta1','Ver ubicaciones')?>><?=ht('hero.cta1','Ver ubicaciones')?></a>
        <a href="<?=esc(href_('hero.cta2','#soluciones'))?>" class="btn btn-clear" <?=ha('hero.cta2','Conoce nuestros espacios')?>><?=ht('hero.cta2','Conoce nuestros espacios')?></a>
      </div>
    </div>
  </div>
</section>

<!-- 2. CLIENTES -->
<?php render_clients(hes('clients.title','Empresas que confían en Aldea'),hen('clients.title','Companies that trust Aldea'),12); ?>

<!-- 3. ESPACIOS DE TRABAJO -->
<section class="section bg-soft" id="soluciones"><div class="container"><div class="sec-head center reveal"><h2 <?=ha('soluciones.title','Encuentra el espacio que necesitas')?>><?=ht('soluciones.title','Encuentra el espacio que necesitas')?></h2><p class="lead" <?=ha('soluciones.lead')?>><?=ht('soluciones.lead')?></p></div><div class="sol-grid">
<?php
$__sol=cms_pdo()->query("SELECT * FROM solutions WHERE published=1 AND in_menu=1 ORDER BY sort,id LIMIT 4")->fetchAll();
foreach($__sol as $s){ echo '<a class="solc reveal" href="/'.esc($s['slug']).'/"><div class="solc-img"><img src="'.esc($s['hero_image']).'" alt="'.esc(($s['hero_image_alt']??'')?:$s['title_es']).'"/></div><div class="solc-b"><h3 data-es="'.esc($s['title_es']).'" data-en="'.esc($s['title_en']?:$s['title_es']).'">'.esc($s['title_es']).'</h3><p data-es="'.esc($s['excerpt_es']).'" data-en="'.esc($s['excerpt_en']?:$s['excerpt_es']).'">'.esc($s['excerpt_es']).'</p><span class="arrow" data-es="Conoce más &rarr;" data-en="Learn more &rarr;">Conoce más &rarr;</span></div></a>'; }
?>
</div></div></section>

<!-- 4. SERVICIOS INCLUIDOS -->
<section class="section" id="amenidades"><div class="container">
<div class="sec-head center reveal">
<h2 <?=ha('amenidades.title','Tú te ocupas de tu empresa. Nosotros de tu oficina.')?>><?=ht('amenidades.title','Tú te ocupas de tu empresa. Nosotros de tu oficina.')?></h2>
<p class="lead" <?=ha('amenidades.lead')?>><?=ht('amenidades.lead')?></p></div>
<?php render_amenities($__pid); ?>
<p class="amen-note reveal" <?=ha('amenidades.nota','Los servicios incluidos pueden variar según la solución y ubicación contratada.')?>><?=ht('amenidades.nota','Los servicios incluidos pueden variar según la solución y ubicación contratada.')?></p>
</div></section>

<!-- 5. UBICACIONES -->
<section class="section bg-soft" id="ubicaciones"><div class="container"><div class="sec-head center reveal"><h2 <?=ha('ubicaciones.title','Encuentra tu Aldea')?>><?=ht('ubicaciones.title','Encuentra tu Aldea')?></h2><p class="lead" <?=ha('ubicaciones.lead')?>><?=ht('ubicaciones.lead')?></p></div><?php loc_cards('','home'); ?></div></section>

<!-- 6. OFICINAS CORPORATIVAS -->
<section class="section corp" id="corporativas"><div class="container"><div class="corp-in reveal">
<div class="corp-copy">
<span class="chip chip-light" <?=ha('corporativas.chip','PARA EQUIPOS DE +100 PERSONAS')?>><?=ht('corporativas.chip','PARA EQUIPOS DE +100 PERSONAS')?></span>
<h2 <?=ha('corporativas.title','Oficinas Corporativas a la Medida')?>><?=ht('corporativas.title','Oficinas Corporativas a la Medida')?></h2>
<p <?=ha('corporativas.text1','Diseñamos, adecuamos, equipamos y operamos espacios de trabajo exclusivos para grandes equipos.')?>><?=ht('corporativas.text1','Diseñamos, adecuamos, equipamos y operamos espacios de trabajo exclusivos para grandes equipos.')?></p>
<p <?=ha('corporativas.text2','Desarrollamos cada proyecto alrededor de las necesidades reales de tu empresa: distribución, infraestructura, mobiliario, tecnología, servicios y operación.')?>><?=ht('corporativas.text2','Desarrollamos cada proyecto alrededor de las necesidades reales de tu empresa: distribución, infraestructura, mobiliario, tecnología, servicios y operación.')?></p>
<a href="<?=esc(href_('corporativas.cta',corp_url()))?>" class="btn btn-accent" <?=ha('corporativas.cta','Conoce más →')?>><?=ht('corporativas.cta','Conoce más →')?></a>
</div>
<ol class="corp-steps">
<?php
$__cs=[['step1','Entendemos tu operación','We map your operation'],['step2','Diseñamos la solución','We design the solution'],['step3','Adecuamos y equipamos','We fit out and equip'],['step4','Operamos tu oficina','We run your office']];
foreach($__cs as $__i=>$__s) echo '<li><span class="corp-n">'.($__i+1).'</span><b '.ha('corporativas.'.$__s[0],$__s[1]).'>'.ht('corporativas.'.$__s[0],$__s[1]).'</b></li>';
?>
</ol>
</div></div></section>

<!-- 7. TESTIMONIOS -->
<section class="section testi" id="testimonios"><div class="container"><div class="sec-head center on-dark reveal"><span class="chip chip-light">Testimonios</span><h2 <?=ha('testimonios.title')?>><?=ht('testimonios.title')?></h2></div><div class="car testi-car" data-car><button class="car-arw car-prev" data-prev aria-label="Anterior"><svg viewBox="0 0 24 24"><path d="M15 18l-6-6 6-6"/></svg></button><div class="car-track testi-track" data-track>
<?php
$__t=cms_pdo()->query("SELECT t.*, c.logo AS clogo FROM testimonials t LEFT JOIN clients c ON c.id=t.client_id WHERE t.published=1 ORDER BY t.sort,t.id LIMIT 3")->fetchAll();
foreach($__t as $t){ $av=$t['avatar']?:''; $co=($t['company_logo']??'')?:($t['clogo']?:''); echo '<figure class="tcard reveal"><div class="q">&ldquo;</div><blockquote>'.esc($t['quote_es']).'</blockquote><figcaption>'.($av?'<img src="'.esc($av).'" alt=""/>':'').'<span><b>'.esc($t['name']).'</b><small>'.esc($t['company']).'</small></span>'.($co?'<img class="tco" src="'.esc($co).'" alt="'.esc($t['company']).'"/>':'').'</figcaption></figure>'; }
?>
</div><button class="car-arw car-next" data-next aria-label="Siguiente"><svg viewBox="0 0 24 24"><path d="M9 6l6 6-6 6"/></svg></button></div></div></section>

<!-- 8. ALDEA EN NUMEROS -->
<section class="section nums" id="numeros"><div class="container">
<div class="sec-head center reveal"><h2 <?=ha('numeros.title','Aldea en números')?>><?=ht('numeros.title','Aldea en números')?></h2></div>
<div class="num-grid reveal">
<?php
$__nums=[['n1','4','Ciudades','Cities'],['n2','2017','Desde','Since'],['n3','+X','Empresas','Companies'],['n4','+X','Miembros','Members'],['n5','+X','m² de espacio','sq m of space']];
foreach($__nums as $__n){
  echo '<div class="num"><b '.ha('numeros.'.$__n[0].'_value',$__n[1]).'>'.ht('numeros.'.$__n[0].'_value',$__n[1]).'</b>'
      .'<span '.ha('numeros.'.$__n[0].'_label',$__n[2]).'>'.ht('numeros.'.$__n[0].'_label',$__n[2]).'</span></div>';
}
?>
</div>
<?php if(($__nc=ht('numeros.cta','Conoce Aldea →'))!==''): ?>
<p class="num-cta reveal"><a href="<?=esc(href_('numeros.cta','/acerca-de-aldea/'))?>" class="arrow" <?=ha('numeros.cta','Conoce Aldea →')?>><?=$__nc?></a></p>
<?php endif; ?>
</div></section>

<!-- 9. FORMULARIO -->
<section class="section bg-soft contact" id="contacto"><div class="container contact-in"><div class="contact-copy reveal"><span class="chip">Contacto</span>
<h2 <?=ha('contacto.title','Hablemos sobre tu próximo espacio de trabajo')?>><?=ht('contacto.title','Hablemos sobre tu próximo espacio de trabajo')?></h2>
<p class="lead" <?=ha('contacto.lead','Déjanos tus datos y nuestro equipo comercial se pondrá en contacto contigo para conocer lo que necesitas.')?>><?=ht('contacto.lead','Déjanos tus datos y nuestro equipo comercial se pondrá en contacto contigo para conocer lo que necesitas.')?></p>
<p class="contact-ask" data-es="¿Prefieres hablar con nosotros?" data-en="Would you rather talk to us?">¿Prefieres hablar con nosotros?</p>
<p class="contact-phone"><a href="<?=esc(href_('contacto.phone','tel:+524494540709'))?>" class="contact-tel" data-blk="contacto.phone"><?=ht('contacto.phone','+52 449 454 0709')?></a></p>
<p class="contact-phone"><span data-es="O escríbenos a" data-en="Or email us at">O escríbenos a</span> <a href="<?=esc(href_('contacto.email','mailto:contacto@aldea.work'))?>" data-blk="contacto.email"><?=ht('contacto.email')?></a></p></div>
<form class="contact-form reveal" onsubmit="return aldeaSubmit(event)" data-source="home">
<input name="name" type="text" required placeholder="Nombre" data-ph-es="Nombre" data-ph-en="Name"/>
<input name="company" type="text" placeholder="Empresa" data-ph-es="Empresa" data-ph-en="Company"/>
<input name="phone" type="tel" placeholder="Teléfono / WhatsApp" data-ph-es="Teléfono / WhatsApp" data-ph-en="Phone / WhatsApp"/>
<input name="email" type="email" required placeholder="Correo" data-ph-es="Correo" data-ph-en="Email"/>
<select name="city" required>
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
  <option value="2-5">2–5</option>
  <option value="6-10">6–10</option>
  <option value="11-20">11–20</option>
  <option value="21-50">21–50</option>
  <option value="51-100">51–100</option>
  <option value="+100">+100</option>
</select>
<button type="submit" class="btn btn-accent w" data-es="Enviar solicitud" data-en="Send request">Enviar solicitud</button>
<small id="formMsg" data-es="Al enviar aceptas nuestras políticas de privacidad." data-en="By submitting you accept our privacy policy.">Al enviar aceptas nuestras políticas de privacidad.</small></form></div></section>
</main>
<?php site_footer(); site_scripts();
