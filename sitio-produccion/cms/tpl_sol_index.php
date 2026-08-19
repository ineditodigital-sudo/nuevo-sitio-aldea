<?php
site_head('Lo que ofrecemos - Soluciones | Aldea Networking','Oficina privada, coworking, domicilio virtual, escritorio privado y oficinas personalizadas.','/lo-que-ofrecemos/',false,'What we offer - Solutions | Aldea Networking','Private office, coworking, virtual address, private desk and custom offices.');
site_header();
banner('<a href="/" data-es="Inicio" data-en="Home">Inicio</a> / <span data-es="Soluciones" data-en="Solutions">Soluciones</span>','Soluciones','Un espacio para cada necesidad','A space for every need','Desde emprendedores hasta grandes empresas, tenemos el espacio ideal para ti.','From entrepreneurs to large companies, we have the ideal space for you.','sol-coworking');
$sols=cms_pdo()->query("SELECT * FROM solutions WHERE published=1 ORDER BY sort,id")->fetchAll();
echo '<section class="section"><div class="container"><div class="sol-grid g5">';
foreach($sols as $s) echo '<a class="solc reveal" href="/'.esc($s['slug']).'/"><div class="solc-img"><img src="'.esc($s['hero_image']).'" alt="'.esc($s['title_es']).'"></div><div class="solc-b"><h3 data-es="'.esc($s['title_es']).'" data-en="'.esc($s['title_en']).'">'.esc($s['title_es']).'</h3><p data-es="'.esc($s['excerpt_es']).'" data-en="'.esc($s['excerpt_en']).'">'.esc($s['excerpt_es']).'</p><span class="arrow" data-es="Conoce mas &rarr;" data-en="Learn more &rarr;">Conoce mas &rarr;</span></div></a>';
echo '</div></div></section>';
readfile(__DIR__.'/blk_amen.html'); readfile(__DIR__.'/blk_cta.html');
site_footer(); site_scripts();
