-- =====================================================================
-- ALDEA — Oficina Privada segun el brief del cliente (2026)
-- El contenido vive en una pagina oculta 'sol:oficina-privada' y se
-- edita desde /admin/paginas.php como cualquier otra pagina.
-- =====================================================================

SET NAMES utf8mb4;

INSERT INTO `pages` (`slug`,`type`,`title_es`,`title_en`,`published`)
  VALUES ('sol:oficina-privada','simple','Oficina Privada (contenido)','Private Office (content)',0)
  ON DUPLICATE KEY UPDATE `title_es`=VALUES(`title_es`);

SET @sp := (SELECT `id` FROM `pages` WHERE `slug`='sol:oficina-privada' LIMIT 1);

INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','h1','text','Titulo','Oficina Privada','Private Office','',0 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='h1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','lead','richtext','Texto principal','Tu propia oficina, completamente amueblada y lista para trabajar.','Your own office, fully furnished and ready to work in.','',1 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','lead2','richtext','Texto secundario','Para equipos de 1 a 100 personas, con internet, servicios y acceso a las áreas comunes de Aldea.','For teams of 1 to 100 people, with internet, services and access to Aldea''s common areas.','',2 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='lead2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','bullet1','text','Punto 1','Espacio cerrado y exclusivo','Private, enclosed space','',3 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='bullet1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','bullet2','text','Punto 2','Mobiliario incluido','Furniture included','',4 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='bullet2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','bullet3','text','Punto 3','Lista para trabajar desde el primer día','Ready to work from day one','',5 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='bullet3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','cta1','button','Boton principal','Cotizar Oficina Privada','Get a quote','#formulario',6 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='cta1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','cta2','button','Boton secundario','Conoce qué incluye','See what''s included','#incluye',7 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='cta2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'empresas','title','text','Titulo de la franja de logos','Empresas que trabajan desde Aldea','Companies working from Aldea','',8 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='empresas' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','chip','eyebrow','Etiqueta (opcional)','','','',9 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='chip');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','title','text','Titulo','Un espacio exclusivamente para tu equipo','A space exclusively for your team','',10 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','text','richtext','Texto','Tu oficina es un espacio cerrado y de uso exclusivo para ti y tu equipo. Lo que compartes son los servicios y áreas comunes de Aldea, como recepción, salas de juntas, cocina y espacios compartidos.','Your office is an enclosed space for you and your team only. What you share are Aldea''s services and common areas: reception, meeting rooms, kitchen and shared spaces.','',11 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','img','image','Fotografia','/img/sol-privada.webp','','',12 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','img_alt','text','Texto alternativo de la foto','Oficina privada en Aldea','Private office at Aldea','',13 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='img_alt');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','priv_title','text','Bloque privado - titulo','Privado','Private','',14 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='priv_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','priv_text','text','Bloque privado - texto','Tu oficina y estaciones de trabajo.','Your office and workstations.','',15 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='priv_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','shared_title','text','Bloque compartido - titulo','Compartido','Shared','',16 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='shared_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','shared_text','text','Bloque compartido - texto','Recepción, salas de juntas, cocina y áreas comunes.','Reception, meeting rooms, kitchen and common areas.','',17 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='shared_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','title','text','Titulo','Lista para trabajar desde el primer día','Ready to work from day one','',18 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','text','richtext','Texto','Olvídate de montar y operar una oficina desde cero. En Aldea ya tienes resueltos los principales servicios que necesita tu equipo.','Forget about setting up and running an office from scratch. At Aldea the main services your team needs are already solved.','',19 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','item1','text','Punto 1','Sin comprar mobiliario','No buying furniture','',20 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='item1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','item2','text','Punto 2','Sin contratar internet por separado','No separate internet contract','',21 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='item2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','item3','text','Punto 3','Sin administrar limpieza','No cleaning to manage','',22 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='item3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','item4','text','Punto 4','Sin montar una recepción','No reception to set up','',23 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='item4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','item5','text','Punto 5','Sin coordinar múltiples proveedores','No juggling multiple suppliers','',24 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='item5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','cierre','text','Frase de cierre','Tú operas tu empresa. Nosotros nos encargamos de tu oficina.','You run your business. We take care of your office.','',25 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='cierre');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','title','text','Titulo','¿Qué incluye tu Oficina Privada?','What''s included in your Private Office?','',26 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own_title','text','Columna 1 - titulo','Tu Oficina Privada','Your Private Office','',27 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own1','text','Incluye 1','Espacio cerrado de uso exclusivo','Enclosed, exclusive space','',28 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own2','text','Incluye 2','Escritorios y sillas','Desks and chairs','',29 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own3','text','Incluye 3','Mobiliario','Furniture','',30 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own4','text','Incluye 4','Internet','Internet','',31 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own5','text','Incluye 5','Limpieza','Cleaning','',32 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own6','text','Incluye 6','Acceso controlado','Controlled access','',33 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own7','text','Incluye 7','Identificación de tu empresa en puerta y directorio','Your company''s name on the door and in the directory','',34 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own7');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','sh_title','text','Columna 2 - titulo','Además tienes acceso a Aldea','You also get access to Aldea','',35 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='sh_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','sh1','text','Acceso 1','Recepción','Reception','',36 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='sh1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','sh2','text','Acceso 2','Salas de juntas','Meeting rooms','',37 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='sh2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','sh3','text','Acceso 3','Áreas comunes','Common areas','',38 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='sh3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','sh4','text','Acceso 4','Cocina','Kitchen','',39 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='sh4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','sh5','text','Acceso 5','Café y bebidas','Coffee and drinks','',40 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='sh5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','sh6','text','Acceso 6','Recepción de paquetería','Parcel handling','',41 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='sh6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','sh7','text','Acceso 7','Impresiones','Printing','',42 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='sh7');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','sh8','text','Acceso 8','Soporte del equipo Aldea','Support from the Aldea team','',43 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='sh8');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','nota','text','Nota al pie','Los servicios incluidos pueden variar según la sede y condiciones de la membresía.','Included services may vary by location and membership terms.','',44 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='nota');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','title','text','Titulo','Tu nueva oficina en tres pasos','Your new office in three steps','',45 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','s1_title','text','Paso 1 - titulo','Elige tu sede','Choose your location','',46 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='s1_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','s1_text','text','Paso 1 - texto','Conoce las opciones disponibles en tu ciudad.','See what is available in your city.','',47 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='s1_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','s2_title','text','Paso 2 - titulo','Encuentra tu oficina','Find your office','',48 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='s2_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','s2_text','text','Paso 2 - texto','Seleccionamos contigo el espacio adecuado para tu equipo.','We help you pick the right space for your team.','',49 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='s2_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','s3_title','text','Paso 3 - titulo','Empieza a trabajar','Start working','',50 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='s3_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','s3_text','text','Paso 3 - texto','Instala a tu equipo y nosotros nos encargamos del resto.','Move your team in and we handle the rest.','',51 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='s3_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'flex','title','text','Titulo','Una oficina que se adapta a tu empresa','An office that adapts to your company','',52 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='flex' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'flex','text','richtext','Texto principal','Contratos desde 1 mes, con opciones de mayor plazo según las necesidades de tu empresa.','Terms from 1 month, with longer options depending on what your company needs.','',53 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='flex' AND b.`skey`='text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'flex','text2','richtext','Texto secundario','Si tu equipo crece, podemos revisar alternativas de mayor capacidad dentro de Aldea según disponibilidad.','If your team grows, we can look at larger options within Aldea, subject to availability.','',54 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='flex' AND b.`skey`='text2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'flex','f1','text','Apoyo 1','Diferentes capacidades de oficina','Different office capacities','',55 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='flex' AND b.`skey`='f1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'flex','f2','text','Apoyo 2','Contratos desde 1 mes','Terms from 1 month','',56 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='flex' AND b.`skey`='f2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'flex','f3','text','Apoyo 3','Opciones de mayor plazo','Longer-term options','',57 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='flex' AND b.`skey`='f3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'flex','f4','text','Apoyo 4','Posibilidad de crecimiento dentro de Aldea','Room to grow within Aldea','',58 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='flex' AND b.`skey`='f4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'tech','title','text','Titulo','Infraestructura que respalda tu operación','Infrastructure that backs your operation','',59 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='tech' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'tech','t1_icon','text','Bloque 1 - icono','wifi','','',60 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='tech' AND b.`skey`='t1_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'tech','t1_title','text','Bloque 1 - titulo','Conectividad','Connectivity','',61 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='tech' AND b.`skey`='t1_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'tech','t1_text','richtext','Bloque 1 - texto','Internet empresarial para mantener conectado a tu equipo durante su operación diaria.','Business internet to keep your team connected through the working day.','',62 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='tech' AND b.`skey`='t1_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'tech','t2_icon','text','Bloque 2 - icono','shield','','',63 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='tech' AND b.`skey`='t2_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'tech','t2_title','text','Bloque 2 - titulo','Seguridad','Security','',64 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='tech' AND b.`skey`='t2_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'tech','t2_text','richtext','Bloque 2 - texto','Control de acceso e instalaciones administradas para mantener un entorno de trabajo seguro.','Access control and managed facilities to keep the workplace secure.','',65 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='tech' AND b.`skey`='t2_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'tech','t3_icon','text','Bloque 3 - icono','support','','',66 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='tech' AND b.`skey`='t3_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'tech','t3_title','text','Bloque 3 - titulo','Soporte en sitio','On-site support','',67 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='tech' AND b.`skey`='t3_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'tech','t3_text','richtext','Bloque 3 - texto','Equipo Aldea disponible para atender necesidades relacionadas con tu espacio y operación.','The Aldea team is on hand for anything related to your space and operation.','',68 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='tech' AND b.`skey`='t3_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'galeria','title','text','Titulo','Conoce nuestras Oficinas Privadas','See our Private Offices','',69 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='galeria' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'galeria','lead','richtext','Subtexto','Espacios reales de Aldea para equipos de diferentes tamaños.','Real Aldea spaces for teams of every size.','',70 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='galeria' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'ubicaciones','title','text','Titulo','Encuentra tu Oficina Privada','Find your Private Office','',71 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='ubicaciones' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'ubicaciones','lead','richtext','Texto','Selecciona tu ciudad y conoce los espacios disponibles en cada sede.','Pick your city and see what is available at each location.','',72 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='ubicaciones' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'ubicaciones','cta','text','Etiqueta del enlace de cada tarjeta','Ver oficinas','See offices','',73 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='ubicaciones' AND b.`skey`='cta');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'form','title','text','Titulo','Encuentra la Oficina Privada para tu equipo','Find the Private Office for your team','',74 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='form' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'form','lead','richtext','Texto','Déjanos tus datos y nuestro equipo comercial te ayudará a encontrar las opciones disponibles que mejor se adapten a tus necesidades.','Leave your details and our sales team will help you find the options that best fit your needs.','',75 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='form' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'form','boton','text','Texto del boton','Cotizar Oficina Privada','Get a quote','',76 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='form' AND b.`skey`='boton');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','title','text','Titulo','Preguntas frecuentes','Frequently asked questions','',77 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q1','text','Pregunta 1','¿Qué diferencia hay entre Oficina Privada, Escritorio Privado y Coworking?','','',78 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a1','richtext','Respuesta 1','La Oficina Privada es un espacio cerrado y exclusivo para tu equipo. El Escritorio Privado es un lugar fijo dentro de un área compartida y Coworking permite utilizar los espacios de trabajo compartidos disponibles.','','',79 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q2','text','Pregunta 2','¿La oficina viene amueblada?','','',80 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a2','richtext','Respuesta 2','Sí. Las Oficinas Privadas se entregan con mobiliario para que puedas empezar a trabajar desde el primer día.','','',81 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q3','text','Pregunta 3','¿Qué servicios están incluidos?','','',82 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a3','richtext','Respuesta 3','Incluyen servicios como internet, mobiliario, limpieza y acceso a diferentes servicios y áreas comunes de Aldea. Los beneficios específicos pueden variar según sede y membresía.','','',83 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q4','text','Pregunta 4','¿Cuál es el plazo mínimo de contratación?','','',84 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a4','richtext','Respuesta 4','Las Oficinas Privadas pueden contratarse desde 1 mes, con opciones de mayor plazo según la sede, disponibilidad y necesidades de tu empresa.','','',85 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q5','text','Pregunta 5','¿Puedo cambiarme a una oficina más grande si crece mi equipo?','','',86 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a5','richtext','Respuesta 5','Sí, podemos revisar alternativas de mayor capacidad dentro de Aldea dependiendo de la disponibilidad de cada sede.','','',87 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q6','text','Pregunta 6','¿Puedo utilizar las salas de juntas?','','',88 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a6','richtext','Respuesta 6','Sí. Los miembros de Oficina Privada pueden acceder a salas de juntas de acuerdo con las condiciones y créditos incluidos en su membresía.','','',89 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q7','text','Pregunta 7','¿La empresa puede aparecer identificada en la oficina?','','',90 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q7');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a7','richtext','Respuesta 7','Sí. Incluimos identificación de tu empresa en la puerta de la oficina y directorios correspondientes.','','',91 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a7');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q8','text','Pregunta 8','¿Cuánto cuesta una Oficina Privada?','','',92 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q8');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a8','richtext','Respuesta 8','El precio depende de la ciudad, capacidad, oficina disponible y condiciones de contratación. Selecciona tu sede o solicita una cotización para conocer las opciones disponibles.','','',93 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a8');

-- El titulo y el resumen de la tarjeta del listado se mantienen alineados
UPDATE `solutions` SET
  `seo_title_es`='Oficina Privada en renta | Aldea Networking',
  `seo_desc_es`='Tu propia oficina amueblada y lista para trabajar, para equipos de 1 a 100 personas. Internet, servicios y areas comunes incluidos en Queretaro, Leon, San Luis Potosi y Aguascalientes.'
  WHERE `slug`='oficina-privada';

-- ---------------------------------------------------------------------
-- PENDIENTE: la galeria de la seccion 9 sale del campo 'Galeria' de la
-- solucion (/admin/soluciones.php). Hoy apunta a imagenes alojadas en el
-- WordPress viejo (aldea.work/wp-content/...). Hay que subirlas al sitio
-- nuevo antes del cambio de dominio o se romperan.
-- ---------------------------------------------------------------------
