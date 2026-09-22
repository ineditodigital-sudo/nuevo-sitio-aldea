-- El boton de la seccion Oficinas Corporativas del Home guardaba su propio
-- href apuntando a la pagina vieja. Ahora que existe la landing, apunta ahi.
SET NAMES utf8mb4;
SET @home := (SELECT `id` FROM `pages` WHERE `slug`='' LIMIT 1);
UPDATE `blocks` SET `href`='/oficinas-corporativas/'
  WHERE `page_id`=@home AND `section`='corporativas' AND `skey`='cta';
