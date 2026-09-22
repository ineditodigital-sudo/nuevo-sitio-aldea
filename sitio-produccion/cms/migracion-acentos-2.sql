-- Correccion: conservar el texto original (incluye la fecha de apertura),
-- solo con los acentos puestos.
UPDATE blocks SET
 value_es='León (Gto.), San Luis Potosí, Aguascalientes y próximamente Querétaro, con apertura el 15 de junio de 2026.'
WHERE page_id=(SELECT id FROM pages WHERE slug='preguntas-frecuentes') AND section='body' AND skey='faq5_text';
