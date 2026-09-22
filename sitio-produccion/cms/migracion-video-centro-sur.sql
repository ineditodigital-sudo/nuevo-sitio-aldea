-- Video de Aldea Centro Sur (Queretaro). Es el unico self-hosted: las otras
-- tres sedes usan los tours del canal de YouTube de Aldea.
-- El lightbox de app6.js ya distingue YouTube/Vimeo de un archivo directo.
UPDATE locations SET
  video_url='/video/aldea-centro-sur.mp4',
  video_poster='/img/centro-sur-video.webp'
WHERE slug='oficinas-en-renta-queretaro';
