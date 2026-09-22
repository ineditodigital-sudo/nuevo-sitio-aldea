-- =====================================================================
-- ALDEA — las cuatro landings de sede con el mismo brief (2026)
-- Cada sede tiene su pagina oculta 'loc:<slug>' editable en el panel.
-- =====================================================================

SET NAMES utf8mb4;

-- ------------------------------------------------------------------
-- Aldea Centro Sur (Querétaro)
-- ------------------------------------------------------------------
INSERT INTO `pages` (`slug`,`type`,`title_es`,`title_en`,`published`)
  VALUES ('loc:oficinas-en-renta-queretaro','simple','Aldea Centro Sur (contenido)','Aldea Centro Sur (content)',0)
  ON DUPLICATE KEY UPDATE `title_es`=VALUES(`title_es`);
SET @lp := (SELECT `id` FROM `pages` WHERE `slug`='loc:oficinas-en-renta-queretaro' LIMIT 1);
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'hero','titulo','text','Titulo','Aldea Centro Sur','Aldea Centro Sur','',0 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='hero' AND b.`skey`='titulo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'hero','subtitulo','text','Subtitulo','Oficinas y espacios de trabajo en Querétaro','Offices and workspaces in Queretaro','',1 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='hero' AND b.`skey`='subtitulo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'hero','direccion','text','Direccion mostrada en la pagina','Av. David Ibarra Muñoz #600, Piso PH, Torre Capita Sur, Centro Sur, 76090 Querétaro, Qro.','Av. David Ibarra Muñoz #600, Piso PH, Torre Capita Sur, Centro Sur, 76090 Querétaro, Qro.','',2 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='hero' AND b.`skey`='direccion');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'hero','cta1','text','Boton principal','Agenda tu visita','Book a visit','',3 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='hero' AND b.`skey`='cta1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'hero','cta2','text','Boton secundario','Cotizar','Get a quote','',4 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='hero' AND b.`skey`='cta2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'empresas','title','text','Titulo de la franja de logos','Empresas que trabajan desde Aldea','Companies working from Aldea','',5 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='empresas' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','title','text','Titulo','Trabaja desde Centro Sur','Work from Centro Sur','',6 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','text','richtext','Texto','Aldea Centro Sur ocupa el Piso PH de la Torre Capita Sur, en el corazón de Centro Sur, una de las zonas más dinámicas de Querétaro y rodeada de corporativos e instituciones clave.','Aldea Centro Sur occupies the top floor of Torre Capita Sur, in the heart of Centro Sur, one of Queretaro''s most dynamic districts, surrounded by corporate offices and key institutions.','',7 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'hero','aviso','text','Aviso de apertura','Apertura prevista: 15 de junio de 2026','Opening: June 15, 2026','',8 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='hero' AND b.`skey`='aviso');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','d1','text','Diferenciador 1','Piso PH de Torre Capita Sur','Top floor of Torre Capita Sur','',9 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='d1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','d1_icon','text','Diferenciador 1 - icono','building','','',10 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='d1_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','d2','text','Diferenciador 2','Estacionamiento','Parking','',11 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='d2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','d2_icon','text','Diferenciador 2 - icono','key','','',12 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='d2_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','d3','text','Diferenciador 3','Acceso desde los principales puntos de la ciudad','Easy access from across the city','',13 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='d3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','d3_icon','text','Diferenciador 3 - icono','box','','',14 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='d3_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','title','text','Titulo','Espacios disponibles en Aldea Centro Sur','Spaces available at Aldea Centro Sur','',15 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p1_title','text','Espacio 1 - titulo','Oficina Privada','Private Office','',16 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p1_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p1_valor','text','Espacio 1 - valor en el formulario','Oficina Privada','Private Office','',17 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p1_valor');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p1_text','richtext','Espacio 1 - descripcion','Espacio cerrado, amueblado y exclusivo para ti o tu equipo.','An enclosed, furnished space just for you or your team.','',18 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p1_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p1_img','image','Espacio 1 - foto','/img/oficina-privada/op-2.webp','','',19 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p1_img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p1_periodo','text','Espacio 1 - periodo del precio','+ IVA / mes','+ VAT / mo','',20 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p1_periodo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p1_meta','text','Espacio 1 - capacidad','Desde 2 personas','From 2 people','',21 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p1_meta');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p2_title','text','Espacio 2 - titulo','Coworking','Coworking','',22 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p2_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p2_valor','text','Espacio 2 - valor en el formulario','Coworking','Coworking','',23 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p2_valor');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p2_text','richtext','Espacio 2 - descripcion','Trabaja desde nuestras áreas compartidas sin necesidad de tener un escritorio fijo.','Work from our shared areas with no need for a fixed desk.','',24 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p2_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p2_img','image','Espacio 2 - foto','/img/wp/2025/05/IMG_0093.webp','','',25 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p2_img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p2_periodo','text','Espacio 2 - periodo del precio','+ IVA / mes','+ VAT / mo','',26 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p2_periodo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p3_title','text','Espacio 3 - titulo','Escritorio Privado','Private Desk','',27 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p3_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p3_valor','text','Espacio 3 - valor en el formulario','Escritorio Privado','Private Desk','',28 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p3_valor');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p3_text','richtext','Espacio 3 - descripcion','Tu escritorio fijo y exclusivo dentro de una zona de trabajo compartida.','Your own fixed desk inside a shared working area.','',29 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p3_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p3_img','image','Espacio 3 - foto','/img/wp/2025/07/7-4.webp','','',30 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p3_img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p3_periodo','text','Espacio 3 - periodo del precio','+ IVA / mes','+ VAT / mo','',31 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p3_periodo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p4_title','text','Espacio 4 - titulo','Domicilio Virtual','Virtual Address','',32 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p4_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p4_valor','text','Espacio 4 - valor en el formulario','Domicilio Virtual','Virtual Address','',33 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p4_valor');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p4_text','richtext','Espacio 4 - descripcion','Dirección fiscal y comercial para tu empresa sin necesidad de rentar una oficina física.','A registered and commercial address for your company without renting a physical office.','',34 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p4_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p4_img','image','Espacio 4 - foto','/img/sol-virtual.webp','','',35 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p4_img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p4_periodo','text','Espacio 4 - periodo del precio','+ IVA','+ VAT','',36 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p4_periodo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p4_nota','text','Espacio 4 - aclaracion','Domicilio Virtual cuenta con servicios diferentes a nuestras membresías de espacios de trabajo.','','',37 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p4_nota');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','nota','text','Nota general','Precios y disponibilidad sujetos a cambio.','Prices and availability subject to change.','',38 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='nota');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','title','text','Titulo','Todo incluido para que solo te ocupes de trabajar','All included so you only have to work','',39 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s1','text','Servicio 1','Internet empresarial','Business internet','',40 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s1_icon','text','Servicio 1 - icono','wifi','','',41 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s1_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s2','text','Servicio 2','Mobiliario','Furniture','',42 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s2_icon','text','Servicio 2 - icono','furniture','','',43 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s2_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s3','text','Servicio 3','Salas de juntas','Meeting rooms','',44 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s3_icon','text','Servicio 3 - icono','users','','',45 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s3_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s4','text','Servicio 4','Recepción','Reception','',46 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s4_icon','text','Servicio 4 - icono','pin','','',47 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s4_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s5','text','Servicio 5','Limpieza','Cleaning','',48 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s5_icon','text','Servicio 5 - icono','sparkle','','',49 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s5_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s6','text','Servicio 6','Seguridad','Security','',50 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s6_icon','text','Servicio 6 - icono','shield','','',51 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s6_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s7','text','Servicio 7','Áreas comunes','Common areas','',52 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s7');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s7_icon','text','Servicio 7 - icono','heart','','',53 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s7_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s8','text','Servicio 8','Café y bebidas','Coffee and drinks','',54 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s8');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s8_icon','text','Servicio 8 - icono','coffee','','',55 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s8_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s9','text','Servicio 9','Cocina','Kitchen','',56 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s9');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s9_icon','text','Servicio 9 - icono','star','','',57 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s9_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s10','text','Servicio 10','Paquetería','Parcel handling','',58 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s10');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s10_icon','text','Servicio 10 - icono','box','','',59 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s10_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s11','text','Servicio 11','Impresiones','Printing','',60 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s11');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s11_icon','text','Servicio 11 - icono','printer','','',61 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s11_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s12','text','Servicio 12','Soporte en sitio','On-site support','',62 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s12');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s12_icon','text','Servicio 12 - icono','support','','',63 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s12_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','title','text','Titulo','Infraestructura que respalda tu operación','Infrastructure that backs your operation','',64 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t1_icon','text','Bloque 1 - icono','wifi','','',65 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t1_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t1_title','text','Bloque 1 - titulo','Conectividad','Connectivity','',66 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t1_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t1_text','richtext','Bloque 1 - texto','Internet empresarial e infraestructura para mantener conectado a tu equipo durante su operación diaria.','Business internet and infrastructure to keep your team connected through the working day.','',67 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t1_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t2_icon','text','Bloque 2 - icono','shield','','',68 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t2_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t2_title','text','Bloque 2 - titulo','Seguridad','Security','',69 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t2_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t2_text','richtext','Bloque 2 - texto','Control de acceso e instalaciones administradas para ofrecer un entorno de trabajo seguro.','Access control and managed facilities for a secure working environment.','',70 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t2_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t3_icon','text','Bloque 3 - icono','support','','',71 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t3_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t3_title','text','Bloque 3 - titulo','Soporte en sitio','On-site support','',72 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t3_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t3_text','richtext','Bloque 3 - texto','Equipo Aldea disponible para apoyar con las necesidades relacionadas con tu espacio y operación.','The Aldea team is on hand for anything related to your space and operation.','',73 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t3_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'mapa','title','text','Titulo','Una ubicación estratégica en Querétaro','A strategic location in Queretaro','',74 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='mapa' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'form','title','text','Titulo','Encuentra tu espacio en Aldea Centro Sur','Find your space at Aldea Centro Sur','',75 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='form' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'form','lead','richtext','Texto','Déjanos tus datos y nuestro equipo comercial te ayudará a encontrar las opciones disponibles para ti o tu empresa.','Leave your details and our sales team will help you find the options available for you or your company.','',76 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='form' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'form','boton','text','Texto del boton','Solicitar cotización','Request a quote','',77 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='form' AND b.`skey`='boton');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'visita','title','text','Titulo del modal','Agenda tu visita','Book a visit','',78 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='visita' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'visita','lead','richtext','Texto del modal','Elige el día y horario que mejor te acomode y te esperamos en Aldea Centro Sur.','Pick the day and time that suit you best and we will see you at Aldea Centro Sur.','',79 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='visita' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'visita','boton','text','Texto del boton','Agendar visita','Book visit','',80 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='visita' AND b.`skey`='boton');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','title','text','Titulo','Preguntas frecuentes','Frequently asked questions','',81 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q1','text','Pregunta 1','¿Dónde está Aldea Centro Sur?','','',82 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a1','richtext','Respuesta 1','Aldea Centro Sur se encuentra en Av. David Ibarra Muñoz #600, Piso PH, Torre Capita Sur, Centro Sur, 76090 Querétaro, Qro.','','',83 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q2','text','Pregunta 2','¿Qué espacios puedo contratar?','','',84 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a2','richtext','Respuesta 2','Contamos con Oficina Privada, Coworking, Escritorio Privado y Domicilio Virtual, sujetos a disponibilidad.','','',85 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q3','text','Pregunta 3','¿Las oficinas vienen amuebladas?','','',86 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a3','richtext','Respuesta 3','Sí. Las Oficinas Privadas se entregan con mobiliario para que puedas empezar a trabajar desde el primer día.','','',87 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q4','text','Pregunta 4','¿Cuál es el plazo mínimo de contratación?','','',88 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a4','richtext','Respuesta 4','Las membresías de espacios de trabajo pueden contratarse desde 1 mes, con opciones de mayor plazo según la solución y disponibilidad.','','',89 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q5','text','Pregunta 5','¿Puedo utilizar salas de juntas?','','',90 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a5','richtext','Respuesta 5','Sí. El acceso depende de las condiciones y créditos incluidos en la membresía contratada.','','',91 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q6','text','Pregunta 6','¿Aldea Centro Sur cuenta con estacionamiento?','','',92 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a6','richtext','Respuesta 6','Sí. La sede cuenta con estacionamiento en Torre Capita Sur. [PENDIENTE: confirmar las condiciones finales de estacionamiento.]','','',93 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q7','text','Pregunta 7','¿Puedo recibir clientes y visitantes?','','',94 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q7');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a7','richtext','Respuesta 7','Sí. Aldea cuenta con recepción y espacios para atender visitantes de acuerdo con las políticas de acceso de la sede.','','',95 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a7');
UPDATE `locations` SET `nearby`='{"Hospedaje": [["Real Inn", ""], ["Fiesta Inn Centro Sur", ""]], "Restaurantes": [["Puerta la Victoria", ""], ["Paseo Querétaro", ""]], "Zona": [["Centro Sur", ""], ["Hospital Ángeles", ""], ["Torre Capita Sur", ""]]}' WHERE `slug`='oficinas-en-renta-queretaro';

