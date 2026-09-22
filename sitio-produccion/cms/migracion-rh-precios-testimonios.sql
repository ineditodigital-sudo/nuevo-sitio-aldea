-- ============================================================
-- 1. PRECIO DE ESCRITORIO PRIVADO (confirmado por el cliente)
-- ============================================================
UPDATE locations SET price_desk='3,400' WHERE slug='oficinas-en-renta-aguascalientes';
UPDATE locations SET price_desk='3,900' WHERE slug='oficinas-en-renta-leon-guanajuato';
UPDATE locations SET price_desk='3,900' WHERE slug='oficinas-en-renta-san-luis-potosi';
UPDATE locations SET price_desk='3,900' WHERE slug='oficinas-en-renta-queretaro';

-- ============================================================
-- 2. FOTOS REALES DEL EQUIPO (carpeta FOTOS RH)
-- ============================================================
-- Hero de Acerca de Aldea: el brief pide "dar mayor protagonismo a personas/equipo"
UPDATE blocks SET value_es='/img/equipo/equipo-hero.webp'
WHERE page_id=(SELECT id FROM pages WHERE slug='acerca-de-aldea') AND section='hero' AND skey='hero_img';

-- Seccion "Las personas son lo mas importante": "fotografia fuerte del equipo o staff"
UPDATE blocks SET value_es='/img/equipo/equipo-personas.webp'
WHERE page_id=(SELECT id FROM pages WHERE slug='acerca-de-aldea') AND section='personas' AND skey='int_img';

UPDATE blocks SET value_es='Equipo de Aldea Networking en una actividad de integracion',
                  value_en='The Aldea Networking team at a team-building activity'
WHERE page_id=(SELECT id FROM pages WHERE slug='acerca-de-aldea') AND section='personas' AND skey='int_img_alt';

-- Galeria "Asi se vive Aldea" (el campo EN de cada foto es su texto alternativo)
UPDATE blocks SET value_es='/img/equipo/vive-1.webp',
                  value_en='El equipo de Aldea reunido en el lobby de una sede'
WHERE page_id=(SELECT id FROM pages WHERE slug='acerca-de-aldea') AND section='vivealdea' AND skey='gal1';

UPDATE blocks SET value_es='/img/equipo/vive-2.webp',
                  value_en='Dinamica de team building del equipo de Aldea al aire libre'
WHERE page_id=(SELECT id FROM pages WHERE slug='acerca-de-aldea') AND section='vivealdea' AND skey='gal2';

UPDATE blocks SET value_es='/img/equipo/vive-3.webp',
                  value_en='El equipo abrazado con los valores de Aldea impresos en las playeras'
WHERE page_id=(SELECT id FROM pages WHERE slug='acerca-de-aldea') AND section='vivealdea' AND skey='gal3';

UPDATE blocks SET value_es='/img/equipo/vive-4.webp',
                  value_en='Colaboradoras y colaboradores de Aldea en un evento interno'
WHERE page_id=(SELECT id FROM pages WHERE slug='acerca-de-aldea') AND section='vivealdea' AND skey='gal4';

-- ============================================================
-- 3. ACENTOS EN LOS TESTIMONIOS (mismo texto, ortografia correcta)
-- ============================================================
UPDATE testimonials SET quote_es='Nos encantó que Aldea estuviera tan bien ubicado. Tenemos todo cerca y eso hace la vida diaria mucho más práctica.' WHERE id=1;
UPDATE testimonials SET quote_es='Venir a trabajar sin pensar en el café, la limpieza o la impresora no tiene precio. Todo está listo y eso nos da paz mental.' WHERE id=2;
UPDATE testimonials SET quote_es='Lo que más nos gusta es el trato del equipo. Te resuelven rápido y con buena actitud. Se siente que les importa ayudarte.' WHERE id=3;
UPDATE testimonials SET quote_es='Cuando empezamos éramos solo tres personas. Ahora somos seis y seguimos en Aldea. Han sido muy flexibles y nos han acompañado en cada etapa.' WHERE id=4;
UPDATE testimonials SET quote_es='Teníamos requisitos muy específicos de red, y en Aldea nos apoyaron a configurar nuestra VPN sin problema. Contar con internet de respaldo nos da tranquilidad.' WHERE id=5;
UPDATE testimonials SET name='Eduardo Velázquez' WHERE id=2;
UPDATE testimonials SET name='Salvador Marín' WHERE id=5;
