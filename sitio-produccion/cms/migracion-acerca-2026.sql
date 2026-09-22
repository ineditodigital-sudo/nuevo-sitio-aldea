-- =====================================================================
-- ALDEA — Acerca de Aldea segun el brief del cliente (2026)
-- Ejecutar UNA vez, despues de subir los archivos nuevos.
-- Orden final: Hero / Numeros / Personas / Valores / Galeria / Footer
-- =====================================================================

SET NAMES utf8mb4;

SET @pg := (SELECT `id` FROM `pages` WHERE `slug`='acerca-de-aldea' LIMIT 1);

-- ---------------------------------------------------------------------
-- 1) HERO / QUIENES SOMOS
-- ---------------------------------------------------------------------
UPDATE `blocks` SET `value_es`='Creamos un mundo donde trabajar se disfrute.',
                    `value_en`='We build a world where work is something you enjoy.'
  WHERE `page_id`=@pg AND `skey`='h1';

UPDATE `blocks` SET
  `value_es`='Aldea es una empresa mexicana de espacios de trabajo fundada en 2017. Creamos y operamos lugares pensados para que personas y empresas puedan trabajar mejor, con atención cercana y una experiencia que va más allá del espacio físico.',
  `value_en`='Aldea is a Mexican workspace company founded in 2017. We create and run places designed so people and companies can work better, with close support and an experience that goes beyond the physical space.'
  WHERE `page_id`=@pg AND `skey`='lead';

-- Quita el CTA "Agenda tu tour" del hero: el bloque existe pero vacio.
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @pg,'hero','hero_cta','button','Boton del hero (vacio = sin boton)','','','/contacto/',5
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@pg AND b.`skey`='hero_cta');
UPDATE `blocks` SET `value_es`='', `value_en`='' WHERE `page_id`=@pg AND `skey`='hero_cta';

-- ---------------------------------------------------------------------
-- 2) ALDEA EN NUMEROS
-- ---------------------------------------------------------------------
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @pg,'body','stats_chip','eyebrow','Numeros - etiqueta','Números','Numbers','',9
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@pg AND b.`skey`='stats_chip');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @pg,'body','stats_titulo','text','Numeros - titulo','Aldea en números','Aldea by the numbers','',10
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@pg AND b.`skey`='stats_titulo');

UPDATE `blocks` SET `value_es`='2017', `value_en`='2017' WHERE `page_id`=@pg AND `skey`='stat1_title';
UPDATE `blocks` SET `value_es`='Año de fundación', `value_en`='Founded' WHERE `page_id`=@pg AND `skey`='stat1_text';
UPDATE `blocks` SET `value_es`='4', `value_en`='4' WHERE `page_id`=@pg AND `skey`='stat2_title';
UPDATE `blocks` SET `value_es`='Ciudades', `value_en`='Cities' WHERE `page_id`=@pg AND `skey`='stat2_text';
UPDATE `blocks` SET `value_es`='+120', `value_en`='+120' WHERE `page_id`=@pg AND `skey`='stat3_title';
UPDATE `blocks` SET `value_es`='Empresas', `value_en`='Companies' WHERE `page_id`=@pg AND `skey`='stat3_text';
UPDATE `blocks` SET `value_es`='+1,000', `value_en`='+1,000' WHERE `page_id`=@pg AND `skey`='stat4_title';
UPDATE `blocks` SET `value_es`='Miembros', `value_en`='Members' WHERE `page_id`=@pg AND `skey`='stat4_text';

INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @pg,'body','stat5_title','text','Dato 5 - cifra','+6,000 m²','+6,000 m²','',19
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@pg AND b.`skey`='stat5_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @pg,'body','stat5_text','text','Dato 5 - etiqueta','Espacios administrados','Space under management','',20
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@pg AND b.`skey`='stat5_text');

-- ---------------------------------------------------------------------
-- 3) LAS PERSONAS SON LO MAS IMPORTANTE
--    Reutiliza el bloque int_* (foto + texto) que ya existia.
-- ---------------------------------------------------------------------
UPDATE `blocks` SET `label`='Personas - etiqueta', `value_es`='Personas', `value_en`='People'
  WHERE `page_id`=@pg AND `skey`='int_chip';
UPDATE `blocks` SET `label`='Personas - titulo',
  `value_es`='Las personas son lo más importante', `value_en`='People come first'
  WHERE `page_id`=@pg AND `skey`='int_titulo';
UPDATE `blocks` SET `label`='Personas - texto',
  `value_es`='En Aldea creemos que un buen espacio de trabajo no depende únicamente del diseño o la infraestructura, sino de las personas que lo hacen funcionar todos los días. Nuestro equipo está presente para atender, anticiparse y resolver las necesidades de nuestros miembros y empresas.',
  `value_en`='At Aldea we believe a good workspace does not depend only on design or infrastructure, but on the people who make it work every day. Our team is there to serve, anticipate and solve what our members and companies need.'
  WHERE `page_id`=@pg AND `skey`='int_texto';
UPDATE `blocks` SET `label`='Personas - foto (usar foto real del equipo)'
  WHERE `page_id`=@pg AND `skey`='int_img';
-- Sin boton en esta seccion
UPDATE `blocks` SET `value_es`='', `value_en`='' WHERE `page_id`=@pg AND `skey`='int_boton';

INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @pg,'body','int_img_alt','text','Personas - texto alternativo de la foto','Equipo de Aldea','Aldea team','',8
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@pg AND b.`skey`='int_img_alt');

-- ---------------------------------------------------------------------
-- 4) NUESTROS VALORES  (frase + nombre del valor, sin descripciones)
-- ---------------------------------------------------------------------
UPDATE `blocks` SET `label`='Valor 1 - frase', `value_es`='En una Aldea nadie construye solo', `value_en`='In an Aldea nobody builds alone'
  WHERE `page_id`=@pg AND `skey`='val1_title';
UPDATE `blocks` SET `label`='Valor 1 - nombre', `type`='text', `value_es`='Colaboración', `value_en`='Collaboration'
  WHERE `page_id`=@pg AND `skey`='val1_text';

UPDATE `blocks` SET `label`='Valor 2 - frase', `value_es`='Las personas son lo más importante', `value_en`='People come first'
  WHERE `page_id`=@pg AND `skey`='val2_title';
UPDATE `blocks` SET `label`='Valor 2 - nombre', `type`='text', `value_es`='Personas', `value_en`='People'
  WHERE `page_id`=@pg AND `skey`='val2_text';

UPDATE `blocks` SET `label`='Valor 3 - frase', `value_es`='Ama lo que haces', `value_en`='Love what you do'
  WHERE `page_id`=@pg AND `skey`='val3_title';
UPDATE `blocks` SET `label`='Valor 3 - nombre', `type`='text', `value_es`='Pasión', `value_en`='Passion'
  WHERE `page_id`=@pg AND `skey`='val3_text';

UPDATE `blocks` SET `label`='Valor 4 - frase', `value_es`='Cero divas, más humildad', `value_en`='No divas, more humility'
  WHERE `page_id`=@pg AND `skey`='val4_title';
UPDATE `blocks` SET `label`='Valor 4 - nombre', `type`='text', `value_es`='Humildad', `value_en`='Humility'
  WHERE `page_id`=@pg AND `skey`='val4_text';

UPDATE `blocks` SET `label`='Valor 5 - frase', `value_es`='Si no te desafía, no te cambia', `value_en`='If it does not challenge you, it does not change you'
  WHERE `page_id`=@pg AND `skey`='val5_title';
UPDATE `blocks` SET `label`='Valor 5 - nombre', `type`='text', `value_es`='Evolución', `value_en`='Evolution'
  WHERE `page_id`=@pg AND `skey`='val5_text';

-- Fuera: "Guest go first" y cualquier valor extra
DELETE FROM `blocks` WHERE `page_id`=@pg AND `skey` IN ('val6_title','val6_text','val7_title','val7_text','val8_title','val8_text');

-- ---------------------------------------------------------------------
-- 5) ASI SE VIVE ALDEA (galeria)
--    gal1..gal6 quedan VACIOS a proposito: la seccion no se dibuja hasta
--    que RH cargue las fotos reales desde el panel.
--    El campo "Ingles" de cada foto se usa como texto alternativo.
-- ---------------------------------------------------------------------
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @pg,'body','gal_titulo','text','Galeria - titulo','Así se vive Aldea','This is life at Aldea','',60
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@pg AND b.`skey`='gal_titulo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @pg,'body','gal_texto','richtext','Galeria - texto','Nuestro equipo, nuestra cultura y los momentos que construimos juntos.','Our team, our culture and the moments we build together.','',61
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@pg AND b.`skey`='gal_texto');

INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @pg,'body','gal1','image','Galeria - foto 1 (la grande del mosaico)','','','',62
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT * FROM `blocks`) b WHERE b.`page_id`=@pg AND b.`skey`='gal1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @pg,'body','gal2','image','Galeria - foto 2','','','',63
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT * FROM `blocks`) b WHERE b.`page_id`=@pg AND b.`skey`='gal2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @pg,'body','gal3','image','Galeria - foto 3','','','',64
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT * FROM `blocks`) b WHERE b.`page_id`=@pg AND b.`skey`='gal3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @pg,'body','gal4','image','Galeria - foto 4','','','',65
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT * FROM `blocks`) b WHERE b.`page_id`=@pg AND b.`skey`='gal4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @pg,'body','gal5','image','Galeria - foto 5','','','',66
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT * FROM `blocks`) b WHERE b.`page_id`=@pg AND b.`skey`='gal5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @pg,'body','gal6','image','Galeria - foto 6','','','',67
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT * FROM `blocks`) b WHERE b.`page_id`=@pg AND b.`skey`='gal6');

-- ---------------------------------------------------------------------
-- 6) FOOTER: la pagina termina en la galeria, sin CTA de cierre
-- ---------------------------------------------------------------------
DELETE FROM `blocks` WHERE `page_id`=@pg AND `skey` IN ('cta_titulo','cta_texto','cta_boton');

-- ---------------------------------------------------------------------
-- PENDIENTE: fotografias reales de RH
-- ---------------------------------------------------------------------
-- La galeria y la foto de la seccion "Personas" necesitan imagenes del
-- equipo (team buildings, inauguraciones, staff, actividades internas).
-- Se cargan en /admin/pagina.php -> Acerca de Aldea. La galeria aparece
-- sola en cuanto haya al menos una foto.