-- ------------------------------------------------------------------
-- Aldea Poliforum (León)
-- ------------------------------------------------------------------
INSERT INTO `pages` (`slug`,`type`,`title_es`,`title_en`,`published`)
  VALUES ('loc:oficinas-en-renta-leon-guanajuato','simple','Aldea Poliforum (contenido)','Aldea Poliforum (content)',0)
  ON DUPLICATE KEY UPDATE `title_es`=VALUES(`title_es`);
SET @lp := (SELECT `id` FROM `pages` WHERE `slug`='loc:oficinas-en-renta-leon-guanajuato' LIMIT 1);
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'hero','titulo','text','Titulo','Aldea Poliforum','Aldea Poliforum','',0 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='hero' AND b.`skey`='titulo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'hero','subtitulo','text','Subtitulo','Oficinas y espacios de trabajo en León','Offices and workspaces in Leon','',1 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='hero' AND b.`skey`='subtitulo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'hero','direccion','text','Direccion mostrada en la pagina','Blvd. Mariano Escobedo #2920, Ed. N Piso 5, Plaza Forum Center, Col. El Tlacuache, C.P. 37500 León, Gto.','Blvd. Mariano Escobedo #2920, Ed. N Piso 5, Plaza Forum Center, Col. El Tlacuache, C.P. 37500 León, Gto.','',2 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='hero' AND b.`skey`='direccion');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'hero','cta1','text','Boton principal','Agenda tu visita','Book a visit','',3 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='hero' AND b.`skey`='cta1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'hero','cta2','text','Boton secundario','Cotizar','Get a quote','',4 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='hero' AND b.`skey`='cta2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'empresas','title','text','Titulo de la franja de logos','Empresas que trabajan desde Aldea','Companies working from Aldea','',5 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='empresas' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','title','text','Titulo','Trabaja desde Plaza Forum Center','Work from Plaza Forum Center','',6 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','text','richtext','Texto','Aldea Poliforum está en Plaza Forum Center, en una zona céntrica de León, a 1.5 km de Poliforum León, uno de los principales centros de convenciones de la ciudad.','Aldea Poliforum sits in Plaza Forum Center, in a central area of Leon, 1.5 km from Poliforum Leon, one of the city''s main convention centers.','',7 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','d1','text','Diferenciador 1','Ubicación en Plaza Forum Center','Located in Plaza Forum Center','',8 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='d1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','d1_icon','text','Diferenciador 1 - icono','pin','','',9 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='d1_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','d2','text','Diferenciador 2','Estacionamiento','Parking','',10 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='d2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','d2_icon','text','Diferenciador 2 - icono','key','','',11 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='d2_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','d3','text','Diferenciador 3','A 1.5 km de Poliforum León','1.5 km from Poliforum Leon','',12 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='d3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','d3_icon','text','Diferenciador 3 - icono','box','','',13 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='d3_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','title','text','Titulo','Espacios disponibles en Aldea Poliforum','Spaces available at Aldea Poliforum','',14 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p1_title','text','Espacio 1 - titulo','Oficina Privada','Private Office','',15 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p1_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p1_valor','text','Espacio 1 - valor en el formulario','Oficina Privada','Private Office','',16 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p1_valor');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p1_text','richtext','Espacio 1 - descripcion','Espacio cerrado, amueblado y exclusivo para ti o tu equipo.','An enclosed, furnished space just for you or your team.','',17 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p1_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p1_img','image','Espacio 1 - foto','/img/oficina-privada/op-2.webp','','',18 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p1_img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p1_periodo','text','Espacio 1 - periodo del precio','+ IVA / mes','+ VAT / mo','',19 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p1_periodo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p1_meta','text','Espacio 1 - capacidad','Desde 2 personas','From 2 people','',20 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p1_meta');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p2_title','text','Espacio 2 - titulo','Coworking','Coworking','',21 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p2_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p2_valor','text','Espacio 2 - valor en el formulario','Coworking','Coworking','',22 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p2_valor');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p2_text','richtext','Espacio 2 - descripcion','Trabaja desde nuestras áreas compartidas sin necesidad de tener un escritorio fijo.','Work from our shared areas with no need for a fixed desk.','',23 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p2_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p2_img','image','Espacio 2 - foto','/img/wp/2025/05/IMG_0093.webp','','',24 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p2_img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p2_periodo','text','Espacio 2 - periodo del precio','+ IVA / mes','+ VAT / mo','',25 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p2_periodo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p3_title','text','Espacio 3 - titulo','Escritorio Privado','Private Desk','',26 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p3_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p3_valor','text','Espacio 3 - valor en el formulario','Escritorio Privado','Private Desk','',27 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p3_valor');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p3_text','richtext','Espacio 3 - descripcion','Tu escritorio fijo y exclusivo dentro de una zona de trabajo compartida.','Your own fixed desk inside a shared working area.','',28 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p3_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p3_img','image','Espacio 3 - foto','/img/wp/2025/07/7-4.webp','','',29 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p3_img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p3_periodo','text','Espacio 3 - periodo del precio','+ IVA / mes','+ VAT / mo','',30 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p3_periodo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p4_title','text','Espacio 4 - titulo','Domicilio Virtual','Virtual Address','',31 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p4_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p4_valor','text','Espacio 4 - valor en el formulario','Domicilio Virtual','Virtual Address','',32 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p4_valor');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p4_text','richtext','Espacio 4 - descripcion','Dirección fiscal y comercial para tu empresa sin necesidad de rentar una oficina física.','A registered and commercial address for your company without renting a physical office.','',33 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p4_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p4_img','image','Espacio 4 - foto','/img/sol-virtual.webp','','',34 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p4_img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p4_periodo','text','Espacio 4 - periodo del precio','+ IVA','+ VAT','',35 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p4_periodo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p4_nota','text','Espacio 4 - aclaracion','Domicilio Virtual cuenta con servicios diferentes a nuestras membresías de espacios de trabajo.','','',36 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p4_nota');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','nota','text','Nota general','Precios y disponibilidad sujetos a cambio.','Prices and availability subject to change.','',37 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='nota');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','title','text','Titulo','Todo incluido para que solo te ocupes de trabajar','All included so you only have to work','',38 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s1','text','Servicio 1','Internet empresarial','Business internet','',39 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s1_icon','text','Servicio 1 - icono','wifi','','',40 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s1_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s2','text','Servicio 2','Mobiliario','Furniture','',41 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s2_icon','text','Servicio 2 - icono','furniture','','',42 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s2_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s3','text','Servicio 3','Salas de juntas','Meeting rooms','',43 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s3_icon','text','Servicio 3 - icono','users','','',44 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s3_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s4','text','Servicio 4','Recepción','Reception','',45 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s4_icon','text','Servicio 4 - icono','pin','','',46 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s4_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s5','text','Servicio 5','Limpieza','Cleaning','',47 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s5_icon','text','Servicio 5 - icono','sparkle','','',48 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s5_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s6','text','Servicio 6','Seguridad','Security','',49 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s6_icon','text','Servicio 6 - icono','shield','','',50 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s6_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s7','text','Servicio 7','Áreas comunes','Common areas','',51 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s7');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s7_icon','text','Servicio 7 - icono','heart','','',52 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s7_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s8','text','Servicio 8','Café y bebidas','Coffee and drinks','',53 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s8');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s8_icon','text','Servicio 8 - icono','coffee','','',54 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s8_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s9','text','Servicio 9','Cocina','Kitchen','',55 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s9');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s9_icon','text','Servicio 9 - icono','star','','',56 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s9_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s10','text','Servicio 10','Paquetería','Parcel handling','',57 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s10');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s10_icon','text','Servicio 10 - icono','box','','',58 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s10_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s11','text','Servicio 11','Impresiones','Printing','',59 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s11');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s11_icon','text','Servicio 11 - icono','printer','','',60 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s11_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s12','text','Servicio 12','Soporte en sitio','On-site support','',61 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s12');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s12_icon','text','Servicio 12 - icono','support','','',62 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s12_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','title','text','Titulo','Infraestructura que respalda tu operación','Infrastructure that backs your operation','',63 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t1_icon','text','Bloque 1 - icono','wifi','','',64 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t1_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t1_title','text','Bloque 1 - titulo','Conectividad','Connectivity','',65 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t1_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t1_text','richtext','Bloque 1 - texto','Internet empresarial e infraestructura para mantener conectado a tu equipo durante su operación diaria.','Business internet and infrastructure to keep your team connected through the working day.','',66 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t1_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t2_icon','text','Bloque 2 - icono','shield','','',67 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t2_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t2_title','text','Bloque 2 - titulo','Seguridad','Security','',68 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t2_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t2_text','richtext','Bloque 2 - texto','Control de acceso e instalaciones administradas para ofrecer un entorno de trabajo seguro.','Access control and managed facilities for a secure working environment.','',69 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t2_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t3_icon','text','Bloque 3 - icono','support','','',70 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t3_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t3_title','text','Bloque 3 - titulo','Soporte en sitio','On-site support','',71 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t3_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t3_text','richtext','Bloque 3 - texto','Equipo Aldea disponible para apoyar con las necesidades relacionadas con tu espacio y operación.','The Aldea team is on hand for anything related to your space and operation.','',72 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t3_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'mapa','title','text','Titulo','Una ubicación estratégica en León','A strategic location in Leon','',73 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='mapa' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'form','title','text','Titulo','Encuentra tu espacio en Aldea Poliforum','Find your space at Aldea Poliforum','',74 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='form' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'form','lead','richtext','Texto','Déjanos tus datos y nuestro equipo comercial te ayudará a encontrar las opciones disponibles para ti o tu empresa.','Leave your details and our sales team will help you find the options available for you or your company.','',75 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='form' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'form','boton','text','Texto del boton','Solicitar cotización','Request a quote','',76 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='form' AND b.`skey`='boton');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'visita','title','text','Titulo del modal','Agenda tu visita','Book a visit','',77 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='visita' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'visita','lead','richtext','Texto del modal','Elige el día y horario que mejor te acomode y te esperamos en Aldea Poliforum.','Pick the day and time that suit you best and we will see you at Aldea Poliforum.','',78 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='visita' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'visita','boton','text','Texto del boton','Agendar visita','Book visit','',79 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='visita' AND b.`skey`='boton');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','title','text','Titulo','Preguntas frecuentes','Frequently asked questions','',80 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q1','text','Pregunta 1','¿Dónde está Aldea Poliforum?','','',81 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a1','richtext','Respuesta 1','Aldea Poliforum se encuentra en Blvd. Mariano Escobedo #2920, Ed. N Piso 5, Plaza Forum Center, Col. El Tlacuache, C.P. 37500 León, Gto.','','',82 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q2','text','Pregunta 2','¿Qué espacios puedo contratar?','','',83 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a2','richtext','Respuesta 2','Contamos con Oficina Privada, Coworking, Escritorio Privado y Domicilio Virtual, sujetos a disponibilidad.','','',84 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q3','text','Pregunta 3','¿Las oficinas vienen amuebladas?','','',85 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a3','richtext','Respuesta 3','Sí. Las Oficinas Privadas se entregan con mobiliario para que puedas empezar a trabajar desde el primer día.','','',86 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q4','text','Pregunta 4','¿Cuál es el plazo mínimo de contratación?','','',87 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a4','richtext','Respuesta 4','Las membresías de espacios de trabajo pueden contratarse desde 1 mes, con opciones de mayor plazo según la solución y disponibilidad.','','',88 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q5','text','Pregunta 5','¿Puedo utilizar salas de juntas?','','',89 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a5','richtext','Respuesta 5','Sí. El acceso depende de las condiciones y créditos incluidos en la membresía contratada.','','',90 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q6','text','Pregunta 6','¿Aldea Poliforum cuenta con estacionamiento?','','',91 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a6','richtext','Respuesta 6','Sí. La sede cuenta con estacionamiento en Plaza Forum Center. [PENDIENTE: confirmar las condiciones finales de estacionamiento.]','','',92 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q7','text','Pregunta 7','¿Puedo recibir clientes y visitantes?','','',93 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q7');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a7','richtext','Respuesta 7','Sí. Aldea cuenta con recepción y espacios para atender visitantes de acuerdo con las políticas de acceso de la sede.','','',94 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a7');
UPDATE `locations` SET `nearby`='{"Hospedaje": [["Hotel One Poliforum", ""], ["Courtyard Poliforum", ""]], "Restaurantes": [["Cervone", ""], ["Osteria Da Bianco", ""], ["Mr. Pampas", ""]], "Zona": [["Plaza Forum Center", ""], ["Poliforum León", ""], ["Punto Escobedo", ""]]}' WHERE `slug`='oficinas-en-renta-leon-guanajuato';

