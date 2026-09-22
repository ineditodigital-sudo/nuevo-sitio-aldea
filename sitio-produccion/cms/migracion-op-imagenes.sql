-- Oficina Privada: dejar de depender de las imagenes del WordPress viejo.
-- Las 6 fotos se descargaron y ahora viven en /img/oficina-privada/.
-- Asi la pagina no se rompe cuando aldea.work deje de servir /wp-content/.

SET NAMES utf8mb4;

UPDATE `solutions` SET
  `hero_image`='/img/oficina-privada/op-2.webp',
  `hero_image_alt`='Equipo trabajando en una oficina privada de Aldea',
  `gallery`='["\/img\/oficina-privada\/op-1.webp","\/img\/oficina-privada\/op-2.webp","\/img\/oficina-privada\/op-3.webp","\/img\/oficina-privada\/op-4.webp","\/img\/oficina-privada\/op-5.webp","\/img\/oficina-privada\/op-6.webp"]'
  WHERE `slug`='oficina-privada';

SET @sp := (SELECT `id` FROM `pages` WHERE `slug`='sol:oficina-privada' LIMIT 1);

-- La foto de la seccion "Un espacio exclusivamente para tu equipo" tambien
-- debe ser una oficina privada real, no un area comun.
UPDATE `blocks` SET `value_es`='/img/oficina-privada/op-1.webp'
  WHERE `page_id`=@sp AND `section`='quees' AND `skey`='img';
