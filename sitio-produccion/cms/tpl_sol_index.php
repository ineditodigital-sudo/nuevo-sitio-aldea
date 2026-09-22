<?php
site_head('Espacios de trabajo - Oficina privada, coworking y mas | Aldea Networking','Oficina privada, coworking, escritorio privado y domicilio virtual en Leon, San Luis Potosi, Aguascalientes y Queretaro.','/lo-que-ofrecemos/',false,'Workspaces - Private office, coworking and more | Aldea Networking','Private office, coworking, private desk and virtual address in the Bajio.');
site_header();
banner('<a href="/" data-es="Inicio" data-en="Home">Inicio</a> / <span data-es="Espacios de trabajo" data-en="Workspaces">Espacios de trabajo</span>','Espacios de trabajo','Un espacio de trabajo para cada necesidad','A workspace for every need','Desde una persona hasta equipos completos, elige la solución que necesita tu empresa.','From one person to full teams, choose the solution your company needs.','sol-coworking');
$sols=cms_pdo()->query("SELECT * FROM solutions WHERE published=1 ORDER BY sort,id")->fetchAll();
echo '<section class="section"><div class="container"><div class="sol-grid g5">';
foreach($sols as $s) echo '<a class="solc reveal" href="/'.esc($s['slug']).'/"><div class="solc-img"><img src="'.esc($s['hero_image']).'" alt="'.esc($s['title_es']).'"></div><div class="solc-b"><h3 data-es="'.esc($s['title_es']).'" data-en="'.esc($s['title_en']).'">'.esc($s['title_es']).'</h3><p data-es="'.esc($s['excerpt_es']).'" data-en="'.esc($s['excerpt_en']).'">'.esc($s['excerpt_es']).'</p><span class="arrow" data-es="Conoce mas &rarr;" data-en="Learn more &rarr;">Conoce mas &rarr;</span></div></a>';
echo '</div></div></section>';
// Mismos servicios que el Home: una sola lista, editable en un solo lugar.
echo '<section class="section" id="amenidades"><div class="container"><div class="sec-head center reveal">'
    .'<span class="chip" data-es="Todo incluido" data-en="All included">Todo incluido</span>'
    .'<h2 data-es="Tú te ocupas de tu empresa. Nosotros de tu oficina." data-en="You focus on your company. We take care of your office.">Tú te ocupas de tu empresa. Nosotros de tu oficina.</h2></div>';
render_amenities();
echo '<p class="amen-note reveal" data-es="Los servicios incluidos pueden variar según la solución y ubicación contratada." data-en="Included services may vary by solution and location.">Los servicios incluidos pueden variar según la solución y ubicación contratada.</p>';
echo '</div></section>';
readfile(__DIR__.'/blk_cta.html');
site_footer(); site_scripts();
