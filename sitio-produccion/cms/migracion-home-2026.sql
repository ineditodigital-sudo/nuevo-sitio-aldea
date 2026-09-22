-- =====================================================================
-- ALDEA — Migracion del Home segun el brief del cliente (2026)
-- Ejecutar UNA vez en phpMyAdmin sobre la base del CMS (aldea_cms),
-- DESPUES de subir los archivos nuevos. Incluye la creacion de bloques,
-- asi que NO hace falta correr /cms/seedhome.php (esa carpeta esta cerrada).
-- =====================================================================
-- Nota: MySQL no soporta "ADD COLUMN IF NOT EXISTS". Si el bloque 1
-- devuelve "Duplicate column name", ya estaba aplicado: continua.

SET NAMES utf8mb4;

-- ---------------------------------------------------------------------
-- 1) LEADS: campos nuevos del formulario
-- ---------------------------------------------------------------------
ALTER TABLE `leads`
  ADD COLUMN `company`   VARCHAR(160) NULL AFTER `phone`,
  ADD COLUMN `city`      VARCHAR(80)  NULL AFTER `company`,
  ADD COLUMN `team_size` VARCHAR(20)  NULL AFTER `city`;

-- ---------------------------------------------------------------------
-- 2) AJUSTES: URL de la landing de Oficinas Corporativas
--    Cambiala aqui cuando exista la landing definitiva.
-- ---------------------------------------------------------------------
INSERT INTO `settings` (`skey`,`value`) VALUES ('corp_url','/oficinas-personalizadas/')
  ON DUPLICATE KEY UPDATE `value`=VALUES(`value`);

-- ---------------------------------------------------------------------
-- 3) MENU DEL HEADER
-- ---------------------------------------------------------------------
-- "Lo que ofrecemos" pasa a llamarse "Espacios de trabajo".
-- OJO: NO cambiar el href (/lo-que-ofrecemos/): el slug se conserva por SEO
-- y el desplegable del header se detecta por esa ruta.
UPDATE `menu_items` SET `label_es`='Espacios de trabajo', `label_en`='Workspaces', `sort`=1, `published`=1
  WHERE `menu`='header' AND `href`='/lo-que-ofrecemos/';

UPDATE `menu_items` SET `label_es`='Ubicaciones', `label_en`='Locations', `sort`=2, `published`=1
  WHERE `menu`='header' AND `href`='/ubicaciones/';

UPDATE `menu_items` SET `label_es`='Acerca de Aldea', `label_en`='About Aldea', `sort`=4, `published`=1
  WHERE `menu`='header' AND `href`='/acerca-de-aldea/';

-- Fuera del menu: Blog (queda solo en el footer) y "Agenda tu tour"
UPDATE `menu_items` SET `published`=0
  WHERE `menu`='header' AND (`href` LIKE '/blog%' OR `label_es` LIKE '%Agenda%tour%');

-- Alta de "Oficinas Corporativas" (solo si no existe todavia)
INSERT INTO `menu_items` (`menu`,`label_es`,`label_en`,`href`,`source`,`sort`,`published`)
SELECT 'header','Oficinas Corporativas','Corporate Offices','/oficinas-personalizadas/','custom',3,1
  FROM DUAL WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT * FROM `menu_items`) m
    WHERE m.`menu`='header' AND m.`label_es`='Oficinas Corporativas');

-- ---------------------------------------------------------------------
-- 4) MENU LEGAL DEL FOOTER
-- ---------------------------------------------------------------------
UPDATE `menu_items` SET `label_es`='Aviso de privacidad', `label_en`='Privacy notice', `sort`=1
  WHERE `menu`='footer' AND `href`='/politicas-de-privacidad/';
UPDATE `menu_items` SET `label_es`='Términos y condiciones', `label_en`='Terms and conditions', `sort`=2
  WHERE `menu`='footer' AND `href`='/terminos-y-condiciones/';

-- ---------------------------------------------------------------------
-- 5) ESPACIOS DE TRABAJO: orden, visibilidad y textos de las 4 tarjetas
-- ---------------------------------------------------------------------
UPDATE `solutions` SET `in_menu`=0;

