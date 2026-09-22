-- =====================================================================
-- Limpieza de la seccion "Portada" del Home en el panel.
--
-- El hero anterior era un collage de fotos flotantes con tarjetas y
-- etiquetas encima. Al rediseñarlo segun el brief, ese markup desaparecio
-- pero sus campos siguieron apareciendo en el panel sin controlar nada.
-- Se eliminan, se renombran las 4 imagenes del carrusel de forma
-- consistente y se ordenan para que la seccion se lea de arriba abajo.
-- =====================================================================
SET NAMES utf8mb4;

SET @home := (SELECT `id` FROM `pages` WHERE `slug`='' LIMIT 1);

-- 1) Fuera los campos del hero viejo (no los usa ninguna plantilla)
DELETE FROM `blocks` WHERE `page_id`=@home AND `section`='hero' AND `skey` IN
  ('floatcard_icon','floatcard_title','floatcard_sub',
   'floatchip_icon','floatchip_text',
   'floatlog_title','floatlog_sub');

-- 2) Las 4 imagenes del carrusel, con nombre claro y consistente
UPDATE `blocks` SET `label`='Carrusel — imagen 1 (la que se ve al cargar)', `sort`=20
  WHERE `page_id`=@home AND `section`='hero' AND `skey`='photo_a';
UPDATE `blocks` SET `label`='Carrusel — imagen 2', `sort`=21
  WHERE `page_id`=@home AND `section`='hero' AND `skey`='photo_b';
UPDATE `blocks` SET `label`='Carrusel — imagen 3', `sort`=22
  WHERE `page_id`=@home AND `section`='hero' AND `skey`='photo_c';
UPDATE `blocks` SET `label`='Carrusel — imagen 4 (dejala vacia si no la quieres)', `sort`=23
  WHERE `page_id`=@home AND `section`='hero' AND `skey`='photo_d';

-- 3) Orden de lectura del resto de la portada
UPDATE `blocks` SET `sort`=1  WHERE `page_id`=@home AND `section`='hero' AND `skey`='title';
UPDATE `blocks` SET `sort`=2  WHERE `page_id`=@home AND `section`='hero' AND `skey`='title2';
UPDATE `blocks` SET `sort`=3  WHERE `page_id`=@home AND `section`='hero' AND `skey`='lead';
UPDATE `blocks` SET `sort`=4  WHERE `page_id`=@home AND `section`='hero' AND `skey`='lead2';
UPDATE `blocks` SET `sort`=10 WHERE `page_id`=@home AND `section`='hero' AND `skey`='cta1';
UPDATE `blocks` SET `sort`=11 WHERE `page_id`=@home AND `section`='hero' AND `skey`='cta2';
