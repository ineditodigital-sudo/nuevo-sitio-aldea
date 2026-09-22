-- =====================================================================
-- ALDEA — Domicilio Virtual segun el brief del cliente (2026)
-- Sin seccion de tecnologia: el brief no la contempla.
-- =====================================================================

SET NAMES utf8mb4;

INSERT INTO `pages` (`slug`,`type`,`title_es`,`title_en`,`published`)
  VALUES ('sol:domicilio-virtual','simple','Domicilio Virtual (contenido)','Virtual Address (content)',0)
  ON DUPLICATE KEY UPDATE `title_es`=VALUES(`title_es`);

SET @sp := (SELECT `id` FROM `pages` WHERE `slug`='sol:domicilio-virtual' LIMIT 1);

INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','h1','text','Titulo','Domicilio Virtual','Virtual Address','',0 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='h1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','lead','richtext','Texto principal','Una dirección profesional para tu empresa, sin necesidad de rentar una oficina física.','A professional address for your company, without renting a physical office.','',1 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','lead2','richtext','Texto secundario','Utiliza una dirección de Aldea como domicilio fiscal y comercial, recibe correspondencia y accede a salas de juntas cuando necesites reunirte.','Use an Aldea address as your registered and commercial address, receive mail and book meeting rooms whenever you need them.','',2 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='lead2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','bullet1','text','Punto 1','Domicilio fiscal y comercial','Registered and commercial address','',3 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='bullet1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','bullet2','text','Punto 2','Recepción de correspondencia y paquetería','Mail and parcel handling','',4 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='bullet2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','bullet3','text','Punto 3','Acceso a salas de juntas','Access to meeting rooms','',5 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='bullet3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','cta1','button','Boton principal','Cotizar Domicilio Virtual','Get a quote','#formulario',6 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='cta1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','cta2','button','Boton secundario','Conoce qué incluye','See what''s included','#incluye',7 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='cta2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'empresas','title','text','Titulo de la franja de logos','Empresas que confían en Aldea','Companies that trust Aldea','',8 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='empresas' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','chip','eyebrow','Etiqueta (opcional)','','','',9 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='chip');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','title','text','Titulo','Presencia profesional sin una oficina física','A professional presence without a physical office','',10 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','text','richtext','Texto','Domicilio Virtual te permite utilizar una dirección de Aldea para establecer la presencia fiscal y comercial de tu empresa sin contratar una oficina permanente. Nuestro equipo recibe tu correspondencia y paquetería, y puedes utilizar salas de juntas cuando necesites reunirte de forma presencial.','A Virtual Address lets you use an Aldea address for your company''s registered and commercial presence without taking a permanent office. Our team receives your mail and parcels, and you can book meeting rooms whenever you need to meet in person.','',11 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','img','image','Fotografia','/img/sol-virtual.webp','','',12 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','img_alt','text','Texto alternativo de la foto','Recepción e instalaciones de Aldea','Aldea reception and facilities','',13 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='img_alt');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','priv_title','text','Columna 1 - titulo','Tienes','You get','',14 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='priv_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','p1','text','Tienes 1','Dirección fiscal y comercial','A registered and commercial address','',15 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='p1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','p2','text','Tienes 2','Recepción de correspondencia','Mail handling','',16 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='p2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','p3','text','Tienes 3','Acceso a servicios para reuniones','Access to meeting services','',17 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='p3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','shared_title','text','Columna 2 - titulo','No necesitas','You don''t need','',18 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='shared_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','shared_estilo','text','Columna 2 en negativo (si / no)','no','no','',19 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='shared_estilo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','s1','text','No necesitas 1','Rentar una oficina permanente','To rent a permanent office','',20 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='s1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','s2','text','No necesitas 2','Mantener un espacio físico sin utilizar','To keep an unused physical space','',21 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='s2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','s3','text','No necesitas 3','Operar una recepción propia','To run your own reception','',22 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='s3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','title','text','Titulo','Una solución para empresas que no necesitan una oficina todos los días','A solution for companies that don''t need an office every day','',23 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','text','richtext','Texto','Ideal para quienes trabajan de forma remota o no requieren un espacio permanente, pero necesitan una dirección formal y servicios profesionales para su empresa.','A good fit if you work remotely or don''t need a permanent space, but do need a formal address and professional services for your company.','',24 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','estilo','text','Estilo de la lista: no (tachas) / si (palomitas)','si','si','',25 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='estilo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','item1','text','Punto 1','Profesionales independientes','Independent professionals','',26 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='item1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','item2','text','Punto 2','Empresas que trabajan de forma remota','Companies working remotely','',27 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='item2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','item3','text','Punto 3','Nuevas empresas','New companies','',28 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='item3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','item4','text','Punto 4','Empresas que abren presencia en otra ciudad','Companies opening up in another city','',29 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='item4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','item5','text','Punto 5','Negocios que requieren domicilio fiscal y comercial','Businesses that need a registered and commercial address','',30 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='item5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','title','text','Titulo','¿Qué incluye tu membresía?','What''s included in your membership?','',31 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own_title','text','Titulo de la lista','Incluye','Includes','',32 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own1','text','Incluye 1','Domicilio fiscal','Registered address','',33 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own2','text','Incluye 2','Domicilio comercial','Commercial address','',34 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own3','text','Incluye 3','Recepción de correspondencia','Mail handling','',35 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own4','text','Incluye 4','Recepción de paquetería','Parcel handling','',36 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own5','text','Incluye 5','Aviso cuando recibimos documentos o entregas','A notice whenever we receive documents or deliveries','',37 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own6','text','Incluye 6','Identificación de empresa en directorio, cuando corresponda','Your company listed in the directory, where applicable','',38 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own7','text','Incluye 7','Acceso a salas de juntas de acuerdo con las condiciones de la membresía','Meeting room access according to your membership terms','',39 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own7');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own8','text','Incluye 8','Atención del equipo Aldea','Support from the Aldea team','',40 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own8');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','nota','text','Nota al pie','Los servicios incluidos pueden variar según la sede y condiciones de la membresía.','Included services may vary by location and membership terms.','',41 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='nota');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','title','text','Titulo','Activa tu Domicilio Virtual en tres pasos','Activate your Virtual Address in three steps','',42 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','s1_title','text','Paso 1 - titulo','Elige tu sede','Choose your location','',43 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='s1_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','s1_text','text','Paso 1 - texto','Selecciona la ciudad y dirección que mejor funcionen para tu empresa.','Pick the city and address that work best for your company.','',44 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='s1_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','s2_title','text','Paso 2 - titulo','Completa tu contratación','Complete your sign-up','',45 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='s2_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','s2_text','text','Paso 2 - texto','Nuestro equipo te indicará la documentación necesaria para activar el servicio.','Our team will tell you which documents are needed to activate the service.','',46 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='s2_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','s3_title','text','Paso 3 - titulo','Empieza a utilizar tu dirección','Start using your address','',47 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='s3_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','s3_text','text','Paso 3 - texto','Una vez activado, podrás utilizar el domicilio contratado y comenzar a recibir correspondencia y paquetería.','Once it is active you can use the address and start receiving mail and parcels.','',48 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='s3_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'flex','title','text','Titulo','Una dirección estable para tu empresa','A stable address for your company','',49 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='flex' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'flex','text','richtext','Texto principal','Contratación mínima de 12 meses.','Minimum term of 12 months.','',50 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='flex' AND b.`skey`='text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'flex','text2','richtext','Texto secundario','Mantén una dirección profesional estable para tu empresa sin necesidad de contratar una oficina física permanente.','Keep a stable professional address for your company without taking a permanent physical office.','',51 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='flex' AND b.`skey`='text2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'galeria','title','text','Titulo','Conoce los espacios detrás de tu Domicilio Virtual','See the spaces behind your Virtual Address','',52 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='galeria' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'galeria','lead','richtext','Subtexto','Recepción, salas de juntas e instalaciones reales de Aldea disponibles para apoyar a tu empresa.','Real Aldea reception areas, meeting rooms and facilities available to support your company.','',53 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='galeria' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'ubicaciones','title','text','Titulo','Elige la dirección para tu empresa','Choose your company''s address','',54 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='ubicaciones' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'ubicaciones','lead','richtext','Texto','Selecciona la ciudad donde necesitas establecer tu presencia fiscal y comercial.','Pick the city where you need to establish your registered and commercial presence.','',55 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='ubicaciones' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'ubicaciones','cta','text','Etiqueta del enlace de cada tarjeta','Ver sede','See location','',56 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='ubicaciones' AND b.`skey`='cta');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'form','title','text','Titulo','Cotiza tu Domicilio Virtual','Get a quote for your Virtual Address','',57 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='form' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'form','lead','richtext','Texto','Déjanos tus datos y nuestro equipo te ayudará a conocer las opciones disponibles en la ciudad que necesitas.','Leave your details and our team will help you see the options available in the city you need.','',58 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='form' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'form','boton','text','Texto del boton','Cotizar Domicilio Virtual','Get a quote','',59 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='form' AND b.`skey`='boton');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'form','personas','text','¿Mostrar el campo Numero de personas? (si / no)','no','no','',60 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='form' AND b.`skey`='personas');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','title','text','Titulo','Preguntas frecuentes','Frequently asked questions','',61 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q1','text','Pregunta 1','¿Puedo utilizar la dirección de Aldea como domicilio fiscal?','','',62 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a1','richtext','Respuesta 1','Sí. El Domicilio Virtual permite utilizar la dirección contratada como domicilio fiscal de acuerdo con las condiciones y documentación correspondiente.','','',63 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q2','text','Pregunta 2','¿También puedo utilizarla como domicilio comercial?','','',64 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a2','richtext','Respuesta 2','Sí. Puedes utilizarla como dirección comercial para dar presencia profesional a tu empresa.','','',65 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q3','text','Pregunta 3','¿Tengo una oficina física incluida?','','',66 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a3','richtext','Respuesta 3','No. Domicilio Virtual no incluye una Oficina Privada ni un espacio de trabajo permanente.','','',67 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q4','text','Pregunta 4','¿Qué pasa cuando recibo correspondencia o paquetería?','','',68 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a4','richtext','Respuesta 4','Nuestro equipo la recibe y te notifica para que puedas recogerla de acuerdo con las políticas de la sede.','','',69 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q5','text','Pregunta 5','¿Puedo utilizar salas de juntas?','','',70 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a5','richtext','Respuesta 5','Sí. La membresía contempla acceso a salas de juntas de acuerdo con las horas, créditos o condiciones contratadas.','','',71 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q6','text','Pregunta 6','¿Cuál es el plazo mínimo de contratación?','','',72 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a6','richtext','Respuesta 6','El plazo mínimo de Domicilio Virtual es de 12 meses.','','',73 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q7','text','Pregunta 7','¿Puedo trabajar desde las áreas de Coworking?','','',74 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q7');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a7','richtext','Respuesta 7','El uso permanente de Coworking no forma parte del Domicilio Virtual. Si necesitas un espacio recurrente para trabajar, podemos recomendarte una membresía de Coworking o Escritorio Privado.','','',75 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a7');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q8','text','Pregunta 8','¿Cuánto cuesta un Domicilio Virtual?','','',76 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q8');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a8','richtext','Respuesta 8','El precio depende de la sede y condiciones de contratación. Selecciona tu ciudad o solicita una cotización para conocer las opciones disponibles.','','',77 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a8');

-- Hero: recepcion con presencia profesional.
-- Galeria: recepcion, fachada, acceso y salas de juntas. El brief pide
-- NO usar fotos de Oficinas Privadas como protagonista, porque harian
-- pensar que el producto incluye una oficina fisica.
UPDATE `solutions` SET
  `hero_image`='/img/loc-slp.webp',
  `hero_image_alt`='Recepcion de Aldea',
  `gallery`='["/img/wp/2025/05/Sala-de-juntas-4.webp","/img/wp/2026/02/Fachada-Aldea-Centro-Sur-2.webp","/img/wp/2025/05/IMG_9553.webp","/img/sol-virtual.webp","/img/loc-qro.webp"]',
  `seo_title_es`='Domicilio Virtual y domicilio fiscal | Aldea Networking',
  `seo_desc_es`='Domicilio fiscal y comercial para tu empresa con recepcion de correspondencia y acceso a salas de juntas en Queretaro, Leon, San Luis Potosi y Aguascalientes.'
  WHERE `slug`='domicilio-virtual';