UPDATE `solutions` SET `sort`=1, `in_menu`=1, `published`=1,
  `excerpt_es`='Una oficina cerrada, amueblada y exclusiva para ti o tu equipo.',
  `excerpt_en`='A private, furnished office just for you or your team.'
  WHERE `slug`='oficina-privada';

UPDATE `solutions` SET `sort`=2, `in_menu`=1, `published`=1,
  `excerpt_es`='Trabaja desde nuestras áreas compartidas y disfruta de las instalaciones y servicios de Aldea.',
  `excerpt_en`='Work from our shared areas and enjoy all of Aldea''s facilities and services.'
  WHERE `slug`='coworking';

UPDATE `solutions` SET `sort`=3, `in_menu`=1, `published`=1,
  `excerpt_es`='Tu escritorio fijo y exclusivo dentro de un área de trabajo compartida.',
  `excerpt_en`='Your own fixed desk inside a shared working area.'
  WHERE `slug`='escritorio-privado';

UPDATE `solutions` SET `sort`=4, `in_menu`=1, `published`=1,
  `excerpt_es`='Domicilio fiscal y comercial para tu empresa, con recepción de correspondencia y servicios adicionales sin necesidad de una oficina permanente.',
  `excerpt_en`='A registered business address with mail handling and extra services, without a permanent office.'
  WHERE `slug`='domicilio-virtual';

-- ---------------------------------------------------------------------
-- 6) UBICACIONES: orden y nombres de sede del brief (Qro, Leon, SLP, Ags)
-- ---------------------------------------------------------------------
UPDATE `locations` SET `sort`=1, `name`='Aldea Centro Sur' WHERE `slug`='oficinas-en-renta-queretaro';
UPDATE `locations` SET `sort`=2, `name`='Aldea Poliforum'  WHERE `slug`='oficinas-en-renta-leon-guanajuato';
UPDATE `locations` SET `sort`=3, `name`='Aldea The Park'   WHERE `slug`='oficinas-en-renta-san-luis-potosi';
UPDATE `locations` SET `sort`=4, `name`='Aldea Galerías'   WHERE `slug`='oficinas-en-renta-aguascalientes';

-- ---------------------------------------------------------------------
-- 6b) TESTIMONIOS: el Home muestra los 3 primeros por orden.
--     Se priorizan operacion, servicio y flexibilidad (brief punto 9).
-- ---------------------------------------------------------------------
UPDATE `testimonials` SET `sort`=10;
UPDATE `testimonials` SET `sort`=1 WHERE `name` LIKE 'Eduardo%';   -- operacion
UPDATE `testimonials` SET `sort`=2 WHERE `name` LIKE 'Enrique%';   -- servicio
UPDATE `testimonials` SET `sort`=3 WHERE `name` LIKE 'Miguel%';    -- flexibilidad

-- ---------------------------------------------------------------------
-- 7) BLOQUES DEL HOME
-- ---------------------------------------------------------------------
-- Bloques editables del Home.
-- Equivale a ejecutar /cms/seedhome.php, que no es accesible por web
-- porque la carpeta cms/ esta protegida (ahi vive config.php).
-- Solo inserta los bloques que falten: no pisa nada que ya hayan editado.

INSERT INTO `pages` (`slug`,`type`,`title_es`,`title_en`,`published`)
  VALUES ('','home','Inicio','Home',1)
  ON DUPLICATE KEY UPDATE `type`='home';

SET @home := (SELECT `id` FROM `pages` WHERE `slug`='' LIMIT 1);

INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'hero','title','text','Titulo principal (linea 1)','Tu espacio de trabajo,','Your workspace,','',0 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='hero' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'hero','title2','text','Titulo principal (linea 2, resaltada)','sin complicaciones.','without the hassle.','',1 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='hero' AND b.`skey`='title2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'hero','lead','richtext','Texto de introduccion','Oficinas privadas y espacios de trabajo completamente equipados, con mobiliario, internet y servicios incluidos.','Private offices and fully equipped workspaces, with furniture, internet and services included.','',2 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='hero' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'hero','cta1','button','Boton principal','Ver ubicaciones','View locations','#ubicaciones',3 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='hero' AND b.`skey`='cta1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'hero','cta2','button','Boton secundario','Conoce nuestros espacios','Discover our spaces','#soluciones',4 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='hero' AND b.`skey`='cta2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'hero','lead2','richtext','Texto secundario','Para equipos desde 1 hasta más de 100 personas en Querétaro, León, San Luis Potosí y Aguascalientes.','For teams from 1 to more than 100 people in Queretaro, Leon, San Luis Potosi and Aguascalientes.','',5 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='hero' AND b.`skey`='lead2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'hero','photo_a','image','Imagen del hero 1','/img/home-hero.webp','','',6 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='hero' AND b.`skey`='photo_a');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'hero','photo_b','image','Imagen del hero 2','/img/espacio.webp','','',7 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='hero' AND b.`skey`='photo_b');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'hero','photo_c','image','Imagen del hero 3','/img/sala.webp','','',8 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='hero' AND b.`skey`='photo_c');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'hero','photo_d','image','Imagen del hero 4','/img/sol-coworking.webp','','',9 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='hero' AND b.`skey`='photo_d');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'soluciones','title','text','Titulo','Encuentra el espacio que necesitas','Find the space you need','',10 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='soluciones' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'soluciones','lead','richtext','Texto','Desde un lugar para trabajar hasta una oficina privada para todo tu equipo.','From a place to work to a private office for your whole team.','',11 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='soluciones' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'amenidades','title','text','Titulo','Tú te ocupas de tu empresa. Nosotros de tu oficina.','You take care of your business. We take care of your office.','',12 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='amenidades' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'amenidades','lead','richtext','Texto','Nos encargamos del espacio y de los servicios necesarios para que tú y tu equipo puedan trabajar desde el primer día.','We handle the space and the services so you and your team can work from day one.','',13 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='amenidades' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'amenidades','nota','text','Nota al pie','Los servicios incluidos pueden variar según la solución y ubicación contratada.','Included services may vary by solution and location.','',14 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='amenidades' AND b.`skey`='nota');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'ubicaciones','title','text','Titulo','Encuentra tu Aldea','Find your Aldea','',15 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='ubicaciones' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'ubicaciones','lead','richtext','Texto','Estamos presentes en cuatro ciudades del Bajío. Elige tu ubicación y conoce nuestros espacios.','We are present in four cities of the Bajio. Choose your location and discover our spaces.','',16 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='ubicaciones' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'clients','title','text','Titulo','Empresas que confían en Aldea','Companies that trust Aldea','',17 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='clients' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'corporativas','chip','eyebrow','Etiqueta','PARA EQUIPOS DE +100 PERSONAS','FOR TEAMS OF +100 PEOPLE','',18 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='corporativas' AND b.`skey`='chip');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'corporativas','title','text','Titulo','Oficinas Corporativas a la Medida','Tailor-made Corporate Offices','',19 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='corporativas' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'corporativas','text1','richtext','Texto 1','Diseñamos, adecuamos, equipamos y operamos espacios de trabajo exclusivos para grandes equipos.','We design, fit out, equip and operate exclusive workspaces for large teams.','',20 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='corporativas' AND b.`skey`='text1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'corporativas','text2','richtext','Texto 2','Desarrollamos cada proyecto alrededor de las necesidades reales de tu empresa: distribución, infraestructura, mobiliario, tecnología, servicios y operación.','We build every project around your real needs: layout, infrastructure, furniture, technology, services and operation.','',21 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='corporativas' AND b.`skey`='text2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'corporativas','step1','text','Paso 1','Entendemos tu operación','We map your operation','',22 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='corporativas' AND b.`skey`='step1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'corporativas','step2','text','Paso 2','Diseñamos la solución','We design the solution','',23 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='corporativas' AND b.`skey`='step2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'corporativas','step3','text','Paso 3','Adecuamos y equipamos','We fit out and equip','',24 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='corporativas' AND b.`skey`='step3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'corporativas','step4','text','Paso 4','Operamos tu oficina','We run your office','',25 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='corporativas' AND b.`skey`='step4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'corporativas','cta','button','Boton','Conoce más →','Learn more →','/oficinas-personalizadas/',26 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='corporativas' AND b.`skey`='cta');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'testimonios','title','text','Titulo','Lo que dicen nuestros clientes','What our clients say','',27 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='testimonios' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'numeros','title','text','Titulo','Aldea en números','Aldea by the numbers','',28 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='numeros' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'numeros','n1_value','text','Dato 1 - cifra','4','4','',29 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='numeros' AND b.`skey`='n1_value');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'numeros','n1_label','text','Dato 1 - etiqueta','Ciudades','Cities','',30 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='numeros' AND b.`skey`='n1_label');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'numeros','n2_value','text','Dato 2 - cifra','2017','2017','',31 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='numeros' AND b.`skey`='n2_value');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'numeros','n2_label','text','Dato 2 - etiqueta','Desde','Since','',32 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='numeros' AND b.`skey`='n2_label');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'numeros','n3_value','text','Dato 3 - cifra','+X','+X','',33 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='numeros' AND b.`skey`='n3_value');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'numeros','n3_label','text','Dato 3 - etiqueta','Empresas','Companies','',34 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='numeros' AND b.`skey`='n3_label');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'numeros','n4_value','text','Dato 4 - cifra','+X','+X','',35 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='numeros' AND b.`skey`='n4_value');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'numeros','n4_label','text','Dato 4 - etiqueta','Miembros','Members','',36 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='numeros' AND b.`skey`='n4_label');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'numeros','n5_value','text','Dato 5 - cifra','+X','+X','',37 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='numeros' AND b.`skey`='n5_value');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'numeros','n5_label','text','Dato 5 - etiqueta','m² de espacio','sq m of space','',38 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='numeros' AND b.`skey`='n5_label');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'numeros','cta','button','Boton (opcional, vacia para ocultar)','Conoce Aldea →','Discover Aldea →','/acerca-de-aldea/',39 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='numeros' AND b.`skey`='cta');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'contacto','title','text','Titulo','Hablemos sobre tu próximo espacio de trabajo','Let us talk about your next workspace','',40 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='contacto' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'contacto','lead','richtext','Texto','Déjanos tus datos y nuestro equipo comercial se pondrá en contacto contigo para conocer lo que necesitas.','Leave your details and our sales team will get in touch to understand what you need.','',41 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='contacto' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'contacto','phone','text','Telefono','+52 449 454 0709','+52 449 454 0709','tel:+524494540709',42 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='contacto' AND b.`skey`='phone');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @home,'contacto','email','text','Correo','contacto@aldea.work','contacto@aldea.work','mailto:contacto@aldea.work',43 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@home AND b.`section`='contacto' AND b.`skey`='email');

