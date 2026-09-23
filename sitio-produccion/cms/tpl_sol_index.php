<?php
site_head('Espacios de trabajo - Oficina privada, coworking y mas | Aldea Networking','Oficina privada, coworking, escritorio privado y domicilio virtual en Leon, San Luis Potosi, Aguascalientes y Queretaro.','/lo-que-ofrecemos/',false,'Workspaces - Private office, coworking and more | Aldea Networking','Private office, coworking, private desk and virtual address in the Bajio.');
site_header();
jsonld_breadcrumbs([['Inicio','/'],['Espacios de trabajo','/lo-que-ofrecemos/']]);
echo '<main>';
banner('','','Un espacio de trabajo para cada necesidad','A workspace for every need','Desde una persona hasta equipos completos, elige la solución que necesita tu empresa.','From one person to full teams, choose the solution your company needs.','/img/sedes/leon/coworking.webp');
$sols=cms_pdo()->query("SELECT * FROM solutions WHERE published=1 ORDER BY sort,id")->fetchAll();
$__arrow=aldea_icon('arrow-right');
echo '<section class="section"><div class="container"><div class="sgrid" style="--n:'.max(1,min(4,count($sols))).'">';
foreach($sols as $s) echo '<a class="scard reveal" href="/'.esc($s['slug']).'/"><div class="scard-img">'.pic($s['hero_image'],L($s['title_es'],$s['title_en']??''),'(max-width:560px) 100vw, (max-width:1080px) 50vw, 25vw','loading="lazy"').'</div><div class="scard-b"><h3 data-es="'.esc($s['title_es']).'" data-en="'.esc($s['title_en']?:$s['title_es']).'">'.esc($s['title_es']).'</h3><p data-es="'.esc($s['excerpt_es']).'" data-en="'.esc($s['excerpt_en']?:$s['excerpt_es']).'">'.esc($s['excerpt_es']).'</p><span class="lcard-go"><span data-es="Conoce más" data-en="Learn more">Conoce más</span>'.$__arrow.'</span></div></a>';
echo '</div></div></section>';
// Mismos servicios que el Home: una sola lista, editable en un solo lugar.
echo '<section class="section bg-soft" id="amenidades"><div class="container duo rev reveal">';
echo '<figure class="duo-media tall">'.pic('/img/sedes/leon/lounge.webp',L('Áreas comunes de Aldea','Common areas at Aldea'),'(max-width:900px) 100vw, 58vw','loading="lazy"').'</figure><div class="duo-copy">';
echo '<h2 data-es="Tú te ocupas de tu empresa. Nosotros de tu oficina." data-en="You focus on your company. We take care of your office.">Tú te ocupas de tu empresa. Nosotros de tu oficina.</h2>';
render_amenities(null,'--cd:2;--ct:2;--cm:2');
echo '</div></div></section>';
readfile(__DIR__.'/blk_cta.html');
echo '</main>';
site_footer(); site_scripts();
