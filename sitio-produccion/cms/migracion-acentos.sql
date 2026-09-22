-- Acentos que faltaban en textos que ya existian.
UPDATE blocks SET
 value_es='León (Gto.), San Luis Potosí, Aguascalientes y próximamente Querétaro, con espacios listos para trabajar desde el primer día.'
WHERE page_id=(SELECT id FROM pages WHERE slug='preguntas-frecuentes') AND section='body' AND skey='faq5_text';

-- El complejo se llama "Galerías Business Square".
UPDATE locations SET address_es=REPLACE(address_es,'Galerias Business Square','Galerías Business Square'),
                     address_en=REPLACE(address_en,'Galerias Business Square','Galerías Business Square')
WHERE slug='oficinas-en-renta-aguascalientes';
