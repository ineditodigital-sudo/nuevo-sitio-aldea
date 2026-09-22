-- Fotos de la pagina de Oficinas Corporativas.
--
-- El brief pide para el hero "fotografia de oficina corporativa, proyecto
-- terminado, render o composicion visual de alta calidad", y en su lista de
-- evitar incluye "tratar esta solucion como una Oficina Privada grande".
-- Hasta ahora el hero usaba justo eso: la foto de una oficina privada.
--
-- Estas son de un proyecto corporativo real y terminado, recuperadas del
-- WordPress viejo (pagina /oficinas-personalizadas/).
SET NAMES utf8mb4;

SET @cp := (SELECT `id` FROM `pages` WHERE `slug`='oficinas-corporativas' LIMIT 1);

UPDATE `blocks` SET `value_es`='/img/corporativas/corp-openplan.webp'
  WHERE `page_id`=@cp AND `section`='hero' AND `skey`='img';
UPDATE `blocks` SET `value_es`='Proyecto corporativo desarrollado por Aldea',
                    `value_en`='Corporate project developed by Aldea'
  WHERE `page_id`=@cp AND `section`='hero' AND `skey`='img_alt';

UPDATE `blocks` SET `value_es`='/img/corporativas/corp-cabinas.webp'
  WHERE `page_id`=@cp AND `section`='operacion' AND `skey`='img';
UPDATE `blocks` SET `value_es`='Espacios disenados a la medida de la operacion',
                    `value_en`='Spaces designed around the operation'
  WHERE `page_id`=@cp AND `section`='operacion' AND `skey`='img_alt';
