-- =====================================================================
-- ALDEA — Oficinas Corporativas a la Medida (brief del cliente 2026)
-- Pagina nueva en /oficinas-corporativas/ con plantilla propia.
-- La URL vieja /oficinas-personalizadas/ se redirige con 301 porque
-- esta en el sitemap del sitio publicado y tiene valor SEO.
-- =====================================================================

SET NAMES utf8mb4;

-- Campos nuevos del formulario corporativo.
-- Si marca 'Duplicate column name', ya estaba aplicado.
ALTER TABLE `leads`
  ADD COLUMN `role`        VARCHAR(160) NULL AFTER `company`,
  ADD COLUMN `target_date` VARCHAR(20)  NULL AFTER `visit_time`;

INSERT INTO `pages` (`slug`,`type`,`title_es`,`title_en`,`seo_title_es`,`seo_desc_es`,`published`)
  VALUES ('oficinas-corporativas','simple','Oficinas Corporativas','Corporate Offices',
    'Oficinas Corporativas a la Medida | Aldea Networking',
    'Disenamos, construimos, equipamos y operamos oficinas corporativas para equipos de mas de 100 personas. Inmueble, adecuaciones, mobiliario, tecnologia y servicios en una sola renta mensual.',1)
  ON DUPLICATE KEY UPDATE `title_es`=VALUES(`title_es`), `published`=1;

SET @cp := (SELECT `id` FROM `pages` WHERE `slug`='oficinas-corporativas' LIMIT 1);

INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'page','plantilla','text','Plantilla de la pagina (no cambiar)','corporativas','corporativas','',0 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='page' AND b.`skey`='plantilla');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'hero','chip','eyebrow','Etiqueta','PARA EQUIPOS DE +100 PERSONAS','FOR TEAMS OF +100 PEOPLE','',1 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='hero' AND b.`skey`='chip');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'hero','title','text','Titulo','Oficinas Corporativas a la Medida','Tailor-made Corporate Offices','',2 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='hero' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'hero','lead','richtext','Texto principal','Diseñamos, construimos, equipamos y operamos oficinas desarrolladas alrededor de las necesidades de tu empresa.','We design, build, equip and operate offices developed around your company''s needs.','',3 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='hero' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'hero','lead2','richtext','Texto secundario','Desde la búsqueda del inmueble hasta la operación diaria del espacio, Aldea coordina todo el proyecto bajo una sola solución.','From finding the property to running the space day to day, Aldea coordinates the whole project under a single solution.','',4 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='hero' AND b.`skey`='lead2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'hero','plazo','text','Nota de plazo','Proyectos a partir de 36 meses.','Projects from 36 months.','',5 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='hero' AND b.`skey`='plazo');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'hero','cta1','button','Boton principal','Cuéntanos tu proyecto','Tell us about your project','#formulario',6 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='hero' AND b.`skey`='cta1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'hero','cta2','button','Boton secundario','Conoce cómo trabajamos','See how we work','#proceso',7 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='hero' AND b.`skey`='cta2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'hero','img','image','Fotografia del hero','/img/oficina-privada/op-1.webp','','',8 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='hero' AND b.`skey`='img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'hero','img_alt','text','Texto alternativo de la foto','Oficina corporativa desarrollada por Aldea','Corporate office developed by Aldea','',9 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='hero' AND b.`skey`='img_alt');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'empresas','title','text','Titulo de la franja de logos','Empresas que confían en Aldea','Companies that trust Aldea','',10 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='empresas' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'operacion','title','text','Titulo','Tu empresa no tiene que adaptarse a una oficina existente','Your company shouldn''t have to fit into an existing office','',11 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='operacion' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'operacion','text','richtext','Texto','Diseñamos cada proyecto a partir de cómo opera tu empresa: número de colaboradores, distribución, espacios especiales, infraestructura, tecnología, seguridad, estacionamiento y servicios.','We design every project around how your company works: headcount, layout, special-purpose areas, infrastructure, technology, security, parking and services.','',12 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='operacion' AND b.`skey`='text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'operacion','img','image','Fotografia o plano','/img/oficina-privada/op-1.webp','','',13 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='operacion' AND b.`skey`='img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'operacion','img_alt','text','Texto alternativo','Proyecto corporativo de Aldea','Aldea corporate project','',14 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='operacion' AND b.`skey`='img_alt');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'operacion','e1_title','text','Eje 1 - titulo','Ubicación','Location','',15 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='operacion' AND b.`skey`='e1_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'operacion','e1_icon','text','Eje 1 - icono','pin','','',16 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='operacion' AND b.`skey`='e1_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'operacion','e1_text','text','Eje 1 - texto','Encontramos el inmueble adecuado para tu operación.','We find the right property for your operation.','',17 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='operacion' AND b.`skey`='e1_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'operacion','e2_title','text','Eje 2 - titulo','Distribución','Layout','',18 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='operacion' AND b.`skey`='e2_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'operacion','e2_icon','text','Eje 2 - icono','building','','',19 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='operacion' AND b.`skey`='e2_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'operacion','e2_text','text','Eje 2 - texto','Diseñamos los espacios alrededor de tus equipos y necesidades.','We design the spaces around your teams and needs.','',20 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='operacion' AND b.`skey`='e2_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'operacion','e3_title','text','Eje 3 - titulo','Arquitectura y mobiliario','Architecture and furniture','',21 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='operacion' AND b.`skey`='e3_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'operacion','e3_icon','text','Eje 3 - icono','furniture','','',22 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='operacion' AND b.`skey`='e3_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'operacion','e3_text','text','Eje 3 - texto','Desarrollamos una oficina funcional y alineada con tu empresa.','We build a functional office aligned with your company.','',23 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='operacion' AND b.`skey`='e3_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'operacion','e4_title','text','Eje 4 - titulo','Tecnología','Technology','',24 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='operacion' AND b.`skey`='e4_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'operacion','e4_icon','text','Eje 4 - icono','wifi','','',25 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='operacion' AND b.`skey`='e4_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'operacion','e4_text','text','Eje 4 - texto','Integramos la infraestructura requerida para tu operación.','We integrate the infrastructure your operation requires.','',26 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='operacion' AND b.`skey`='e4_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'operacion','e5_title','text','Eje 5 - titulo','Servicios','Services','',27 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='operacion' AND b.`skey`='e5_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'operacion','e5_icon','text','Eje 5 - icono','support','','',28 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='operacion' AND b.`skey`='e5_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'operacion','e5_text','text','Eje 5 - texto','Definimos y administramos los servicios necesarios para el día a día.','We define and run the services the day to day requires.','',29 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='operacion' AND b.`skey`='e5_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'equipo','title','text','Titulo','Un solo equipo para todo el proyecto','One team for the entire project','',30 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='equipo' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'equipo','text','richtext','Texto','En lugar de coordinar diferentes proveedores para cada etapa, Aldea centraliza el desarrollo y operación de tu oficina.','Instead of coordinating a different supplier for each stage, Aldea centralises the development and running of your office.','',31 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='equipo' AND b.`skey`='text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'equipo','i1','text','Alcance 1','Búsqueda del inmueble','Property search','',32 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='equipo' AND b.`skey`='i1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'equipo','i2','text','Alcance 2','Arquitectura y proyecto','Architecture and design','',33 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='equipo' AND b.`skey`='i2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'equipo','i3','text','Alcance 3','Adecuaciones y construcción','Fit-out and construction','',34 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='equipo' AND b.`skey`='i3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'equipo','i4','text','Alcance 4','Mobiliario','Furniture','',35 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='equipo' AND b.`skey`='i4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'equipo','i5','text','Alcance 5','Tecnología e infraestructura','Technology and infrastructure','',36 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='equipo' AND b.`skey`='i5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'equipo','i6','text','Alcance 6','Seguridad y control de acceso','Security and access control','',37 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='equipo' AND b.`skey`='i6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'equipo','i7','text','Alcance 7','Servicios operativos','Operational services','',38 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='equipo' AND b.`skey`='i7');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'equipo','i8','text','Alcance 8','Administración del espacio','Space management','',39 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='equipo' AND b.`skey`='i8');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'equipo','cierre','text','Cierre destacado','Un solo punto de contacto durante todo el proyecto.','A single point of contact throughout the project.','',40 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='equipo' AND b.`skey`='cierre');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'proceso','title','text','Titulo','De la necesidad a una oficina lista para operar','From a requirement to an office ready to run','',41 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='proceso' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'proceso','s1_title','text','Etapa 1 - titulo','Entendemos tu operación','We map your operation','',42 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='proceso' AND b.`skey`='s1_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'proceso','s1_text','richtext','Etapa 1 - texto','Analizamos número de personas, espacios, ubicación, infraestructura, tecnología y servicios requeridos.','We review headcount, spaces, location, infrastructure, technology and the services required.','',43 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='proceso' AND b.`skey`='s1_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'proceso','s2_title','text','Etapa 2 - titulo','Encontramos el inmueble','We find the property','',44 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='proceso' AND b.`skey`='s2_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'proceso','s2_text','richtext','Etapa 2 - texto','Buscamos y evaluamos espacios que cumplan con las necesidades del proyecto.','We search and assess spaces that meet the project''s needs.','',45 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='proceso' AND b.`skey`='s2_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'proceso','s3_title','text','Etapa 3 - titulo','Diseñamos y cotizamos','We design and quote','',46 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='proceso' AND b.`skey`='s3_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'proceso','s3_text','richtext','Etapa 3 - texto','Desarrollamos distribución, alcance, servicios y propuesta económica.','We develop the layout, scope, services and commercial proposal.','',47 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='proceso' AND b.`skey`='s3_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'proceso','s4_title','text','Etapa 4 - titulo','Construimos y equipamos','We build and equip','',48 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='proceso' AND b.`skey`='s4_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'proceso','s4_text','richtext','Etapa 4 - texto','Coordinamos adecuaciones, mobiliario, infraestructura y tecnología.','We coordinate fit-out, furniture, infrastructure and technology.','',49 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='proceso' AND b.`skey`='s4_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'proceso','s5_title','text','Etapa 5 - titulo','Entregamos y operamos','We hand over and operate','',50 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='proceso' AND b.`skey`='s5_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'proceso','s5_text','richtext','Etapa 5 - texto','Tu equipo entra a trabajar y Aldea administra los servicios definidos para la operación.','Your team moves in and Aldea runs the services defined for the operation.','',51 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='proceso' AND b.`skey`='s5_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'renta','title','text','Titulo','Todo el proyecto integrado en una sola renta','The whole project inside a single monthly rent','',52 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='renta' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'renta','text','richtext','Texto','En lugar de contratar y administrar por separado el inmueble, adecuaciones, mobiliario, infraestructura y servicios, Aldea integra el proyecto dentro de una sola estructura contractual y una renta mensual.','Instead of contracting and managing the property, fit-out, furniture, infrastructure and services separately, Aldea brings the project into a single contract and one monthly rent.','',53 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='renta' AND b.`skey`='text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'renta','f1','text','Pieza 1','Uso del inmueble','Use of the property','',54 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='renta' AND b.`skey`='f1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'renta','f2','text','Pieza 2','Proyecto y adecuaciones','Design and fit-out','',55 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='renta' AND b.`skey`='f2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'renta','f3','text','Pieza 3','Mobiliario','Furniture','',56 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='renta' AND b.`skey`='f3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'renta','f4','text','Pieza 4','Infraestructura y tecnología','Infrastructure and technology','',57 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='renta' AND b.`skey`='f4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'renta','f5','text','Pieza 5','Servicios y operación','Services and operation','',58 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='renta' AND b.`skey`='f5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'renta','resultado','text','Resultado de la formula','Una sola renta mensual','One monthly rent','',59 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='renta' AND b.`skey`='resultado');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'renta','b1','text','Beneficio 1','Menor inversión inicial','Lower upfront investment','',60 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='renta' AND b.`skey`='b1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'renta','b2','text','Beneficio 2','Costos más previsibles','More predictable costs','',61 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='renta' AND b.`skey`='b2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'renta','b3','text','Beneficio 3','Menos proveedores que administrar','Fewer suppliers to manage','',62 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='renta' AND b.`skey`='b3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'renta','b4','text','Beneficio 4','Una sola solución contractual','A single contractual solution','',63 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='renta' AND b.`skey`='b4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'renta','b5','text','Beneficio 5','Operación centralizada con Aldea','Operations centralised with Aldea','',64 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='renta' AND b.`skey`='b5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'servicios','title','text','Titulo','Tu operación define los servicios','Your operation defines the services','',65 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='servicios' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'servicios','text','richtext','Texto','Cada empresa tiene necesidades diferentes. Definimos contigo qué servicios requiere el proyecto y los integramos a la solución.','Every company is different. We define with you which services the project needs and fold them into the solution.','',66 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='servicios' AND b.`skey`='text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'servicios','s1','text','Servicio 1','Internet y conectividad','Internet and connectivity','',67 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='servicios' AND b.`skey`='s1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'servicios','s2','text','Servicio 2','Recepción','Reception','',68 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='servicios' AND b.`skey`='s2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'servicios','s3','text','Servicio 3','Limpieza','Cleaning','',69 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='servicios' AND b.`skey`='s3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'servicios','s4','text','Servicio 4','Seguridad','Security','',70 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='servicios' AND b.`skey`='s4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'servicios','s5','text','Servicio 5','Control de acceso','Access control','',71 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='servicios' AND b.`skey`='s5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'servicios','s6','text','Servicio 6','CCTV','CCTV','',72 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='servicios' AND b.`skey`='s6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'servicios','s7','text','Servicio 7','Mantenimiento','Maintenance','',73 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='servicios' AND b.`skey`='s7');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'servicios','s8','text','Servicio 8','Soporte IT','IT support','',74 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='servicios' AND b.`skey`='s8');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'servicios','s9','text','Servicio 9','Impresión','Printing','',75 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='servicios' AND b.`skey`='s9');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'servicios','s10','text','Servicio 10','Salas de juntas','Meeting rooms','',76 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='servicios' AND b.`skey`='s10');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'servicios','s11','text','Servicio 11','Estacionamiento','Parking','',77 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='servicios' AND b.`skey`='s11');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'servicios','s12','text','Servicio 12','Comedor y áreas comunes','Canteen and common areas','',78 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='servicios' AND b.`skey`='s12');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'servicios','s13','text','Servicio 13','Otros servicios requeridos por el proyecto','Other services the project requires','',79 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='servicios' AND b.`skey`='s13');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'tech','title','text','Titulo','Infraestructura diseñada para los estándares de tu empresa','Infrastructure built to your company''s standards','',80 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='tech' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'tech','text','richtext','Texto','Cada proyecto se desarrolla de acuerdo con los requerimientos tecnológicos, de seguridad y continuidad de la operación.','Every project is developed according to the technology, security and business-continuity requirements.','',81 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='tech' AND b.`skey`='text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'tech','t1_icon','text','Bloque 1 - icono','wifi','','',82 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='tech' AND b.`skey`='t1_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'tech','t1_title','text','Bloque 1 - titulo','Red y conectividad','Network and connectivity','',83 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='tech' AND b.`skey`='t1_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'tech','t1_text','richtext','Bloque 1 - texto','Internet, redundancia, red cableada, WiFi y arquitectura de conectividad según requerimientos.','Internet, redundancy, wired network, WiFi and connectivity architecture as required.','',84 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='tech' AND b.`skey`='t1_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'tech','t2_icon','text','Bloque 2 - icono','box','','',85 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='tech' AND b.`skey`='t2_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'tech','t2_title','text','Bloque 2 - titulo','Site e infraestructura IT','Server room and IT infrastructure','',86 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='tech' AND b.`skey`='t2_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'tech','t2_text','richtext','Bloque 2 - texto','Racks, UPS, cableado y equipamiento requerido para soportar la operación.','Racks, UPS, cabling and the equipment needed to support the operation.','',87 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='tech' AND b.`skey`='t2_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'tech','t3_icon','text','Bloque 3 - icono','shield','','',88 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='tech' AND b.`skey`='t3_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'tech','t3_title','text','Bloque 3 - titulo','Seguridad y accesos','Security and access','',89 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='tech' AND b.`skey`='t3_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'tech','t3_text','richtext','Bloque 3 - texto','CCTV, control de acceso y soluciones de seguridad definidas junto con tu equipo.','CCTV, access control and security solutions defined together with your team.','',90 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='tech' AND b.`skey`='t3_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'tech','t4_icon','text','Bloque 4 - icono','support','','',91 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='tech' AND b.`skey`='t4_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'tech','t4_title','text','Bloque 4 - titulo','Soporte y operación','Support and operation','',92 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='tech' AND b.`skey`='t4_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'tech','t4_text','richtext','Bloque 4 - texto','Acompañamiento técnico durante la implementación y operación del espacio.','Technical support during implementation and while the space is running.','',93 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='tech' AND b.`skey`='t4_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'tech','nota','text','Nota al pie','Cada proyecto se desarrolla de manera diferente, por lo que el alcance técnico se define caso por caso.','Every project is different, so the technical scope is defined case by case.','',94 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='tech' AND b.`skey`='nota');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'proyecto','title','text','Titulo','Del proyecto al espacio terminado','From project to finished space','',95 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='proyecto' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'proyecto','text','richtext','Texto','Cada oficina comienza entendiendo la operación y termina con un espacio listo para recibir al equipo.','Every office starts by understanding the operation and ends with a space ready to receive the team.','',96 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='proyecto' AND b.`skey`='text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'proyecto','e1','text','Etapa 1 - nombre','Requerimientos','Requirements','',97 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='proyecto' AND b.`skey`='e1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'proyecto','e1_img','image','Etapa 1 - imagen (material real del proyecto)','','','',98 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='proyecto' AND b.`skey`='e1_img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'proyecto','e2','text','Etapa 2 - nombre','Zonificación','Zoning','',99 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='proyecto' AND b.`skey`='e2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'proyecto','e2_img','image','Etapa 2 - imagen (material real del proyecto)','','','',100 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='proyecto' AND b.`skey`='e2_img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'proyecto','e3','text','Etapa 3 - nombre','Render','Render','',101 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='proyecto' AND b.`skey`='e3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'proyecto','e3_img','image','Etapa 3 - imagen (material real del proyecto)','','','',102 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='proyecto' AND b.`skey`='e3_img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'proyecto','e4','text','Etapa 4 - nombre','Construcción','Construction','',103 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='proyecto' AND b.`skey`='e4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'proyecto','e4_img','image','Etapa 4 - imagen (material real del proyecto)','','','',104 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='proyecto' AND b.`skey`='e4_img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'proyecto','e5','text','Etapa 5 - nombre','Equipamiento','Fit-out','',105 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='proyecto' AND b.`skey`='e5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'proyecto','e5_img','image','Etapa 5 - imagen (material real del proyecto)','','','',106 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='proyecto' AND b.`skey`='e5_img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'proyecto','e6','text','Etapa 6 - nombre','Resultado final','Finished space','',107 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='proyecto' AND b.`skey`='e6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'proyecto','e6_img','image','Etapa 6 - imagen (material real del proyecto)','','','',108 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='proyecto' AND b.`skey`='e6_img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'form','title','text','Titulo','Cuéntanos tu proyecto','Tell us about your project','',109 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='form' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'form','text','richtext','Texto','Compártenos los datos principales de tu operación y nuestro equipo corporativo se pondrá en contacto contigo para conocer el proyecto a detalle.','Share the main details of your operation and our corporate team will get in touch to go through the project.','',110 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='form' AND b.`skey`='text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'form','boton','text','Texto del boton','Hablar con nuestro equipo corporativo','Talk to our corporate team','',111 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='form' AND b.`skey`='boton');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'faq','title','text','Titulo','Preguntas frecuentes','Frequently asked questions','',112 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='faq' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'faq','q1','text','Pregunta 1','¿Para qué tamaño de empresa está diseñada esta solución?','','',113 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='faq' AND b.`skey`='q1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'faq','a1','richtext','Respuesta 1','Oficinas Corporativas está enfocada en proyectos para equipos de más de 100 personas.','','',114 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='faq' AND b.`skey`='a1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'faq','q2','text','Pregunta 2','¿Cuál es el plazo mínimo?','','',115 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='faq' AND b.`skey`='q2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'faq','a2','richtext','Respuesta 2','Los proyectos se desarrollan a partir de contratos de 36 meses, dependiendo del alcance y características de la operación.','','',116 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='faq' AND b.`skey`='a2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'faq','q3','text','Pregunta 3','¿El proyecto tiene que estar dentro de una sede Aldea?','','',117 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='faq' AND b.`skey`='q3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'faq','a3','richtext','Respuesta 3','No. Podemos buscar y evaluar un inmueble específicamente para las necesidades del proyecto.','','',118 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='faq' AND b.`skey`='a3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'faq','q4','text','Pregunta 4','¿Aldea puede ayudar a encontrar el inmueble?','','',119 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='faq' AND b.`skey`='q4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'faq','a4','richtext','Respuesta 4','Sí. La búsqueda y evaluación del inmueble puede formar parte del desarrollo integral del proyecto.','','',120 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='faq' AND b.`skey`='a4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'faq','q5','text','Pregunta 5','¿Qué incluye una Oficina Corporativa a la Medida?','','',121 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='faq' AND b.`skey`='q5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'faq','a5','richtext','Respuesta 5','El alcance puede integrar inmueble, arquitectura, adecuaciones, mobiliario, infraestructura, tecnología y servicios operativos según las necesidades definidas con el cliente.','','',122 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='faq' AND b.`skey`='a5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'faq','q6','text','Pregunta 6','¿Qué puedo personalizar?','','',123 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='faq' AND b.`skey`='q6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'faq','a6','richtext','Respuesta 6','La distribución, arquitectura, mobiliario, infraestructura, tecnología, identidad y servicios pueden desarrollarse de acuerdo con los requerimientos del proyecto.','','',124 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='faq' AND b.`skey`='a6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'faq','q7','text','Pregunta 7','¿Qué servicios puede operar Aldea?','','',125 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='faq' AND b.`skey`='q7');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'faq','a7','richtext','Respuesta 7','Podemos integrar servicios como recepción, limpieza, mantenimiento, tecnología, seguridad, control de acceso, estacionamiento y otros requerimientos definidos para la operación.','','',126 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='faq' AND b.`skey`='a7');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'faq','q8','text','Pregunta 8','¿Cuánto tarda un proyecto?','','',127 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='faq' AND b.`skey`='q8');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'faq','a8','richtext','Respuesta 8','El tiempo depende del inmueble, superficie, alcance y adecuaciones necesarias. Después del diagnóstico desarrollamos un cronograma específico para cada proyecto.','','',128 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='faq' AND b.`skey`='a8');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'faq','q9','text','Pregunta 9','¿Cómo se estructura el costo?','','',129 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='faq' AND b.`skey`='q9');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @cp,'faq','a9','richtext','Respuesta 9','El proyecto puede integrar el uso del inmueble, adecuaciones, mobiliario, infraestructura y servicios dentro de una sola renta mensual durante el plazo contratado.','','',130 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@cp AND b.`section`='faq' AND b.`skey`='a9');

