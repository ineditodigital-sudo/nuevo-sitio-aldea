-- Centro Sur: las tres fotos de exterior son de la obra (andamios y malla).
-- Se ordena la galeria para que abra con un interior terminado y se deja fuera
-- la peor (Fachada-3, con la malla y el terreno sin urbanizar).
-- La foto de la ficha tambien pasa a ser un interior, como en las otras sedes.
UPDATE locations SET
  hero_image='/img/wp/2026/05/Foto-oficina-qro-1.webp',
  hero_image_alt='Oficina terminada en Aldea Centro Sur, con vista a Queretaro',
  gallery='["\/img\/wp\/2026\/05\/Foto-oficina-qro-1.webp","\/img\/wp\/2026\/05\/Foto-oficina-qro-2.webp","\/img\/wp\/2026\/02\/Fachada-Aldea-Centro-Sur-2.webp","\/img\/loc-qro.webp"]'
WHERE slug='oficinas-en-renta-queretaro';
