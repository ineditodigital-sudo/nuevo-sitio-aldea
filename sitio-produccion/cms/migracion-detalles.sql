-- =====================================================================
-- ALDEA — detalles pendientes del brief del Home
-- =====================================================================
SET NAMES utf8mb4;

-- 1) "Oficina privada" -> "Oficina Privada" (breadcrumb, menu, tarjetas)
UPDATE `solutions` SET `title_es`='Oficina Privada', `title_en`='Private Office'
  WHERE `slug`='oficina-privada';

-- 2) "Contacto" fuera del menu del header: el CTA "Cotizar" ya lleva ahi
--    y Contacto sigue en el footer.
UPDATE `menu_items` SET `published`=0
  WHERE `menu`='header' AND `href`='/contacto/';

-- 3) Acentos de las ciudades (menu, footer, tarjetas y formularios)
UPDATE `locations` SET `city_es`='Querétaro'        WHERE `slug`='oficinas-en-renta-queretaro';
UPDATE `locations` SET `city_es`='León'             WHERE `slug`='oficinas-en-renta-leon-guanajuato';
UPDATE `locations` SET `city_es`='San Luis Potosí'  WHERE `slug`='oficinas-en-renta-san-luis-potosi';
UPDATE `locations` SET `city_es`='Aguascalientes'   WHERE `slug`='oficinas-en-renta-aguascalientes';

-- 4) "Preguntas frecuentes" fuera de la columna Legal del footer:
--    el brief solo pide Aviso de privacidad y Terminos.
UPDATE `menu_items` SET `published`=0
  WHERE `menu`='footer' AND `href`='/preguntas-frecuentes/';
