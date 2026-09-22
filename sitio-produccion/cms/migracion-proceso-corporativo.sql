-- Seccion "Del proyecto al espacio terminado" de /oficinas-corporativas/.
-- Etapas 1-4: imagenes generadas con IA (provisionales, mientras los arquitectos
-- preparan material real). Etapas 5-6: fotografia real de un proyecto terminado.
UPDATE blocks SET value_es='/img/corporativas/proceso/e1-requerimientos.webp'
WHERE page_id=(SELECT id FROM pages WHERE slug='oficinas-corporativas') AND section='proyecto' AND skey='e1_img';
UPDATE blocks SET value_es='/img/corporativas/proceso/e2-zonificacion.webp'
WHERE page_id=(SELECT id FROM pages WHERE slug='oficinas-corporativas') AND section='proyecto' AND skey='e2_img';
UPDATE blocks SET value_es='/img/corporativas/proceso/e3-render.webp'
WHERE page_id=(SELECT id FROM pages WHERE slug='oficinas-corporativas') AND section='proyecto' AND skey='e3_img';
UPDATE blocks SET value_es='/img/corporativas/proceso/e4-construccion.webp'
WHERE page_id=(SELECT id FROM pages WHERE slug='oficinas-corporativas') AND section='proyecto' AND skey='e4_img';
UPDATE blocks SET value_es='/img/corporativas/proceso/e5-equipamiento.webp'
WHERE page_id=(SELECT id FROM pages WHERE slug='oficinas-corporativas') AND section='proyecto' AND skey='e5_img';
UPDATE blocks SET value_es='/img/corporativas/proceso/e6-resultado.webp'
WHERE page_id=(SELECT id FROM pages WHERE slug='oficinas-corporativas') AND section='proyecto' AND skey='e6_img';

-- Aclaracion visible: distingue lo ilustrativo de la obra real.
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='oficinas-corporativas'),'proyecto','nota','text',
 'Nota al pie de la secuencia',
 'Las primeras cuatro etapas son imágenes ilustrativas del proceso. El equipamiento y el resultado final corresponden a un proyecto realizado por Aldea.',
 'The first four stages are illustrative images of the process. The equipment and final result correspond to a project delivered by Aldea.',
 '',109
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='oficinas-corporativas') AND section='proyecto' AND skey='nota') t);
