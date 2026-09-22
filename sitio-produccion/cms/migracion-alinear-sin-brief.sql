-- Alinea las paginas sin brief con los criterios de los siete briefs:
-- 1) fuera el CTA "Agenda tu tour"  2) fuera los comparativos de precios
-- 3) nomenclatura igual a la del menu nuevo

-- ---------- 1. Banda de cierre de los articulos del blog (__global) ----------
UPDATE blocks SET
  value_es='Cuéntanos qué necesita tu equipo y te ayudamos a encontrar el espacio adecuado en la sede que mejor te convenga.',
  value_en='Tell us what your team needs and we will help you find the right space at the location that suits you best.'
WHERE page_id=(SELECT id FROM pages WHERE slug='__global') AND section='cta' AND skey='cta_texto';

UPDATE blocks SET
  value_es='Cotizar', value_en='Get a quote', href='/contacto/'
WHERE page_id=(SELECT id FROM pages WHERE slug='__global') AND section='cta' AND skey='cta_boton';

-- ---------- 2. Cierre de Preguntas frecuentes ----------
UPDATE blocks SET
  value_es='Cuéntanos qué necesita tu equipo y te ayudamos a encontrar el espacio adecuado en la sede que mejor te convenga.',
  value_en='Tell us what your team needs and we will help you find the right space at the location that suits you best.'
WHERE page_id=(SELECT id FROM pages WHERE slug='preguntas-frecuentes') AND section='body' AND skey='cta_texto';

UPDATE blocks SET
  value_es='Cotizar', value_en='Get a quote', href='/contacto/'
WHERE page_id=(SELECT id FROM pages WHERE slug='preguntas-frecuentes') AND section='body' AND skey='cta_boton';

-- ---------- 3. La pregunta del tour pasa a hablar de visita a la sede ----------
UPDATE blocks SET
  value_es='¿Puedo conocer el espacio antes de contratar?',
  value_en='Can I see the space before signing?'
WHERE page_id=(SELECT id FROM pages WHERE slug='preguntas-frecuentes') AND section='body' AND skey='faq6_title';

UPDATE blocks SET
  value_es='Sí. Puedes agendar una visita desde la página de la sede que te interese o llamando al +52 449 454 0709. Un asesor te acompaña en el recorrido y resuelve tus dudas.',
  value_en='Yes. You can schedule a visit from the page of the location you are interested in, or by calling +52 449 454 0709. An advisor will walk you through the space and answer your questions.'
WHERE page_id=(SELECT id FROM pages WHERE slug='preguntas-frecuentes') AND section='body' AND skey='faq6_text';

-- ---------- 4. Sin boton en el hero de Contacto y de las paginas legales ----------
-- (el bloque existe con el valor vacio: asi banner() no dibuja boton)
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='contacto'),'hero','hero_cta','button','Boton del hero (vacio = sin boton)','','','/contacto/',5
FROM DUAL WHERE NOT EXISTS (
  SELECT 1 FROM (SELECT 1 FROM blocks WHERE page_id=(SELECT id FROM pages WHERE slug='contacto') AND section='hero' AND skey='hero_cta') t);

INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='terminos-y-condiciones'),'hero','hero_cta','button','Boton del hero (vacio = sin boton)','','','/contacto/',5
FROM DUAL WHERE NOT EXISTS (
  SELECT 1 FROM (SELECT 1 FROM blocks WHERE page_id=(SELECT id FROM pages WHERE slug='terminos-y-condiciones') AND section='hero' AND skey='hero_cta') t);

INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='politicas-de-privacidad'),'hero','hero_cta','button','Boton del hero (vacio = sin boton)','','','/contacto/',5
FROM DUAL WHERE NOT EXISTS (
  SELECT 1 FROM (SELECT 1 FROM blocks WHERE page_id=(SELECT id FROM pages WHERE slug='politicas-de-privacidad') AND section='hero' AND skey='hero_cta') t);
