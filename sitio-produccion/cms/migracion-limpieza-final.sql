-- La solucion "oficinas-personalizadas" quedo sustituida por la landing
-- /oficinas-corporativas/ y su URL ya redirige con 301. Se despublica para
-- que deje de anunciarse en el sitemap: un sitemap no debe listar URLs que
-- redirigen. El contenido no se borra, solo se oculta.
SET NAMES utf8mb4;
UPDATE `solutions` SET `published`=0, `in_menu`=0 WHERE `slug`='oficinas-personalizadas';
