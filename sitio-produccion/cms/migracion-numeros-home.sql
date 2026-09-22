-- Cifras de "Aldea en numeros" del Home.
-- Se toman del brief de Acerca de Aldea, confirmadas por el cliente.
-- OJO: no coinciden con las que hoy publica aldea.work (ver PENDIENTES).
SET NAMES utf8mb4;

SET @home := (SELECT `id` FROM `pages` WHERE `slug`='' LIMIT 1);

UPDATE `blocks` SET `value_es`='+120',   `value_en`='+120'
  WHERE `page_id`=@home AND `section`='numeros' AND `skey`='n3_value';
UPDATE `blocks` SET `value_es`='+1,000', `value_en`='+1,000'
  WHERE `page_id`=@home AND `section`='numeros' AND `skey`='n4_value';
UPDATE `blocks` SET `value_es`='+6,000', `value_en`='+6,000'
  WHERE `page_id`=@home AND `section`='numeros' AND `skey`='n5_value';
