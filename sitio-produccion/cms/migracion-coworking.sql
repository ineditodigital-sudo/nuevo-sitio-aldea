-- =====================================================================
-- ALDEA — Coworking segun el brief del cliente (2026)
-- El contenido vive en la pagina oculta 'sol:coworking' y se edita
-- desde /admin/paginas.php como cualquier otra pagina.
-- =====================================================================

SET NAMES utf8mb4;

INSERT INTO `pages` (`slug`,`type`,`title_es`,`title_en`,`published`)
  VALUES ('sol:coworking','simple','Coworking (contenido)','Coworking (content)',0)
  ON DUPLICATE KEY UPDATE `title_es`=VALUES(`title_es`);

SET @sp := (SELECT `id` FROM `pages` WHERE `slug`='sol:coworking' LIMIT 1);

INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','h1','text','Titulo','Coworking','Coworking','',0 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='h1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','lead','richtext','Texto principal','Un espacio profesional para trabajar con flexibilidad, sin necesidad de tener un escritorio fijo.','A professional space to work flexibly, with no need for a fixed desk.','',1 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','lead2','richtext','Texto secundario','Elige un lugar disponible dentro de nuestras áreas compartidas y disfruta de internet, salas de juntas, servicios y espacios comunes de Aldea.','Pick an available spot in our shared areas and enjoy Aldea''s internet, meeting rooms, services and common spaces.','',2 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='lead2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','bullet1','text','Punto 1','Acceso a espacios de trabajo compartidos','Access to shared workspaces','',3 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='bullet1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','bullet2','text','Punto 2','Sin escritorio fijo','No fixed desk','',4 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='bullet2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','bullet3','text','Punto 3','Todo listo para llegar y trabajar','Everything ready so you just show up and work','',5 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='bullet3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','cta1','button','Boton principal','Cotizar Coworking','Get a quote','#formulario',6 FROM DUAL WHERE NOT EXISTS
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
  SELECT @sp,'quees','title','text','Titulo','Trabaja desde nuestros espacios compartidos','Work from our shared spaces','',10 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','text','richtext','Texto','Coworking te permite utilizar las áreas de trabajo compartidas de Aldea sin tener un escritorio asignado. Llegas, eliges un lugar disponible y empiezas a trabajar con acceso a la infraestructura y servicios de la sede.','Coworking lets you use Aldea''s shared work areas without an assigned desk. You arrive, pick an available spot and start working with access to the location''s infrastructure and services.','',11 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','img','image','Fotografia','/img/wp/2025/07/10-2.webp','','',12 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','img_alt','text','Texto alternativo de la foto','Área de coworking de Aldea','Aldea coworking area','',13 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='img_alt');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','priv_title','text','Bloque 1 - titulo','Tu espacio de trabajo','Your workspace','',14 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='priv_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','priv_text','text','Bloque 1 - texto','Eliges un lugar disponible dentro del área Coworking.','You pick an available spot in the coworking area.','',15 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='priv_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','shared_title','text','Bloque 2 - titulo','Espacios compartidos','Shared spaces','',16 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='shared_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','shared_text','text','Bloque 2 - texto','Salas de juntas, cocina, recepción y áreas comunes.','Meeting rooms, kitchen, reception and common areas.','',17 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='shared_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','destacado','link','Mensaje destacado (enlace a otra solucion)','Si prefieres tener siempre el mismo lugar, nuestro Escritorio Privado puede ser una mejor opción.','If you would rather always have the same spot, our Private Desk may suit you better.','/escritorio-privado/',18 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='destacado');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','title','text','Titulo','Todo lo que necesitas para trabajar, sin montar una oficina','Everything you need to work, without setting up an office','',19 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','text','richtext','Texto','Cambia trabajar desde casa o buscar una cafetería por un espacio profesional con la infraestructura necesaria para tu día a día.','Swap working from home or hunting for a cafe for a professional space with the infrastructure your day needs.','',20 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','item1','text','Punto 1','Internet listo para trabajar','Internet ready to work','',21 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='item1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','item2','text','Punto 2','Mobiliario y espacios adecuados','Proper furniture and spaces','',22 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='item2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','item3','text','Punto 3','Salas para recibir clientes o tener reuniones','Rooms for clients and meetings','',23 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='item3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','item4','text','Punto 4','Recepción y equipo Aldea en sitio','Reception and the Aldea team on site','',24 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='item4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','item5','text','Punto 5','Áreas para trabajar, reunirte o tomar un descanso','Areas to work, meet or take a break','',25 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='item5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','cierre','text','Frase de cierre','Tú trae tu computadora. Nosotros nos encargamos del espacio.','You bring your laptop. We take care of the space.','',26 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='cierre');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','title','text','Titulo','¿Qué incluye tu membresía?','What''s included in your membership?','',27 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own_title','text','Columna 1 - titulo','Para trabajar','To work','',28 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own1','text','Incluye 1','Acceso a áreas Coworking','Access to coworking areas','',29 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own2','text','Incluye 2','Internet','Internet','',30 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own3','text','Incluye 3','Mobiliario','Furniture','',31 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own4','text','Incluye 4','Áreas comunes','Common areas','',32 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own5','text','Incluye 5','Cocina','Kitchen','',33 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','sh_title','text','Columna 2 - titulo','Servicios Aldea','Aldea services','',34 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='sh_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','sh1','text','Servicio 1','Recepción','Reception','',35 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='sh1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','sh2','text','Servicio 2','Salas de juntas','Meeting rooms','',36 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='sh2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','sh3','text','Servicio 3','Café y bebidas','Coffee and drinks','',37 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='sh3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','sh4','text','Servicio 4','Impresiones','Printing','',38 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='sh4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','sh5','text','Servicio 5','Seguridad','Security','',39 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='sh5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','sh6','text','Servicio 6','Soporte del equipo Aldea','Support from the Aldea team','',40 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='sh6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','nota','text','Nota al pie','Los servicios y beneficios incluidos pueden variar según la sede y condiciones de la membresía.','Included services and benefits may vary by location and membership terms.','',41 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='nota');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','title','text','Titulo','Empieza a trabajar en tres pasos','Start working in three steps','',42 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','s1_title','text','Paso 1 - titulo','Elige tu sede','Choose your location','',43 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='s1_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','s1_text','text','Paso 1 - texto','Selecciona la ubicación de Aldea que mejor te funcione.','Pick the Aldea location that works best for you.','',44 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='s1_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','s2_title','text','Paso 2 - titulo','Contrata tu membresía','Sign up for your membership','',45 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='s2_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','s2_text','text','Paso 2 - texto','Nuestro equipo te ayudará a activar la opción adecuada para ti.','Our team will help you activate the right option.','',46 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='s2_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','s3_title','text','Paso 3 - titulo','Llega y trabaja','Show up and work','',47 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='s3_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','s3_text','text','Paso 3 - texto','Elige un lugar disponible, conéctate y empieza tu día.','Pick an available spot, connect and start your day.','',48 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='s3_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'flex','title','text','Titulo','Flexibilidad para tu forma de trabajar','Flexibility for the way you work','',49 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='flex' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'flex','text','richtext','Texto principal','Membresías desde 1 mes, sin necesidad de contratar una oficina completa.','Memberships from 1 month, with no need to take a whole office.','',50 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='flex' AND b.`skey`='text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'flex','text2','richtext','Texto secundario','Ideal si necesitas un espacio profesional de manera recurrente, pero no requieres un escritorio fijo ni una oficina exclusiva.','A good fit if you need a professional space regularly but not a fixed desk or a private office.','',51 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='flex' AND b.`skey`='text2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'flex','f1','text','Apoyo 1','Contratos desde 1 mes','Terms from 1 month','',52 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='flex' AND b.`skey`='f1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'flex','f2','text','Apoyo 2','Sin escritorio asignado','No assigned desk','',53 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='flex' AND b.`skey`='f2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'flex','f3','text','Apoyo 3','Acceso recurrente a tu sede','Regular access to your location','',54 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='flex' AND b.`skey`='f3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'flex','f4','text','Apoyo 4','Posibilidad de cambiar a Escritorio Privado u Oficina Privada conforme cambien tus necesidades','Option to move to a Private Desk or Private Office as your needs change','',55 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='flex' AND b.`skey`='f4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'tech','title','text','Titulo','Infraestructura para trabajar con tranquilidad','Infrastructure so you can work with peace of mind','',56 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='tech' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'tech','t1_icon','text','Bloque 1 - icono','wifi','','',57 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='tech' AND b.`skey`='t1_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'tech','t1_title','text','Bloque 1 - titulo','Conectividad','Connectivity','',58 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='tech' AND b.`skey`='t1_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'tech','t1_text','richtext','Bloque 1 - texto','Internet empresarial para trabajar, realizar videollamadas y mantenerte conectado durante tu jornada.','Business internet to work, take video calls and stay connected all day.','',59 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='tech' AND b.`skey`='t1_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'tech','t2_icon','text','Bloque 2 - icono','shield','','',60 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='tech' AND b.`skey`='t2_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'tech','t2_title','text','Bloque 2 - titulo','Seguridad','Security','',61 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='tech' AND b.`skey`='t2_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'tech','t2_text','richtext','Bloque 2 - texto','Accesos controlados e instalaciones administradas por Aldea.','Controlled access and facilities managed by Aldea.','',62 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='tech' AND b.`skey`='t2_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'tech','t3_icon','text','Bloque 3 - icono','support','','',63 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='tech' AND b.`skey`='t3_icon');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'tech','t3_title','text','Bloque 3 - titulo','Soporte en sitio','On-site support','',64 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='tech' AND b.`skey`='t3_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'tech','t3_text','richtext','Bloque 3 - texto','Equipo Aldea disponible para ayudarte con las necesidades relacionadas con tu espacio de trabajo.','The Aldea team is on hand for anything related to your workspace.','',65 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='tech' AND b.`skey`='t3_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'galeria','title','text','Titulo','Conoce nuestros espacios de Coworking','See our coworking spaces','',66 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='galeria' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'galeria','lead','richtext','Subtexto','Áreas reales de Aldea diseñadas para trabajar de forma cómoda y profesional.','Real Aldea areas designed for comfortable, professional work.','',67 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='galeria' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'ubicaciones','title','text','Titulo','Encuentra tu Coworking','Find your coworking space','',68 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='ubicaciones' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'ubicaciones','lead','richtext','Texto','Selecciona tu ciudad y conoce la sede de Aldea más cercana.','Pick your city and find your nearest Aldea location.','',69 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='ubicaciones' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'ubicaciones','cta','text','Etiqueta del enlace de cada tarjeta','Ver sede','See location','',70 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='ubicaciones' AND b.`skey`='cta');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'form','title','text','Titulo','Encuentra tu espacio de Coworking','Find your coworking space','',71 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='form' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'form','lead','richtext','Texto','Déjanos tus datos y nuestro equipo te ayudará a conocer la membresía y sede que mejor se adapten a lo que necesitas.','Leave your details and our team will help you find the membership and location that fit you best.','',72 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='form' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'form','boton','text','Texto del boton','Cotizar Coworking','Get a quote','',73 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='form' AND b.`skey`='boton');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'form','personas','text','¿Mostrar el campo Numero de personas? (si / no)','no','no','',74 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='form' AND b.`skey`='personas');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','title','text','Titulo','Preguntas frecuentes','Frequently asked questions','',75 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q1','text','Pregunta 1','¿Tengo un escritorio asignado?','','',76 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a1','richtext','Respuesta 1','No. Con Coworking puedes elegir un lugar disponible dentro de las áreas compartidas cada vez que trabajes desde Aldea.','','',77 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q2','text','Pregunta 2','¿Cuál es la diferencia entre Coworking y Escritorio Privado?','','',78 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a2','richtext','Respuesta 2','Coworking te permite trabajar desde los lugares disponibles en un área compartida. Con Escritorio Privado tienes una estación de trabajo fija y exclusiva para ti.','','',79 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q3','text','Pregunta 3','¿Cuál es la diferencia entre Coworking y Oficina Privada?','','',80 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a3','richtext','Respuesta 3','Coworking utiliza áreas de trabajo compartidas. Una Oficina Privada es un espacio cerrado y exclusivo para ti o tu equipo.','','',81 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q4','text','Pregunta 4','¿Cuál es el plazo mínimo?','','',82 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a4','richtext','Respuesta 4','Las membresías de Coworking pueden contratarse desde 1 mes.','','',83 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q5','text','Pregunta 5','¿Puedo utilizar las salas de juntas?','','',84 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a5','richtext','Respuesta 5','Sí. Las membresías incluyen acceso a salas de juntas de acuerdo con las condiciones y créditos correspondientes a la membresía contratada.','','',85 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q6','text','Pregunta 6','¿Qué servicios están incluidos?','','',86 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a6','richtext','Respuesta 6','Tienes acceso a internet, mobiliario, áreas comunes y diferentes servicios Aldea. Los beneficios específicos pueden variar según sede y membresía.','','',87 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q7','text','Pregunta 7','¿Puedo recibir visitas?','','',88 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q7');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a7','richtext','Respuesta 7','Sí, puedes recibir visitas de acuerdo con las políticas de acceso de cada sede. Para reuniones privadas recomendamos utilizar las salas de juntas.','','',89 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a7');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q8','text','Pregunta 8','¿Cuánto cuesta Coworking?','','',90 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q8');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a8','richtext','Respuesta 8','El precio depende de la sede y condiciones de contratación. Selecciona tu ciudad o solicita una cotización para conocer la membresía disponible.','','',91 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a8');

-- El hero pide una foto real del area de coworking con personas trabajando
UPDATE `solutions` SET
  `hero_image`='/img/wp/2025/05/IMG_0093.webp',
  `hero_image_alt`='Personas trabajando en el area de coworking de Aldea',
  `seo_title_es`='Coworking en renta | Aldea Networking',
  `seo_desc_es`='Espacios de coworking con internet, salas de juntas y servicios incluidos en Queretaro, Leon, San Luis Potosi y Aguascalientes. Membresias desde 1 mes.'
  WHERE `slug`='coworking';