-- La URL vieja pasa a redirigir a la nueva (301)
INSERT INTO `redirects` (`from_path`,`to_path`,`code`) VALUES ('/oficinas-personalizadas/','/oficinas-corporativas/',301)
  ON DUPLICATE KEY UPDATE `to_path`=VALUES(`to_path`), `code`=301;

-- El menu, el footer y el bloque del Home apuntan aqui mediante corp_url
INSERT INTO `settings` (`skey`,`value`) VALUES ('corp_url','/oficinas-corporativas/')
  ON DUPLICATE KEY UPDATE `value`=VALUES(`value`);
UPDATE `menu_items` SET `href`='/oficinas-corporativas/' WHERE `label_es`='Oficinas Corporativas';

-- ---------------------------------------------------------------------
-- PENDIENTE: material real de proyectos corporativos
-- ---------------------------------------------------------------------
-- La seccion 'Del proyecto al espacio terminado' tiene 6 etapas con su
-- campo de imagen vacio: hoy se ven como marcadores numerados. En cuanto
-- RH o el equipo de proyectos suba planos, renders y fotos de obra desde
-- /admin/pagina.php, la secuencia se completa sola.
-- Lo mismo con la foto del hero y la de la seccion 'operacion', que hoy
-- usan una oficina privada existente en lugar de un proyecto corporativo.
