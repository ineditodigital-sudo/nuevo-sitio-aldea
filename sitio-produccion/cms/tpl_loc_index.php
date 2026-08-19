<?php
site_head('Ubicaciones - Oficinas en renta y coworking | Aldea Networking','Oficinas en renta y coworking en Leon, San Luis Potosi, Aguascalientes y Queretaro.','/ubicaciones/',false,'Locations - Offices for rent and coworking | Aldea Networking','Offices for rent and coworking in Leon, San Luis Potosi, Aguascalientes and Queretaro.');
site_header();
banner('<a href="/" data-es="Inicio" data-en="Home">Inicio</a> / <span data-es="Ubicaciones" data-en="Locations">Ubicaciones</span>','Ubicaciones','Oficinas cerca de ti','Offices near you','Ubicaciones estrategicas en el Bajio mexicano. Elige tu ciudad y encuentra tu espacio ideal.','Strategic locations across Mexico Bajio.','loc-leon');
echo '<section class="section"><div class="container">'; loc_cards(); echo '</div></section>';
render_clients();
readfile(__DIR__.'/blk_cta.html');
site_footer(); site_scripts();
