-- =====================================================================
-- Acerca de Aldea: separar el bloque unico de 36 campos en las mismas
-- secciones que se ven en la pagina.
--
-- La plantilla lee los bloques por su clave, no por su seccion, asi que
-- reagrupar no cambia nada en el sitio: solo ordena el panel.
-- =====================================================================
SET NAMES utf8mb4;

-- numeros
UPDATE `blocks` SET `section`='numeros', `sort`=1, `label`='Etiqueta de la seccion'
  WHERE `skey`='stats_chip' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='numeros', `sort`=2, `label`='Titulo de la seccion'
  WHERE `skey`='stats_titulo' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='numeros', `sort`=10, `label`='Dato 1 - cifra'
  WHERE `skey`='stat1_title' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='numeros', `sort`=11, `label`='Dato 1 - etiqueta'
  WHERE `skey`='stat1_text' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='numeros', `sort`=12, `label`='Dato 2 - cifra'
  WHERE `skey`='stat2_title' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='numeros', `sort`=13, `label`='Dato 2 - etiqueta'
  WHERE `skey`='stat2_text' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='numeros', `sort`=14, `label`='Dato 3 - cifra'
  WHERE `skey`='stat3_title' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='numeros', `sort`=15, `label`='Dato 3 - etiqueta'
  WHERE `skey`='stat3_text' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='numeros', `sort`=16, `label`='Dato 4 - cifra'
  WHERE `skey`='stat4_title' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='numeros', `sort`=17, `label`='Dato 4 - etiqueta'
  WHERE `skey`='stat4_text' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='numeros', `sort`=18, `label`='Dato 5 - cifra'
  WHERE `skey`='stat5_title' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='numeros', `sort`=19, `label`='Dato 5 - etiqueta'
  WHERE `skey`='stat5_text' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);

-- personas
UPDATE `blocks` SET `section`='personas', `sort`=1, `label`='Etiqueta'
  WHERE `skey`='int_chip' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='personas', `sort`=2, `label`='Titulo'
  WHERE `skey`='int_titulo' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='personas', `sort`=3, `label`='Texto'
  WHERE `skey`='int_texto' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='personas', `sort`=4, `label`='Fotografia (usar una foto real del equipo)'
  WHERE `skey`='int_img' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='personas', `sort`=5, `label`='Texto alternativo de la foto'
  WHERE `skey`='int_img_alt' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='personas', `sort`=6, `label`='Boton (vacio = sin boton)'
  WHERE `skey`='int_boton' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);

-- valores
UPDATE `blocks` SET `section`='valores', `sort`=1, `label`='Valor 1 - frase'
  WHERE `skey`='val1_title' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='valores', `sort`=2, `label`='Valor 1 - nombre'
  WHERE `skey`='val1_text' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='valores', `sort`=3, `label`='Valor 2 - frase'
  WHERE `skey`='val2_title' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='valores', `sort`=4, `label`='Valor 2 - nombre'
  WHERE `skey`='val2_text' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='valores', `sort`=5, `label`='Valor 3 - frase'
  WHERE `skey`='val3_title' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='valores', `sort`=6, `label`='Valor 3 - nombre'
  WHERE `skey`='val3_text' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='valores', `sort`=7, `label`='Valor 4 - frase'
  WHERE `skey`='val4_title' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='valores', `sort`=8, `label`='Valor 4 - nombre'
  WHERE `skey`='val4_text' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='valores', `sort`=9, `label`='Valor 5 - frase'
  WHERE `skey`='val5_title' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='valores', `sort`=10, `label`='Valor 5 - nombre'
  WHERE `skey`='val5_text' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);

-- vivealdea
UPDATE `blocks` SET `section`='vivealdea', `sort`=1, `label`='Titulo de la seccion'
  WHERE `skey`='gal_titulo' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='vivealdea', `sort`=2, `label`='Texto de la seccion'
  WHERE `skey`='gal_texto' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='vivealdea', `sort`=10, `label`='Foto 1 (la grande del mosaico)'
  WHERE `skey`='gal1' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='vivealdea', `sort`=11, `label`='Foto 2'
  WHERE `skey`='gal2' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='vivealdea', `sort`=12, `label`='Foto 3'
  WHERE `skey`='gal3' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='vivealdea', `sort`=13, `label`='Foto 4'
  WHERE `skey`='gal4' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='vivealdea', `sort`=14, `label`='Foto 5'
  WHERE `skey`='gal5' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);
UPDATE `blocks` SET `section`='vivealdea', `sort`=15, `label`='Foto 6'
  WHERE `skey`='gal6' AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea') AS p);