-- ------------------------------------------------------------------
-- Aldea Park (San Luis Potosí)
-- ------------------------------------------------------------------
INSERT INTO `pages` (`slug`,`type`,`title_es`,`title_en`,`published`)
  VALUES ('loc:oficinas-en-renta-san-luis-potosi','simple','Aldea Park (contenido)','Aldea Park (content)',0)
  ON DUPLICATE KEY UPDATE `title_es`=VALUES(`title_es`);
SET @lp := (SELECT `id` FROM `pages` WHERE `slug`='loc:oficinas-en-renta-san-luis-potosi' LIMIT 1);
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'hero','titulo','text','Titulo','Aldea Park','Aldea Park','',0 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='hero' AND b.`skey`='titulo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'hero','subtitulo','text','Subtitulo','Oficinas y espacios de trabajo en San Luis Potosí','Offices and workspaces in San Luis Potosi','',1 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='hero' AND b.`skey`='subtitulo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'hero','direccion','text','Direccion mostrada en la pagina','Blvd. Antonio Rocha Cordero 157, 78295 San Luis Potosí, S.L.P.','Blvd. Antonio Rocha Cordero 157, 78295 San Luis Potosí, S.L.P.','',2 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='hero' AND b.`skey`='direccion');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'hero','cta1','text','Boton principal','Agenda tu visita','Book a visit','',3 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='hero' AND b.`skey`='cta1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'hero','cta2','text','Boton secundario','Cotizar','Get a quote','',4 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='hero' AND b.`skey`='cta2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'empresas','title','text','Titulo de la franja de logos','Empresas que trabajan desde Aldea','Companies working from Aldea','',5 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='empresas' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','title','text','Titulo','Trabaja desde The Park','Work from The Park','',6 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','text','richtext','Texto','Aldea Park está ubicada al sur de San Luis Potosí, dentro de The Park, en una zona empresarial con excelente conectividad y servicios alrededor.','Aldea Park sits in the south of San Luis Potosi, inside The Park, in a business district with great connectivity and services all around.','',7 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','d1','text','Diferenciador 1','Ubicación dentro de The Park','Located inside The Park','',8 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='d1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','d1_icon','text','Diferenciador 1 - icono','pin','','',9 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='d1_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','d2','text','Diferenciador 2','Estacionamiento','Parking','',10 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='d2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','d2_icon','text','Diferenciador 2 - icono','key','','',11 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='d2_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','d3','text','Diferenciador 3','Conectividad con principales vialidades de San Luis Potosí','Connected to the city''s main roads','',12 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='d3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','d3_icon','text','Diferenciador 3 - icono','box','','',13 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='d3_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','title','text','Titulo','Espacios disponibles en Aldea Park','Spaces available at Aldea Park','',14 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p1_title','text','Espacio 1 - titulo','Oficina Privada','Private Office','',15 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p1_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p1_valor','text','Espacio 1 - valor en el formulario','Oficina Privada','Private Office','',16 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p1_valor');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p1_text','richtext','Espacio 1 - descripcion','Espacio cerrado, amueblado y exclusivo para ti o tu equipo.','An enclosed, furnished space just for you or your team.','',17 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p1_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p1_img','image','Espacio 1 - foto','/img/oficina-privada/op-2.webp','','',18 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p1_img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p1_periodo','text','Espacio 1 - periodo del precio','+ IVA / mes','+ VAT / mo','',19 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p1_periodo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p1_meta','text','Espacio 1 - capacidad','Desde 2 personas','From 2 people','',20 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p1_meta');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p2_title','text','Espacio 2 - titulo','Coworking','Coworking','',21 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p2_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p2_valor','text','Espacio 2 - valor en el formulario','Coworking','Coworking','',22 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p2_valor');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p2_text','richtext','Espacio 2 - descripcion','Trabaja desde nuestras áreas compartidas sin necesidad de tener un escritorio fijo.','Work from our shared areas with no need for a fixed desk.','',23 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p2_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p2_img','image','Espacio 2 - foto','/img/wp/2025/05/IMG_0093.webp','','',24 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p2_img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p2_periodo','text','Espacio 2 - periodo del precio','+ IVA / mes','+ VAT / mo','',25 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p2_periodo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p3_title','text','Espacio 3 - titulo','Escritorio Privado','Private Desk','',26 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p3_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p3_valor','text','Espacio 3 - valor en el formulario','Escritorio Privado','Private Desk','',27 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p3_valor');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p3_text','richtext','Espacio 3 - descripcion','Tu escritorio fijo y exclusivo dentro de una zona de trabajo compartida.','Your own fixed desk inside a shared working area.','',28 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p3_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p3_img','image','Espacio 3 - foto','/img/wp/2025/07/7-4.webp','','',29 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p3_img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p3_periodo','text','Espacio 3 - periodo del precio','+ IVA / mes','+ VAT / mo','',30 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p3_periodo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p4_title','text','Espacio 4 - titulo','Domicilio Virtual','Virtual Address','',31 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p4_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p4_valor','text','Espacio 4 - valor en el formulario','Domicilio Virtual','Virtual Address','',32 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p4_valor');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p4_text','richtext','Espacio 4 - descripcion','Dirección fiscal y comercial para tu empresa sin necesidad de rentar una oficina física.','A registered and commercial address for your company without renting a physical office.','',33 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p4_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p4_img','image','Espacio 4 - foto','/img/sol-virtual.webp','','',34 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p4_img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p4_periodo','text','Espacio 4 - periodo del precio','+ IVA','+ VAT','',35 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p4_periodo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p4_nota','text','Espacio 4 - aclaracion','Domicilio Virtual cuenta con servicios diferentes a nuestras membresías de espacios de trabajo.','','',36 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p4_nota');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','nota','text','Nota general','Precios y disponibilidad sujetos a cambio.','Prices and availability subject to change.','',37 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='nota');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','title','text','Titulo','Todo incluido para que solo te ocupes de trabajar','All included so you only have to work','',38 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s1','text','Servicio 1','Internet empresarial','Business internet','',39 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s1_icon','text','Servicio 1 - icono','wifi','','',40 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s1_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s2','text','Servicio 2','Mobiliario','Furniture','',41 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s2_icon','text','Servicio 2 - icono','furniture','','',42 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s2_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s3','text','Servicio 3','Salas de juntas','Meeting rooms','',43 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s3_icon','text','Servicio 3 - icono','users','','',44 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s3_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s4','text','Servicio 4','Recepción','Reception','',45 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s4_icon','text','Servicio 4 - icono','pin','','',46 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s4_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s5','text','Servicio 5','Limpieza','Cleaning','',47 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s5_icon','text','Servicio 5 - icono','sparkle','','',48 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s5_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s6','text','Servicio 6','Seguridad','Security','',49 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s6_icon','text','Servicio 6 - icono','shield','','',50 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s6_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s7','text','Servicio 7','Áreas comunes','Common areas','',51 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s7');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s7_icon','text','Servicio 7 - icono','heart','','',52 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s7_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s8','text','Servicio 8','Café y bebidas','Coffee and drinks','',53 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s8');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s8_icon','text','Servicio 8 - icono','coffee','','',54 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s8_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s9','text','Servicio 9','Cocina','Kitchen','',55 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s9');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s9_icon','text','Servicio 9 - icono','star','','',56 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s9_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s10','text','Servicio 10','Paquetería','Parcel handling','',57 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s10');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s10_icon','text','Servicio 10 - icono','box','','',58 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s10_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s11','text','Servicio 11','Impresiones','Printing','',59 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s11');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s11_icon','text','Servicio 11 - icono','printer','','',60 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s11_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s12','text','Servicio 12','Soporte en sitio','On-site support','',61 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s12');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s12_icon','text','Servicio 12 - icono','support','','',62 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s12_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','title','text','Titulo','Infraestructura que respalda tu operación','Infrastructure that backs your operation','',63 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t1_icon','text','Bloque 1 - icono','wifi','','',64 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t1_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t1_title','text','Bloque 1 - titulo','Conectividad','Connectivity','',65 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t1_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t1_text','richtext','Bloque 1 - texto','Internet empresarial e infraestructura para mantener conectado a tu equipo durante su operación diaria.','Business internet and infrastructure to keep your team connected through the working day.','',66 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t1_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t2_icon','text','Bloque 2 - icono','shield','','',67 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t2_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t2_title','text','Bloque 2 - titulo','Seguridad','Security','',68 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t2_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t2_text','richtext','Bloque 2 - texto','Control de acceso e instalaciones administradas para ofrecer un entorno de trabajo seguro.','Access control and managed facilities for a secure working environment.','',69 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t2_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t3_icon','text','Bloque 3 - icono','support','','',70 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t3_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t3_title','text','Bloque 3 - titulo','Soporte en sitio','On-site support','',71 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t3_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t3_text','richtext','Bloque 3 - texto','Equipo Aldea disponible para apoyar con las necesidades relacionadas con tu espacio y operación.','The Aldea team is on hand for anything related to your space and operation.','',72 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t3_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'mapa','title','text','Titulo','Una ubicación estratégica en San Luis Potosí','A strategic location in San Luis Potosi','',73 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='mapa' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'form','title','text','Titulo','Encuentra tu espacio en Aldea Park','Find your space at Aldea Park','',74 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='form' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'form','lead','richtext','Texto','Déjanos tus datos y nuestro equipo comercial te ayudará a encontrar las opciones disponibles para ti o tu empresa.','Leave your details and our sales team will help you find the options available for you or your company.','',75 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='form' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'form','boton','text','Texto del boton','Solicitar cotización','Request a quote','',76 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='form' AND b.`skey`='boton');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'visita','title','text','Titulo del modal','Agenda tu visita','Book a visit','',77 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='visita' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'visita','lead','richtext','Texto del modal','Elige el día y horario que mejor te acomode y te esperamos en Aldea Park.','Pick the day and time that suit you best and we will see you at Aldea Park.','',78 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='visita' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'visita','boton','text','Texto del boton','Agendar visita','Book visit','',79 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='visita' AND b.`skey`='boton');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','title','text','Titulo','Preguntas frecuentes','Frequently asked questions','',80 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q1','text','Pregunta 1','¿Dónde está Aldea Park?','','',81 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a1','richtext','Respuesta 1','Aldea Park se encuentra en Blvd. Antonio Rocha Cordero 157, 78295 San Luis Potosí, S.L.P.','','',82 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q2','text','Pregunta 2','¿Qué espacios puedo contratar?','','',83 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a2','richtext','Respuesta 2','Contamos con Oficina Privada, Coworking, Escritorio Privado y Domicilio Virtual, sujetos a disponibilidad.','','',84 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q3','text','Pregunta 3','¿Las oficinas vienen amuebladas?','','',85 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a3','richtext','Respuesta 3','Sí. Las Oficinas Privadas se entregan con mobiliario para que puedas empezar a trabajar desde el primer día.','','',86 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q4','text','Pregunta 4','¿Cuál es el plazo mínimo de contratación?','','',87 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a4','richtext','Respuesta 4','Las membresías de espacios de trabajo pueden contratarse desde 1 mes, con opciones de mayor plazo según la solución y disponibilidad.','','',88 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q5','text','Pregunta 5','¿Puedo utilizar salas de juntas?','','',89 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a5','richtext','Respuesta 5','Sí. El acceso depende de las condiciones y créditos incluidos en la membresía contratada.','','',90 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q6','text','Pregunta 6','¿Aldea Park cuenta con estacionamiento?','','',91 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a6','richtext','Respuesta 6','Sí. Aldea Park cuenta con estacionamiento dentro de The Park. [PENDIENTE: confirmar las condiciones finales de estacionamiento.]','','',92 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q7','text','Pregunta 7','¿Puedo recibir clientes y visitantes?','','',93 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q7');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a7','richtext','Respuesta 7','Sí. Aldea cuenta con recepción y espacios para atender visitantes de acuerdo con las políticas de acceso de la sede.','','',94 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a7');
UPDATE `locations` SET `nearby`='{"Hospedaje": [["Hyatt Regency", ""], ["City Express Plus", ""]], "Restaurantes": [["Sonora Prime", ""], ["Ojo de Agua", ""], ["Sunset Rooftop", ""]], "Zona": [["The Park", ""], ["Parque Tangamanga", ""], ["Centro de Convenciones", ""]]}' WHERE `slug`='oficinas-en-renta-san-luis-potosi';

