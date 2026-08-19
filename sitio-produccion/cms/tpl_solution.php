<?php /* $sol en scope */
$imgs=json_decode($sol['gallery']?:'[]',true); if(!$imgs) $imgs=array_filter([$sol['hero_image']]);
$feat=json_decode($sol['features_es']?:'[]',true); if(!is_array($feat))$feat=[];
site_head(($sol['seo_title_es']?:$sol['title_es'].' - Aldea Networking'),($sol['seo_desc_es']?:$sol['excerpt_es']),'/'.$sol['slug'].'/',false,(($sol['seo_title_en']?:($sol['title_en']?:$sol['title_es'])).' - Aldea Networking'),($sol['seo_desc_en']?:($sol['excerpt_en']?:'')));
site_header();
echo '<section class="solhero"><div class="container"><div class="solhero-card sg"><div class="sg-imgs">';
foreach($imgs as $k=>$u) echo '<img class="sg-img'.($k===0?' on':'').'" src="'.esc($u).'" alt="'.esc(($sol['hero_image_alt']??'')?:$sol['title_es']).'"'.($k===0?'':' loading="lazy"').'>';
echo '</div><div class="solhero-ov"></div><div class="solhero-body reveal">';
echo '<div class="crumb"><a href="/" data-es="Inicio" data-en="Home">Inicio</a> / <a href="/lo-que-ofrecemos/" data-es="Soluciones" data-en="Solutions">Soluciones</a> / <span data-es="'.esc($sol['title_es']).'" data-en="'.esc($sol['title_en']).'">'.esc($sol['title_es']).'</span></div>';
echo '<span class="chip" data-es="Solucion" data-en="Solution">Solucion</span>';
echo '<h1 data-es="'.esc($sol['title_es']).'" data-en="'.esc($sol['title_en']).'">'.esc($sol['title_es']).'</h1>';
echo '<p class="lead" data-es="'.esc($sol['excerpt_es']).'" data-en="'.esc($sol['excerpt_en']).'">'.esc($sol['excerpt_es']).'</p>';
echo '<div class="hero-cta"><a href="/contacto/" class="btn btn-accent" data-es="Solicitar cotizacion" data-en="Request a quote">Solicitar cotizacion</a></div></div>';
if(count($imgs)>1){ echo '<div class="sg-thumbs">'; foreach($imgs as $k=>$u) echo '<button class="sg-thumb'.($k===0?' on':'').'"><img src="'.esc($u).'"></button>'; echo '</div>'; }
echo '<button class="sg-expand" aria-label="Pantalla completa"><svg viewBox="0 0 24 24"><path d="M8 3H5a2 2 0 0 0-2 2v3M16 3h3a2 2 0 0 1 2 2v3M8 21H5a2 2 0 0 1-2-2v-3M16 21h3a2 2 0 0 0 2-2v-3"/></svg></button>';
echo '</div></div></section>';
echo '<section class="section"><div class="container"><div class="solwhy reveal"><span class="chip" data-es="Por que Aldea" data-en="Why Aldea">Por que Aldea</span><h2 style="margin-top:.8rem" data-es="'.esc($sol['title_es']).'" data-en="'.esc($sol['title_en']).'">'.esc($sol['title_es']).'</h2>';
echo '<p data-es="'.esc($sol['body_es']).'" data-en="'.esc($sol['excerpt_en']).'">'.esc($sol['body_es']?:$sol['excerpt_es']).'</p><ul class="checklist">';
$incEs=array_values(array_filter(array_map('trim',explode("\n",(string)($sol['includes_es']??'')))));
$incEn=array_values(array_filter(array_map('trim',explode("\n",(string)($sol['includes_en']??'')))));
if(!$incEs)$incEs=$feat;
foreach($incEs as $i=>$f){ $en=$incEn[$i]??$f; echo '<li data-es="'.esc($f).'" data-en="'.esc($en).'">'.esc($f).'</li>'; }
echo '</ul><a href="/contacto/" class="btn btn-primary" data-es="Agenda tu tour" data-en="Book a tour">Agenda tu tour</a></div></div></section>';
render_benefits();
render_amenities();
echo '<section class="section"><div class="container"><div class="sec-head reveal"><span class="chip" data-es="Disponible en" data-en="Available at">Disponible en</span><h2 data-es="Encuentra esta solucion cerca de ti" data-en="Find this solution near you">Encuentra esta solucion cerca de ti</h2></div>';
loc_cards();
echo '</div></section>';
render_cta();
site_footer();
site_scripts();
