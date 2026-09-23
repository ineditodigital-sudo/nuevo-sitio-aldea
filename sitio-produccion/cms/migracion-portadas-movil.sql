-- Portadas y banners en baja resolucion (Rediseno movil 2026-09).
-- Solo cambian si siguen con la imagen anterior.
SET NAMES utf8mb4;
-- Post: la portada era la miniatura de 300 x 169 px; es la misma foto en 1536 px, sin el marco negro.
UPDATE posts SET cover_image='/img/wp/2026/05/Foto-para-blog.webp' WHERE slug='que-ventajas-tiene-un-cowork-contra-oficinas-privadas-tradicionales' AND cover_image='/img/wp/2026/05/Foto-para-blog-300x169.png';
-- Legales: el banner era una foto de 820 px; se cambia por la sala de juntas de Leon en alta resolucion.
UPDATE blocks SET value_es='/img/sedes/leon/sala-de-juntas.webp' WHERE page_id=(SELECT id FROM pages WHERE slug='terminos-y-condiciones') AND section='hero' AND skey='hero_img' AND value_es='/img/sala.webp';
UPDATE blocks SET value_es='/img/sedes/leon/sala-de-juntas.webp' WHERE page_id=(SELECT id FROM pages WHERE slug='politicas-de-privacidad') AND section='hero' AND skey='hero_img' AND value_es='/img/sala.webp';
