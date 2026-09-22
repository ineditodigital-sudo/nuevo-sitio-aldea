<?php /* $post en scope */
$T=site_lang();
$pt=($T==='en'&&!empty($post['title_en']))?$post['title_en']:$post['title_es'];
$pe=($T==='en'&&!empty($post['excerpt_en']))?$post['excerpt_en']:$post['excerpt_es'];
$pb=($T==='en'&&!empty($post['body_en']))?$post['body_en']:$post['body_es'];
site_head($post['title_es'].' | Blog Aldea',mb_strimwidth(strip_tags((string)$post['excerpt_es']),0,150,'…'),'/'.$post['slug'].'/',false,(!empty($post['title_en'])?$post['title_en']:$post['title_es']).' | Blog Aldea',mb_strimwidth(strip_tags((string)($post['excerpt_en']?:$post['excerpt_es'])),0,150,'…'));
site_header();
echo '<section class="subhero"><div class="container"><div class="crumb reveal"><a href="/" data-es="Inicio" data-en="Home">Inicio</a> / <a href="/blog/">Blog</a> / <span data-es="'.esc(mb_strimwidth($post['title_es'],0,42,'…')).'" data-en="'.esc(mb_strimwidth($pt,0,42,'…')).'">'.esc(mb_strimwidth($post['title_es'],0,42,'…')).'</span></div><span class="chip reveal">'.esc(fmt_date($post['published_at'])).'</span><h1 class="reveal">'.esc($pt).'</h1></div></section>';
// La columna de lectura se limita dentro del contenedor, no en el contenedor:
// asi el cuerpo arranca en el mismo margen que el titulo del articulo.
echo '<section class="section"><div class="container"><div class="prose reveal">'.$pb.'</div></div></section>';
render_cta();
site_footer(); site_scripts();
