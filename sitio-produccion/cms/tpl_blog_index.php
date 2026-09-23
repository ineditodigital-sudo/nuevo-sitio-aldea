<?php
site_head('Blog | Aldea Networking','Ideas, tendencias y guias sobre espacios de trabajo flexibles, coworking y oficinas en renta.','/blog/',false,'Blog | Aldea Networking','Ideas, trends and guides on flexible workspaces, coworking and offices for rent.');
site_header();
jsonld_breadcrumbs([['Inicio','/'],['Blog','/blog/']]);
echo '<main>';
banner('','','Ideas para tu espacio de trabajo','Ideas for your workspace','Tendencias, guías y consejos sobre coworking y oficinas flexibles en México.','Trends and guides on coworking and flexible offices in Mexico.','/img/sedes/slp/gradas.webp','','');
$posts=cms_pdo()->query("SELECT * FROM posts WHERE status='publish' ORDER BY published_at DESC, id DESC")->fetchAll();
$__arrow=aldea_icon('arrow-right');
echo '<section class="section"><div class="container"><div class="blog-grid">';
foreach($posts as $p){ $cov=$p['cover_image']?'<div class="pc-img">'.pic($p['cover_image'],'','(max-width:560px) 100vw, (max-width:980px) 50vw, 33vw','loading="lazy"').'</div>':'<div class="pc-img"></div>';
  $__ten=$p['title_en']?:$p['title_es']; $__een=mb_strimwidth(strip_tags((string)($p['excerpt_en']?:$p['excerpt_es'])),0,150,'…'); $__ees=mb_strimwidth(strip_tags((string)$p['excerpt_es']),0,150,'…');
  echo '<a class="post-card reveal" href="/'.esc($p['slug']).'/">'.$cov.'<div class="pc-b"><time>'.esc(fmt_date($p['published_at'])).'</time><h3 data-es="'.esc($p['title_es']).'" data-en="'.esc($__ten).'">'.esc($p['title_es']).'</h3><p data-es="'.esc($__ees).'" data-en="'.esc($__een).'">'.esc($__ees).'</p><span class="lcard-go"><span data-es="Leer" data-en="Read">Leer</span>'.$__arrow.'</span></div></a>'; }
echo '</div></div></section>';
echo '</main>';
site_footer(); site_scripts();