-- ------------------------------------------------------------------
-- Aldea Galerías (Aguascalientes)
-- ------------------------------------------------------------------
INSERT INTO `pages` (`slug`,`type`,`title_es`,`title_en`,`published`)
  VALUES ('loc:oficinas-en-renta-aguascalientes','simple','Aldea Galerías (contenido)','Aldea Galerías (content)',0)
  ON DUPLICATE KEY UPDATE `title_es`=VALUES(`title_es`);
SET @lp := (SELECT `id` FROM `pages` WHERE `slug`='loc:oficinas-en-renta-aguascalientes' LIMIT 1);
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'hero','titulo','text','Titulo','Aldea Galerías','Aldea Galerías','',0 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='hero' AND b.`skey`='titulo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'hero','subtitulo','text','Subtitulo','Oficinas y espacios de trabajo en Aguascalientes','Offices and workspaces in Aguascalientes','',1 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='hero' AND b.`skey`='subtitulo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'hero','direccion','text','Direccion mostrada en la pagina','Av. Independencia #1861, Ed. 5, Galerías Business Square, C.P. 20120, Aguascalientes, Ags.','Av. Independencia #1861, Ed. 5, Galerías Business Square, C.P. 20120, Aguascalientes, Ags.','',2 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='hero' AND b.`skey`='direccion');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'hero','cta1','text','Boton principal','Agenda tu visita','Book a visit','',3 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='hero' AND b.`skey`='cta1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'hero','cta2','text','Boton secundario','Cotizar','Get a quote','',4 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='hero' AND b.`skey`='cta2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'empresas','title','text','Titulo de la franja de logos','Empresas que trabajan desde Aldea','Companies working from Aldea','',5 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='empresas' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','title','text','Titulo','Trabaja desde Galerías Business Square','Work from Galerias Business Square','',6 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','text','richtext','Texto','Aldea Galerías está dentro de Galerías Business Square, una plaza privada al norte de la ciudad, junto al centro comercial Galerías y a 2 km de Altaria.','Aldea Galerias is inside Galerias Business Square, a private complex in the north of the city, next to Galerias mall and 2 km from Altaria.','',7 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','d1','text','Diferenciador 1','Ubicación en Galerías Business Square','Located in Galerias Business Square','',8 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='d1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','d1_icon','text','Diferenciador 1 - icono','pin','','',9 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='d1_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','d2','text','Diferenciador 2','Estacionamiento','Parking','',10 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='d2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','d2_icon','text','Diferenciador 2 - icono','key','','',11 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='d2_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','d3','text','Diferenciador 3','Junto a C.C. Galerías y cerca de Altaria','Next to Galerias mall, close to Altaria','',12 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='d3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'porque','d3_icon','text','Diferenciador 3 - icono','box','','',13 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='porque' AND b.`skey`='d3_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','title','text','Titulo','Espacios disponibles en Aldea Galerías','Spaces available at Aldea Galerías','',14 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p1_title','text','Espacio 1 - titulo','Oficina Privada','Private Office','',15 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p1_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p1_valor','text','Espacio 1 - valor en el formulario','Oficina Privada','Private Office','',16 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p1_valor');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p1_text','richtext','Espacio 1 - descripcion','Espacio cerrado, amueblado y exclusivo para ti o tu equipo.','An enclosed, furnished space just for you or your team.','',17 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p1_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p1_img','image','Espacio 1 - foto','/img/oficina-privada/op-2.webp','','',18 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p1_img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p1_periodo','text','Espacio 1 - periodo del precio','+ IVA / mes','+ VAT / mo','',19 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p1_periodo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p1_meta','text','Espacio 1 - capacidad','Desde 2 personas','From 2 people','',20 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p1_meta');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p2_title','text','Espacio 2 - titulo','Coworking','Coworking','',21 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p2_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p2_valor','text','Espacio 2 - valor en el formulario','Coworking','Coworking','',22 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p2_valor');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p2_text','richtext','Espacio 2 - descripcion','Trabaja desde nuestras áreas compartidas sin necesidad de tener un escritorio fijo.','Work from our shared areas with no need for a fixed desk.','',23 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p2_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p2_img','image','Espacio 2 - foto','/img/wp/2025/05/IMG_0093.webp','','',24 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p2_img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p2_periodo','text','Espacio 2 - periodo del precio','+ IVA / mes','+ VAT / mo','',25 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p2_periodo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p3_title','text','Espacio 3 - titulo','Escritorio Privado','Private Desk','',26 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p3_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p3_valor','text','Espacio 3 - valor en el formulario','Escritorio Privado','Private Desk','',27 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p3_valor');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p3_text','richtext','Espacio 3 - descripcion','Tu escritorio fijo y exclusivo dentro de una zona de trabajo compartida.','Your own fixed desk inside a shared working area.','',28 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p3_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p3_img','image','Espacio 3 - foto','/img/wp/2025/07/7-4.webp','','',29 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p3_img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p3_periodo','text','Espacio 3 - periodo del precio','+ IVA / mes','+ VAT / mo','',30 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p3_periodo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p4_title','text','Espacio 4 - titulo','Domicilio Virtual','Virtual Address','',31 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p4_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p4_valor','text','Espacio 4 - valor en el formulario','Domicilio Virtual','Virtual Address','',32 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p4_valor');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p4_text','richtext','Espacio 4 - descripcion','Dirección fiscal y comercial para tu empresa sin necesidad de rentar una oficina física.','A registered and commercial address for your company without renting a physical office.','',33 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p4_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p4_img','image','Espacio 4 - foto','/img/sol-virtual.webp','','',34 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p4_img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p4_periodo','text','Espacio 4 - periodo del precio','+ IVA','+ VAT','',35 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p4_periodo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','p4_nota','text','Espacio 4 - aclaracion','Domicilio Virtual cuenta con servicios diferentes a nuestras membresías de espacios de trabajo.','','',36 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='p4_nota');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'espacios','nota','text','Nota general','Precios y disponibilidad sujetos a cambio.','Prices and availability subject to change.','',37 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='espacios' AND b.`skey`='nota');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','title','text','Titulo','Todo incluido para que solo te ocupes de trabajar','All included so you only have to work','',38 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s1','text','Servicio 1','Internet empresarial','Business internet','',39 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s1_icon','text','Servicio 1 - icono','wifi','','',40 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s1_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s2','text','Servicio 2','Mobiliario','Furniture','',41 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s2_icon','text','Servicio 2 - icono','furniture','','',42 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s2_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s3','text','Servicio 3','Salas de juntas','Meeting rooms','',43 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s3_icon','text','Servicio 3 - icono','users','','',44 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s3_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s4','text','Servicio 4','Recepción','Reception','',45 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s4_icon','text','Servicio 4 - icono','pin','','',46 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s4_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s5','text','Servicio 5','Limpieza','Cleaning','',47 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s5_icon','text','Servicio 5 - icono','sparkle','','',48 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s5_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s6','text','Servicio 6','Seguridad','Security','',49 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s6_icon','text','Servicio 6 - icono','shield','','',50 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s6_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s7','text','Servicio 7','Áreas comunes','Common areas','',51 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s7');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s7_icon','text','Servicio 7 - icono','heart','','',52 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s7_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s8','text','Servicio 8','Café y bebidas','Coffee and drinks','',53 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s8');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s8_icon','text','Servicio 8 - icono','coffee','','',54 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s8_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s9','text','Servicio 9','Cocina','Kitchen','',55 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s9');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s9_icon','text','Servicio 9 - icono','star','','',56 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s9_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s10','text','Servicio 10','Paquetería','Parcel handling','',57 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s10');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s10_icon','text','Servicio 10 - icono','box','','',58 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s10_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s11','text','Servicio 11','Impresiones','Printing','',59 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s11');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s11_icon','text','Servicio 11 - icono','printer','','',60 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s11_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s12','text','Servicio 12','Soporte en sitio','On-site support','',61 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s12');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'servicios','s12_icon','text','Servicio 12 - icono','support','','',62 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='servicios' AND b.`skey`='s12_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','title','text','Titulo','Infraestructura que respalda tu operación','Infrastructure that backs your operation','',63 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t1_icon','text','Bloque 1 - icono','wifi','','',64 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t1_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t1_title','text','Bloque 1 - titulo','Conectividad','Connectivity','',65 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t1_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t1_text','richtext','Bloque 1 - texto','Internet empresarial e infraestructura para mantener conectado a tu equipo durante su operación diaria.','Business internet and infrastructure to keep your team connected through the working day.','',66 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t1_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t2_icon','text','Bloque 2 - icono','shield','','',67 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t2_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t2_title','text','Bloque 2 - titulo','Seguridad','Security','',68 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t2_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t2_text','richtext','Bloque 2 - texto','Control de acceso e instalaciones administradas para ofrecer un entorno de trabajo seguro.','Access control and managed facilities for a secure working environment.','',69 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t2_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t3_icon','text','Bloque 3 - icono','support','','',70 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t3_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t3_title','text','Bloque 3 - titulo','Soporte en sitio','On-site support','',71 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t3_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'tech','t3_text','richtext','Bloque 3 - texto','Equipo Aldea disponible para apoyar con las necesidades relacionadas con tu espacio y operación.','The Aldea team is on hand for anything related to your space and operation.','',72 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='tech' AND b.`skey`='t3_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'mapa','title','text','Titulo','Una ubicación estratégica en Aguascalientes','A strategic location in Aguascalientes','',73 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='mapa' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'form','title','text','Titulo','Encuentra tu espacio en Aldea Galerías','Find your space at Aldea Galerías','',74 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='form' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'form','lead','richtext','Texto','Déjanos tus datos y nuestro equipo comercial te ayudará a encontrar las opciones disponibles para ti o tu empresa.','Leave your details and our sales team will help you find the options available for you or your company.','',75 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='form' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'form','boton','text','Texto del boton','Solicitar cotización','Request a quote','',76 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='form' AND b.`skey`='boton');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'visita','title','text','Titulo del modal','Agenda tu visita','Book a visit','',77 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='visita' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'visita','lead','richtext','Texto del modal','Elige el día y horario que mejor te acomode y te esperamos en Aldea Galerías.','Pick the day and time that suit you best and we will see you at Aldea Galerías.','',78 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='visita' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'visita','boton','text','Texto del boton','Agendar visita','Book visit','',79 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='visita' AND b.`skey`='boton');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','title','text','Titulo','Preguntas frecuentes','Frequently asked questions','',80 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q1','text','Pregunta 1','¿Dónde está Aldea Galerías?','','',81 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a1','richtext','Respuesta 1','Aldea Galerías se encuentra en Av. Independencia #1861, Ed. 5, Galerías Business Square, C.P. 20120, Aguascalientes, Ags.','','',82 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q2','text','Pregunta 2','¿Qué espacios puedo contratar?','','',83 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a2','richtext','Respuesta 2','Contamos con Oficina Privada, Coworking, Escritorio Privado y Domicilio Virtual, sujetos a disponibilidad.','','',84 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q3','text','Pregunta 3','¿Las oficinas vienen amuebladas?','','',85 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a3','richtext','Respuesta 3','Sí. Las Oficinas Privadas se entregan con mobiliario para que puedas empezar a trabajar desde el primer día.','','',86 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q4','text','Pregunta 4','¿Cuál es el plazo mínimo de contratación?','','',87 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a4','richtext','Respuesta 4','Las membresías de espacios de trabajo pueden contratarse desde 1 mes, con opciones de mayor plazo según la solución y disponibilidad.','','',88 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q5','text','Pregunta 5','¿Puedo utilizar salas de juntas?','','',89 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a5','richtext','Respuesta 5','Sí. El acceso depende de las condiciones y créditos incluidos en la membresía contratada.','','',90 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q6','text','Pregunta 6','¿Aldea Galerías cuenta con estacionamiento?','','',91 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a6','richtext','Respuesta 6','Sí. La sede cuenta con estacionamiento en Galerías Business Square. [PENDIENTE: confirmar las condiciones finales de estacionamiento.]','','',92 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','q7','text','Pregunta 7','¿Puedo recibir clientes y visitantes?','','',93 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='q7');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @lp,'faq','a7','richtext','Respuesta 7','Sí. Aldea cuenta con recepción y espacios para atender visitantes de acuerdo con las políticas de acceso de la sede.','','',94 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@lp AND b.`section`='faq' AND b.`skey`='a7');
UPDATE `locations` SET `nearby`='{"Hospedaje": [["Hilton Garden Inn", ""], ["Wyndham Garden", ""]], "Restaurantes": [["Mochomos", ""], ["Los Arcos", ""], ["Carajillo", ""]], "Zona": [["Galerías Business Square", ""], ["C.C. Galerías", ""], ["C.C. Altaria", ""]]}' WHERE `slug`='oficinas-en-renta-aguascalientes';

-- ---------------------------------------------------------------------
-- PENDIENTES QUE NECESITAN DATO DEL CLIENTE (aplican a las 4 sedes)
-- ---------------------------------------------------------------------
-- 1) Precio de Escritorio Privado: price_desk vacio en las 4. La tarjeta
--    muestra 'Precio a consultar' hasta que se cargue.
--    UPDATE `locations` SET `price_desk`='0,000' WHERE `slug`='oficinas-en-renta-queretaro';
--    UPDATE `locations` SET `price_desk`='0,000' WHERE `slug`='oficinas-en-renta-leon-guanajuato';
--    UPDATE `locations` SET `price_desk`='0,000' WHERE `slug`='oficinas-en-renta-san-luis-potosi';
--    UPDATE `locations` SET `price_desk`='0,000' WHERE `slug`='oficinas-en-renta-aguascalientes';
-- 2) Video de cada sede: sin video_url el mosaico solo muestra fotos.
-- 3) Estacionamiento: las respuestas del FAQ traen [PENDIENTE].
-- 4) Testimonios por sede: seccion omitida por falta de material.
--    Se activa creando testi.q1 / testi.n1 / testi.e1 en cada pagina.
