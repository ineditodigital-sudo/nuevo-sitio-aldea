<?php /* $post en scope */
$T=site_lang();
$pt=($T==='en'&&!empty($post['title_en']))?$post['title_en']:$post['title_es'];
$pe=($T==='en'&&!empty($post['excerpt_en']))?$post['excerpt_en']:$post['excerpt_es'];
$pb=($T==='en'&&!empty($post['body_en']))?$post['body_en']:$post['body_es'];
// Un articulo se comparte como 'article', no como pagina suelta.
$GLOBALS['og_type']='article';
site_head($post['title_es'].' | Blog Aldea',mb_strimwidth(strip_tags((string)$post['excerpt_es']),0,150,'…'),'/'.$post['slug'].'/',false,(!empty($post['title_en'])?$post['title_en']:$post['title_es']).' | Blog Aldea',mb_strimwidth(strip_tags((string)($post['excerpt_en']?:$post['excerpt_es'])),0,150,'…'));
site_header();
jsonld_breadcrumbs([['Inicio','/'],['Blog','/blog/'],[$post['title_es'],'/'.$post['slug'].'/']]);
echo '<main>';
// Banner del articulo: su portada a sangre; la fecha va debajo del titulo.
$__in='<h1>'.esc($pt).'</h1><p class="phero-meta">'.esc(fmt_date($post['published_at'])).'</p>';
page_hero($post['cover_image']?:'/img/sedes/leon/lounge.webp','',$__in);
// La columna de lectura se limita dentro del contenedor, no en el contenedor:
// asi el cuerpo arranca en el mismo margen que el titulo del articulo.
echo '<section class="section"><div class="container"><div class="prose reveal">'.$pb.'</div></div></section>';
render_cta();
echo '</main>';
site_footer(); site_scripts();
