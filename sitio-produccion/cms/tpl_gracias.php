<?php
/* Gracias: a donde llegan los formularios cuando se envian bien (app6.js -> /formulario-enviado/).
   La URL no cambia porque es la que se mide como conversion. No se indexa.
   Antes era una copia estatica con el diseno y el menu anteriores. */
site_head('Gracias | Aldea Networking',
  'Recibimos tus datos. Un asesor de Aldea se pondrá en contacto contigo muy pronto.',
  '/formulario-enviado/', true,
  'Thank you | Aldea Networking',
  'We received your details. An Aldea advisor will contact you very soon.');
site_header();
$tel=setting('phone','+52 449 454 0709'); $telh='tel:'.preg_replace('/[^0-9+]/','',$tel);
echo '<main>';

$__in='<h1 data-es="Gracias por escribirnos" data-en="Thank you for reaching out">Gracias por escribirnos</h1>'
     .'<p class="lead" data-es="Recibimos tus datos. Un asesor se pondrá en contacto contigo muy pronto para ayudarte a encontrar tu espacio ideal." '
     .'data-en="We received your details. An advisor will contact you very soon to help you find the right workspace.">'
     .'Recibimos tus datos. Un asesor se pondrá en contacto contigo muy pronto para ayudarte a encontrar tu espacio ideal.</p>'
     .'<div class="hero-cta"><a class="btn btn-accent" href="/ubicaciones/" data-es="Ver ubicaciones" data-en="See locations">Ver ubicaciones</a>'
     .'<a class="btn btn-clear" href="'.esc($telh).'"><span data-es="Llamar ahora" data-en="Call now">Llamar ahora</span></a></div>';
page_hero('/img/sedes/slp/cabina.webp',L('Miembro de Aldea Park hablando por teléfono','Aldea Park member on a phone call'),$__in);

// Mientras espera: las sedes, para seguir explorando
echo '<section class="section"><div class="container">';
echo '<div class="sec-row reveal"><div class="sec-head"><h2 data-es="Conoce nuestras sedes" data-en="Explore our locations">Conoce nuestras sedes</h2></div>';
echo '<a class="sec-link" href="/"><span data-es="Volver al inicio" data-en="Back to home">Volver al inicio</span>'.aldea_icon('arrow-right').'</a></div>';
loc_cards();
echo '</div></section>';

echo '</main>';
site_footer();
site_scripts();