-- Secciones que salen del Home: "Nosotros" (la sustituye Aldea en numeros)
-- y "Precios por ciudad" (eliminada por completo).
DELETE FROM `blocks` WHERE `page_id`=@home AND `section` IN ('nosotros','precios');

-- Los servicios incluidos vuelven a los valores por defecto del codigo
-- (la lista nueva de 10 vive en amen_defaults() de cms/site.php).
DELETE FROM `blocks` WHERE `page_id`=@home AND `section`='amenidades' AND `skey` LIKE 'amen%';

-- HERO
UPDATE `blocks` SET `value_es`='Tu espacio de trabajo,', `value_en`='Your workspace,'
  WHERE `page_id`=@home AND `section`='hero' AND `skey`='title';
UPDATE `blocks` SET `value_es`='sin complicaciones.', `value_en`='without the hassle.'
  WHERE `page_id`=@home AND `section`='hero' AND `skey`='title2';
UPDATE `blocks` SET
  `value_es`='Oficinas privadas y espacios de trabajo completamente equipados, con mobiliario, internet y servicios incluidos.',
  `value_en`='Private offices and fully equipped workspaces, with furniture, internet and services included.'
  WHERE `page_id`=@home AND `section`='hero' AND `skey`='lead';
UPDATE `blocks` SET `value_es`='Ver ubicaciones', `value_en`='View locations', `href`='#ubicaciones'
  WHERE `page_id`=@home AND `section`='hero' AND `skey`='cta1';
