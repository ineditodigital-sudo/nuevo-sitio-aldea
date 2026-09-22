-- Direccion definitiva de Aldea Park, confirmada por el cliente.
--
-- Reune lo que estaba disperso: el numero con interior (157-D201) que tenia
-- la base, el fraccionamiento, y el codigo postal 78295 (la base tenia 78395,
-- que era el equivocado).
--
-- Orden convencional de direccion mexicana: calle y numero, fraccionamiento,
-- codigo postal, ciudad y estado.
--
-- Nota: sin variables de usuario en los WHERE. Comparar una variable contra
-- una columna mezcla collations (utf8mb4_general_ci vs utf8mb4_unicode_ci) y
-- MySQL lo rechaza.
SET NAMES utf8mb4;

UPDATE `locations`
   SET `address_es`='Blvd. Antonio Rocha Cordero 157-D201, Fracc. Desarrollo del Pedregal, 78295 San Luis Potosí, S.L.P.',
       `address_en`='Blvd. Antonio Rocha Cordero 157-D201, Fracc. Desarrollo del Pedregal, 78295 San Luis Potosí, S.L.P.'
 WHERE `slug`='oficinas-en-renta-san-luis-potosi';

UPDATE `blocks` SET
  `value_es`='Blvd. Antonio Rocha Cordero 157-D201, Fracc. Desarrollo del Pedregal, 78295 San Luis Potosí, S.L.P.',
  `value_en`='Blvd. Antonio Rocha Cordero 157-D201, Fracc. Desarrollo del Pedregal, 78295 San Luis Potosí, S.L.P.'
 WHERE `section`='hero' AND `skey`='direccion'
   AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='loc:oficinas-en-renta-san-luis-potosi') AS p);

UPDATE `blocks` SET
  `value_es`='Aldea Park se encuentra dentro de The Park, en Blvd. Antonio Rocha Cordero 157-D201, Fracc. Desarrollo del Pedregal, 78295 San Luis Potosí, S.L.P.'
 WHERE `section`='faq' AND `skey`='a1'
   AND `page_id`=(SELECT `id` FROM (SELECT `id` FROM `pages` WHERE `slug`='loc:oficinas-en-renta-san-luis-potosi') AS p);
