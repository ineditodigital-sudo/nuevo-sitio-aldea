-- =====================================================================
-- "Secciones globales" queda reducida a lo unico que de verdad es global.
--
-- Al reemplazar las plantillas de soluciones y sedes, estas secciones
-- dejaron de renderizarse en ninguna parte:
--   tech (17 campos)  -> cada pagina tiene ahora su propia seccion
--   benefits (6)      -> del diseno anterior de las paginas de servicio
--   contacto (4)      -> el telefono y el correo se leen de Ajustes,
--                        y el titulo/texto solo los usaba la plantilla vieja
--
-- Queda solo el bloque de cierre de los articulos del blog.
-- Las funciones que pudieran leerlas traen valores por defecto en codigo,
-- asi que nada se rompe.
-- =====================================================================
SET NAMES utf8mb4;

SET @g := (SELECT `id` FROM `pages` WHERE `slug`='__global' LIMIT 1);

DELETE FROM `blocks` WHERE `page_id`=@g AND `section` IN ('tech','benefits','contacto');

UPDATE `pages`
   SET `title_es`='Cierre de los articulos del blog',
       `title_en`='Blog closing block'
 WHERE `id`=@g;
