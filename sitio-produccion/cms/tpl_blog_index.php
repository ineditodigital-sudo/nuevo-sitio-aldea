<?php
site_head('Blog | Aldea Networking','Ideas, tendencias y guias sobre espacios de trabajo flexibles, coworking y oficinas en renta.','/blog/',false,'Blog | Aldea Networking','Ideas, trends and guides on flexible workspaces, coworking and offices for rent.');
site_header();
banner('<a href="/" data-es="Inicio" data-en="Home">Inicio</a> / <span>Blog</span>','Blog','Ideas para tu espacio de trabajo','Ideas for your workspace','Tendencias, guias y consejos sobre coworking y oficinas flexibles en Mexico.','Trends and guides on coworking and flexible offices.','sol-coworking');
$posts=cms_pdo()->query("SELECT * FROM posts WHERE status='publish' ORDER BY published_at DESC, id DESC")->fetchAll();
echo '<section class="section"><div class="container"><div class="blog-grid">';
foreach($posts as $p){ $cov=$p['cover_image']?'<div class="pc-img"><img src="'.esc($p['cover_image']).'" alt="" loading="lazy"></div>':'<div class="pc-img"></div>';
  $__ten=$p['title_en']?:$p['title_es']; $__een=mb_strimwidth(strip_tags((string)($p['excerpt_en']?:$p['excerpt_es'])),0,150,'…'); $__ees=mb_strimwidth(strip_tags((string)$p['excerpt_es']),0,150,'…'); echo '<a class="post-card reveal" href="/'.esc($p['slug']).'/">'.$cov.'<div class="pc-b"><time>'.esc(fmt_date($p['published_at'])).'</time><h3 data-es="'.esc($p['title_es']).'" data-en="'.esc($__ten).'">'.esc($p['title_es']).'</h3><p data-es="'.esc($__ees).'" data-en="'.esc($__een).'">'.esc($__ees).'</p><span class="arrow" data-es="Leer &rarr;" data-en="Read &rarr;">Leer &rarr;</span></div></a>'; }
echo '</div></div></section>';
site_footer(); site_scripts();