UPDATE `blocks` SET `value_es`='Conoce nuestros espacios', `value_en`='Discover our spaces', `href`='#soluciones'
  WHERE `page_id`=@home AND `section`='hero' AND `skey`='cta2';
UPDATE `blocks` SET `value_es`='/img/home-hero.webp'
  WHERE `page_id`=@home AND `section`='hero' AND `skey`='photo_a';

-- CLIENTES
UPDATE `blocks` SET `value_es`='Empresas que confían en Aldea', `value_en`='Companies that trust Aldea'
  WHERE `page_id`=@home AND `section`='clients' AND `skey`='title';

-- ESPACIOS DE TRABAJO
UPDATE `blocks` SET `value_es`='Encuentra el espacio que necesitas', `value_en`='Find the space you need'
  WHERE `page_id`=@home AND `section`='soluciones' AND `skey`='title';
UPDATE `blocks` SET
  `value_es`='Desde un lugar para trabajar hasta una oficina privada para todo tu equipo.',
  `value_en`='From a place to work to a private office for your whole team.'
  WHERE `page_id`=@home AND `section`='soluciones' AND `skey`='lead';

-- SERVICIOS INCLUIDOS
UPDATE `blocks` SET
  `value_es`='Tú te ocupas de tu empresa. Nosotros de tu oficina.',
  `value_en`='You take care of your business. We take care of your office.'
  WHERE `page_id`=@home AND `section`='amenidades' AND `skey`='title';
UPDATE `blocks` SET
  `value_es`='Nos encargamos del espacio y de los servicios necesarios para que tú y tu equipo puedan trabajar desde el primer día.',
  `value_en`='We handle the space and the services so you and your team can work from day one.'
  WHERE `page_id`=@home AND `section`='amenidades' AND `skey`='lead';

-- UBICACIONES
UPDATE `blocks` SET `value_es`='Encuentra tu Aldea', `value_en`='Find your Aldea'
  WHERE `page_id`=@home AND `section`='ubicaciones' AND `skey`='title';
UPDATE `blocks` SET
  `value_es`='Estamos presentes en cuatro ciudades del Bajío. Elige tu ubicación y conoce nuestros espacios.',
  `value_en`='We are present in four cities of the Bajio. Choose your location and discover our spaces.'
  WHERE `page_id`=@home AND `section`='ubicaciones' AND `skey`='lead';

-- FORMULARIO
UPDATE `blocks` SET
  `value_es`='Hablemos sobre tu próximo espacio de trabajo',
  `value_en`='Let us talk about your next workspace'
  WHERE `page_id`=@home AND `section`='contacto' AND `skey`='title';
UPDATE `blocks` SET
  `value_es`='Déjanos tus datos y nuestro equipo comercial se pondrá en contacto contigo para conocer lo que necesitas.',
  `value_en`='Leave your details and our sales team will get in touch to understand what you need.'
  WHERE `page_id`=@home AND `section`='contacto' AND `skey`='lead';

-- ---------------------------------------------------------------------
-- 8) PENDIENTE MANUAL (desde el panel, no por SQL)
-- ---------------------------------------------------------------------
-- a) Testimonios: el Home muestra los 3 primeros por orden. Entra a
--    /admin/testimonios.php y ordena arriba los 3 que hablen de
--    operacion, servicio y flexibilidad.
-- b) Clientes: el Home muestra hasta 12 logos por orden. Ordena en
--    /admin/clientes.php los 8-12 mas relevantes.
-- c) Aldea en numeros: las cifras +X son placeholders. Cambialas en
--    /admin/pagina.php (seccion "Aldea en numeros") con datos validados.
