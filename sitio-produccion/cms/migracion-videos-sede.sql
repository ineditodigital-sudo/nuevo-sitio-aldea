-- =====================================================================
-- Videos de sede que pedia el brief ("Integrar el video de la sede como
-- una de las piezas de la galeria, identificado con icono ▶").
--
-- Estaban publicados en el WordPress viejo, en widgets de Elementor de
-- cada pagina de sede. Son los tours virtuales oficiales del canal
-- "Aldea Networking Leon", verificados uno a uno.
--
-- Queretaro no tiene: la sede aun no abre.
-- =====================================================================
SET NAMES utf8mb4;

UPDATE `locations` SET `video_url`='https://www.youtube.com/watch?v=v8VF3xjtFV4'
  WHERE `slug`='oficinas-en-renta-san-luis-potosi';      -- Recorrido Virtual - Aldea Park

UPDATE `locations` SET `video_url`='https://www.youtube.com/watch?v=y7eeLDYp5e4'
  WHERE `slug`='oficinas-en-renta-leon-guanajuato';      -- Tour virtual - Aldea Poliforum

UPDATE `locations` SET `video_url`='https://www.youtube.com/watch?v=SXN9PINknDM'
  WHERE `slug`='oficinas-en-renta-aguascalientes';       -- Tour virtual - Aldea Galerias
