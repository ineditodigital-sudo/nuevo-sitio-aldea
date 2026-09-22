-- =====================================================================
-- ALDEA — Escritorio Privado segun el brief del cliente (2026)
-- El contenido vive en la pagina oculta 'sol:escritorio-privado'.
-- =====================================================================

SET NAMES utf8mb4;

INSERT INTO `pages` (`slug`,`type`,`title_es`,`title_en`,`published`)
  VALUES ('sol:escritorio-privado','simple','Escritorio Privado (contenido)','Private Desk (content)',0)
  ON DUPLICATE KEY UPDATE `title_es`=VALUES(`title_es`);

SET @sp := (SELECT `id` FROM `pages` WHERE `slug`='sol:escritorio-privado' LIMIT 1);

INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','h1','text','Titulo','Escritorio Privado','Private Desk','',0 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='h1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','lead','richtext','Texto principal','Tu propio escritorio, fijo y exclusivo para ti.','Your own desk, fixed and exclusively yours.','',1 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','lead2','richtext','Texto secundario','Trabaja siempre desde el mismo lugar dentro de nuestras áreas compartidas, con mobiliario, internet y servicios de Aldea incluidos.','Work from the same spot every day inside our shared areas, with furniture, internet and Aldea services included.','',2 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='lead2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','bullet1','text','Punto 1','Escritorio fijo y exclusivo','A fixed, exclusive desk','',3 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='bullet1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','bullet2','text','Punto 2','Dentro de una zona de trabajo compartida','Inside a shared work area','',4 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='bullet2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','bullet3','text','Punto 3','Listo para trabajar todos los días','Ready to work every day','',5 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='hero' AND b.`skey`='bullet3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'hero','cta1','button','Boton principal','Cotizar Escritorio Privado','Get a quote','#formulario',6 FROM DUAL WHERE NOT EXISTS
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
  SELECT @sp,'quees','title','text','Titulo','Tu lugar de trabajo, siempre reservado para ti','Your workspace, always saved for you','',10 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','text','richtext','Texto','Con Escritorio Privado tienes una estación de trabajo fija y de uso exclusivo dentro de una zona compartida de Aldea. A diferencia de Coworking, no necesitas elegir un lugar disponible cada vez que llegas: tu escritorio siempre es el mismo.','With a Private Desk you get a fixed, exclusive workstation inside a shared Aldea area. Unlike Coworking, you don''t pick an available spot each time you arrive: your desk is always the same one.','',11 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','img','image','Fotografia','/img/wp/2025/07/3-4.webp','','',12 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='img');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','img_alt','text','Texto alternativo de la foto','Escritorio privado dentro de la zona compartida de Aldea','Private desk inside Aldea''s shared area','',13 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='img_alt');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','priv_title','text','Bloque 1 - titulo','Exclusivo','Exclusive','',14 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='priv_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','priv_text','text','Bloque 1 - texto','Tu escritorio y estación de trabajo están asignados únicamente para ti.','Your desk and workstation are assigned to you alone.','',15 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='priv_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','shared_title','text','Bloque 2 - titulo','Compartido','Shared','',16 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='shared_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','shared_text','text','Bloque 2 - texto','La zona donde se encuentra tu escritorio, recepción, salas de juntas, cocina y áreas comunes.','The area where your desk sits, plus reception, meeting rooms, kitchen and common areas.','',17 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='shared_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'quees','destacado','link','Mensaje destacado (enlace a otra solucion)','Si necesitas privacidad para todo tu espacio de trabajo, conoce nuestras Oficinas Privadas.','If you need privacy for your whole workspace, take a look at our Private Offices.','/oficina-privada/',18 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='quees' AND b.`skey`='destacado');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','title','text','Titulo','Tu propio lugar, sin necesidad de una oficina completa','Your own spot, without needing a whole office','',19 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','text','richtext','Texto','Ideal si trabajas de forma presencial con frecuencia y prefieres tener siempre el mismo espacio, sin asumir el costo y operación de una oficina privada.','A good fit if you work on site often and prefer the same space every day, without the cost and running of a private office.','',20 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','item1','text','Punto 1','Tu escritorio siempre está reservado','Your desk is always reserved','',21 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='item1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','item2','text','Punto 2','No necesitas buscar lugar cada día','No hunting for a spot each day','',22 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='item2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','item3','text','Punto 3','Mobiliario e internet ya están incluidos','Furniture and internet already included','',23 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='item3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','item4','text','Punto 4','Puedes utilizar los servicios y áreas comunes de Aldea','You can use Aldea''s services and common areas','',24 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='item4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','item5','text','Punto 5','Tienes recepción y equipo Aldea en sitio','Reception and the Aldea team are on site','',25 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='item5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'lista','cierre','text','Frase de cierre','La estabilidad de tener tu propio lugar, con la flexibilidad de un espacio compartido.','The stability of your own spot, with the flexibility of a shared space.','',26 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='lista' AND b.`skey`='cierre');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','title','text','Titulo','¿Qué incluye tu membresía?','What''s included in your membership?','',27 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own_title','text','Columna 1 - titulo','Tu Escritorio Privado','Your Private Desk','',28 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own1','text','Incluye 1','Escritorio fijo de uso exclusivo','A fixed, exclusive desk','',29 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own2','text','Incluye 2','Silla y mobiliario de trabajo','Chair and work furniture','',30 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own3','text','Incluye 3','Internet','Internet','',31 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own4','text','Incluye 4','Acceso controlado','Controlled access','',32 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','own5','text','Incluye 5','Espacio de almacenamiento personal con llave, según sede','Lockable personal storage, depending on the location','',33 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='own5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','sh_title','text','Columna 2 - titulo','Además tienes acceso a Aldea','You also get access to Aldea','',34 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='sh_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','sh1','text','Acceso 1','Recepción','Reception','',35 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='sh1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','sh2','text','Acceso 2','Salas de juntas','Meeting rooms','',36 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='sh2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','sh3','text','Acceso 3','Áreas comunes','Common areas','',37 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='sh3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','sh4','text','Acceso 4','Cocina','Kitchen','',38 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='sh4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','sh5','text','Acceso 5','Café y bebidas','Coffee and drinks','',39 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='sh5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','sh6','text','Acceso 6','Recepción de paquetería','Parcel handling','',40 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='sh6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','sh7','text','Acceso 7','Impresiones','Printing','',41 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='sh7');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','sh8','text','Acceso 8','Seguridad','Security','',42 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='sh8');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','sh9','text','Acceso 9','Soporte del equipo Aldea','Support from the Aldea team','',43 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='sh9');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'incluye','nota','text','Nota al pie','Los servicios y beneficios incluidos pueden variar según la sede y condiciones de la membresía.','Included services and benefits may vary by location and membership terms.','',44 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='incluye' AND b.`skey`='nota');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','title','text','Titulo','Tu escritorio en tres pasos','Your desk in three steps','',45 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','s1_title','text','Paso 1 - titulo','Elige tu sede','Choose your location','',46 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='s1_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','s1_text','text','Paso 1 - texto','Selecciona la ubicación de Aldea que mejor te funcione.','Pick the Aldea location that works best for you.','',47 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='s1_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','s2_title','text','Paso 2 - titulo','Elige tu escritorio','Choose your desk','',48 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='s2_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','s2_text','text','Paso 2 - texto','Nuestro equipo te mostrará las estaciones disponibles.','Our team will show you the available workstations.','',49 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='s2_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','s3_title','text','Paso 3 - titulo','Hazlo tu lugar','Make it yours','',50 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='s3_title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'pasos','s3_text','text','Paso 3 - texto','Recibe tu acceso y empieza a trabajar desde tu escritorio asignado.','Get your access and start working from your assigned desk.','',51 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='pasos' AND b.`skey`='s3_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'flex','title','text','Titulo','Un espacio estable, con contratación flexible','A stable space, with flexible terms','',52 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='flex' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'flex','text','richtext','Texto principal','Contratos desde 1 mes, con opciones de mayor plazo según tus necesidades.','Terms from 1 month, with longer options depending on what you need.','',53 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='flex' AND b.`skey`='text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'flex','text2','richtext','Texto secundario','Si tus necesidades cambian, podemos revisar alternativas como Coworking, otro Escritorio Privado u Oficina Privada según disponibilidad.','If your needs change, we can look at Coworking, another Private Desk or a Private Office, subject to availability.','',54 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='flex' AND b.`skey`='text2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'flex','f1','text','Apoyo 1','Contratos desde 1 mes','Terms from 1 month','',55 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='flex' AND b.`skey`='f1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'flex','f2','text','Apoyo 2','Escritorio siempre asignado','Your desk always assigned','',56 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='flex' AND b.`skey`='f2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'flex','f3','text','Apoyo 3','Opciones de mayor plazo','Longer-term options','',57 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='flex' AND b.`skey`='f3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'flex','f4','text','Apoyo 4','Posibilidad de cambiar de solución conforme cambien tus necesidades','Option to switch solutions as your needs change','',58 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='flex' AND b.`skey`='f4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'tech','title','text','Titulo','Infraestructura para trabajar con tranquilidad','Infrastructure so you can work with peace of mind','',59 FROM DUAL WHERE NOT EXISTS
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
  SELECT @sp,'tech','t1_text','richtext','Bloque 1 - texto','Internet empresarial para mantenerte conectado durante tu jornada de trabajo.','Business internet to keep you connected through the working day.','',62 FROM DUAL WHERE NOT EXISTS
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
  SELECT @sp,'tech','t2_text','richtext','Bloque 2 - texto','Accesos controlados e instalaciones administradas por Aldea.','Controlled access and facilities managed by Aldea.','',65 FROM DUAL WHERE NOT EXISTS
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
  SELECT @sp,'tech','t3_text','richtext','Bloque 3 - texto','Equipo Aldea disponible para ayudarte con las necesidades relacionadas con tu espacio de trabajo.','The Aldea team is on hand for anything related to your workspace.','',68 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='tech' AND b.`skey`='t3_text');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'galeria','title','text','Titulo','Conoce nuestros Escritorios Privados','See our Private Desks','',69 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='galeria' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'galeria','lead','richtext','Subtexto','Estaciones de trabajo reales de Aldea dentro de nuestras áreas compartidas.','Real Aldea workstations inside our shared areas.','',70 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='galeria' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'ubicaciones','title','text','Titulo','Encuentra tu Escritorio Privado','Find your Private Desk','',71 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='ubicaciones' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'ubicaciones','lead','richtext','Texto','Selecciona tu ciudad y conoce la sede de Aldea más cercana.','Pick your city and find your nearest Aldea location.','',72 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='ubicaciones' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'ubicaciones','cta','text','Etiqueta del enlace de cada tarjeta','Ver sede','See location','',73 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='ubicaciones' AND b.`skey`='cta');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'form','title','text','Titulo','Encuentra tu Escritorio Privado','Find your Private Desk','',74 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='form' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'form','lead','richtext','Texto','Déjanos tus datos y nuestro equipo te ayudará a conocer los escritorios disponibles en la sede que te interesa.','Leave your details and our team will help you see which desks are available at the location you are interested in.','',75 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='form' AND b.`skey`='lead');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'form','boton','text','Texto del boton','Cotizar Escritorio Privado','Get a quote','',76 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='form' AND b.`skey`='boton');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'form','personas','text','¿Mostrar el campo Numero de personas? (si / no)','no','no','',77 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='form' AND b.`skey`='personas');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','title','text','Titulo','Preguntas frecuentes','Frequently asked questions','',78 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='title');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q1','text','Pregunta 1','¿Mi escritorio siempre es el mismo?','','',79 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a1','richtext','Respuesta 1','Sí. Tu estación de trabajo está asignada exclusivamente para ti durante la vigencia de tu membresía.','','',80 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a1');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q2','text','Pregunta 2','¿El escritorio está dentro de una oficina privada?','','',81 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a2','richtext','Respuesta 2','No. Los Escritorios Privados de Aldea se encuentran dentro de zonas de trabajo compartidas. Tu escritorio es exclusivo, pero el área donde se encuentra es compartida con otros miembros.','','',82 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a2');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q3','text','Pregunta 3','¿Cuál es la diferencia entre Escritorio Privado y Coworking?','','',83 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a3','richtext','Respuesta 3','Con Escritorio Privado tienes siempre la misma estación asignada. En Coworking puedes elegir entre los lugares disponibles dentro de las áreas compartidas cada vez que trabajas desde Aldea.','','',84 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a3');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q4','text','Pregunta 4','¿Cuál es la diferencia entre Escritorio Privado y Oficina Privada?','','',85 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a4','richtext','Respuesta 4','El Escritorio Privado es una estación fija dentro de una zona compartida. La Oficina Privada es un espacio cerrado y exclusivo para ti o tu equipo.','','',86 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a4');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q5','text','Pregunta 5','¿Cuál es el plazo mínimo?','','',87 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a5','richtext','Respuesta 5','Los Escritorios Privados pueden contratarse desde 1 mes, con opciones de mayor plazo según disponibilidad y necesidades.','','',88 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a5');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q6','text','Pregunta 6','¿Puedo utilizar las salas de juntas?','','',89 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a6','richtext','Respuesta 6','Sí. Puedes utilizar las salas de juntas de acuerdo con las condiciones y créditos incluidos en tu membresía.','','',90 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a6');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q7','text','Pregunta 7','¿Tengo espacio para guardar mis cosas?','','',91 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q7');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a7','richtext','Respuesta 7','Algunas sedes cuentan con almacenamiento personal con llave asociado al Escritorio Privado. La disponibilidad puede variar según la ubicación.','','',92 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a7');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','q8','text','Pregunta 8','¿Cuánto cuesta un Escritorio Privado?','','',93 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='q8');
INSERT INTO `blocks` (`page_id`,`section`,`skey`,`type`,`label`,`value_es`,`value_en`,`href`,`sort`)
  SELECT @sp,'faq','a8','richtext','Respuesta 8','El precio depende de la sede y condiciones de contratación. Selecciona tu ciudad o solicita una cotización para conocer las opciones disponibles.','','',94 FROM DUAL WHERE NOT EXISTS
  (SELECT 1 FROM (SELECT * FROM `blocks`) b
    WHERE b.`page_id`=@sp AND b.`section`='faq' AND b.`skey`='a8');

-- El hero debe dejar claro que el escritorio esta en una zona compartida
UPDATE `solutions` SET
  `hero_image`='/img/wp/2025/07/7-4.webp',
  `hero_image_alt`='Escritorios privados asignados dentro de una zona compartida de Aldea',
  `seo_title_es`='Escritorio Privado en renta | Aldea Networking',
  `seo_desc_es`='Tu escritorio fijo y exclusivo dentro de las areas compartidas de Aldea, con mobiliario, internet y servicios incluidos. Desde 1 mes en Queretaro, Leon, San Luis Potosi y Aguascalientes.'
  WHERE `slug`='escritorio-privado';
