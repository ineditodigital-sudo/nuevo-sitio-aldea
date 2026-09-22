-- Testimonios en las cuatro landings de sede.
-- El cliente autorizo usar los testimonios generales mientras consigue los de cada sede.
-- Idempotente: si el bloque ya existe no se duplica.

-- ---------- Aldea Park ----------
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-san-luis-potosi'),'testi','title','text','Titulo de la seccion','Lo que dicen nuestros clientes','What our clients say','',1
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-san-luis-potosi') AND section='testi' AND skey='title') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-san-luis-potosi'),'testi','q1','richtext','Testimonio 1 - frase','Nos encantó que Aldea estuviera tan bien ubicado. Tenemos todo cerca y eso hace la vida diaria mucho más práctica.','Nos encantó que Aldea estuviera tan bien ubicado. Tenemos todo cerca y eso hace la vida diaria mucho más práctica.','',10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-san-luis-potosi') AND section='testi' AND skey='q1') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-san-luis-potosi'),'testi','n1','text','Testimonio 1 - nombre','Eitzel Galindo','Eitzel Galindo','',11
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-san-luis-potosi') AND section='testi' AND skey='n1') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-san-luis-potosi'),'testi','e1','text','Testimonio 1 - empresa','Edenred','Edenred','',12
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-san-luis-potosi') AND section='testi' AND skey='e1') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-san-luis-potosi'),'testi','q2','richtext','Testimonio 2 - frase','Venir a trabajar sin pensar en el café, la limpieza o la impresora no tiene precio. Todo está listo y eso nos da paz mental.','Venir a trabajar sin pensar en el café, la limpieza o la impresora no tiene precio. Todo está listo y eso nos da paz mental.','',20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-san-luis-potosi') AND section='testi' AND skey='q2') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-san-luis-potosi'),'testi','n2','text','Testimonio 2 - nombre','Eduardo Velázquez','Eduardo Velázquez','',21
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-san-luis-potosi') AND section='testi' AND skey='n2') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-san-luis-potosi'),'testi','e2','text','Testimonio 2 - empresa','Banco Azteca','Banco Azteca','',22
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-san-luis-potosi') AND section='testi' AND skey='e2') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-san-luis-potosi'),'testi','q3','richtext','Testimonio 3 - frase','Lo que más nos gusta es el trato del equipo. Te resuelven rápido y con buena actitud. Se siente que les importa ayudarte.','Lo que más nos gusta es el trato del equipo. Te resuelven rápido y con buena actitud. Se siente que les importa ayudarte.','',30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-san-luis-potosi') AND section='testi' AND skey='q3') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-san-luis-potosi'),'testi','n3','text','Testimonio 3 - nombre','Enrique del Campo','Enrique del Campo','',31
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-san-luis-potosi') AND section='testi' AND skey='n3') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-san-luis-potosi'),'testi','e3','text','Testimonio 3 - empresa','Cemex','Cemex','',32
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-san-luis-potosi') AND section='testi' AND skey='e3') t);

-- ---------- Aldea Poliforum ----------
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-leon-guanajuato'),'testi','title','text','Titulo de la seccion','Lo que dicen nuestros clientes','What our clients say','',1
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-leon-guanajuato') AND section='testi' AND skey='title') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-leon-guanajuato'),'testi','q1','richtext','Testimonio 1 - frase','Venir a trabajar sin pensar en el café, la limpieza o la impresora no tiene precio. Todo está listo y eso nos da paz mental.','Venir a trabajar sin pensar en el café, la limpieza o la impresora no tiene precio. Todo está listo y eso nos da paz mental.','',10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-leon-guanajuato') AND section='testi' AND skey='q1') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-leon-guanajuato'),'testi','n1','text','Testimonio 1 - nombre','Eduardo Velázquez','Eduardo Velázquez','',11
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-leon-guanajuato') AND section='testi' AND skey='n1') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-leon-guanajuato'),'testi','e1','text','Testimonio 1 - empresa','Banco Azteca','Banco Azteca','',12
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-leon-guanajuato') AND section='testi' AND skey='e1') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-leon-guanajuato'),'testi','q2','richtext','Testimonio 2 - frase','Lo que más nos gusta es el trato del equipo. Te resuelven rápido y con buena actitud. Se siente que les importa ayudarte.','Lo que más nos gusta es el trato del equipo. Te resuelven rápido y con buena actitud. Se siente que les importa ayudarte.','',20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-leon-guanajuato') AND section='testi' AND skey='q2') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-leon-guanajuato'),'testi','n2','text','Testimonio 2 - nombre','Enrique del Campo','Enrique del Campo','',21
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-leon-guanajuato') AND section='testi' AND skey='n2') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-leon-guanajuato'),'testi','e2','text','Testimonio 2 - empresa','Cemex','Cemex','',22
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-leon-guanajuato') AND section='testi' AND skey='e2') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-leon-guanajuato'),'testi','q3','richtext','Testimonio 3 - frase','Cuando empezamos éramos solo tres personas. Ahora somos seis y seguimos en Aldea. Han sido muy flexibles y nos han acompañado en cada etapa.','Cuando empezamos éramos solo tres personas. Ahora somos seis y seguimos en Aldea. Han sido muy flexibles y nos han acompañado en cada etapa.','',30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-leon-guanajuato') AND section='testi' AND skey='q3') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-leon-guanajuato'),'testi','n3','text','Testimonio 3 - nombre','Miguel Barrientos','Miguel Barrientos','',31
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-leon-guanajuato') AND section='testi' AND skey='n3') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-leon-guanajuato'),'testi','e3','text','Testimonio 3 - empresa','Opzione','Opzione','',32
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-leon-guanajuato') AND section='testi' AND skey='e3') t);

-- ---------- Aldea Galerias ----------
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-aguascalientes'),'testi','title','text','Titulo de la seccion','Lo que dicen nuestros clientes','What our clients say','',1
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-aguascalientes') AND section='testi' AND skey='title') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-aguascalientes'),'testi','q1','richtext','Testimonio 1 - frase','Lo que más nos gusta es el trato del equipo. Te resuelven rápido y con buena actitud. Se siente que les importa ayudarte.','Lo que más nos gusta es el trato del equipo. Te resuelven rápido y con buena actitud. Se siente que les importa ayudarte.','',10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-aguascalientes') AND section='testi' AND skey='q1') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-aguascalientes'),'testi','n1','text','Testimonio 1 - nombre','Enrique del Campo','Enrique del Campo','',11
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-aguascalientes') AND section='testi' AND skey='n1') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-aguascalientes'),'testi','e1','text','Testimonio 1 - empresa','Cemex','Cemex','',12
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-aguascalientes') AND section='testi' AND skey='e1') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-aguascalientes'),'testi','q2','richtext','Testimonio 2 - frase','Cuando empezamos éramos solo tres personas. Ahora somos seis y seguimos en Aldea. Han sido muy flexibles y nos han acompañado en cada etapa.','Cuando empezamos éramos solo tres personas. Ahora somos seis y seguimos en Aldea. Han sido muy flexibles y nos han acompañado en cada etapa.','',20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-aguascalientes') AND section='testi' AND skey='q2') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-aguascalientes'),'testi','n2','text','Testimonio 2 - nombre','Miguel Barrientos','Miguel Barrientos','',21
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-aguascalientes') AND section='testi' AND skey='n2') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-aguascalientes'),'testi','e2','text','Testimonio 2 - empresa','Opzione','Opzione','',22
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-aguascalientes') AND section='testi' AND skey='e2') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-aguascalientes'),'testi','q3','richtext','Testimonio 3 - frase','Teníamos requisitos muy específicos de red, y en Aldea nos apoyaron a configurar nuestra VPN sin problema. Contar con internet de respaldo nos da tranquilidad.','Teníamos requisitos muy específicos de red, y en Aldea nos apoyaron a configurar nuestra VPN sin problema. Contar con internet de respaldo nos da tranquilidad.','',30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-aguascalientes') AND section='testi' AND skey='q3') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-aguascalientes'),'testi','n3','text','Testimonio 3 - nombre','Salvador Marín','Salvador Marín','',31
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-aguascalientes') AND section='testi' AND skey='n3') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-aguascalientes'),'testi','e3','text','Testimonio 3 - empresa','Royale','Royale','',32
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-aguascalientes') AND section='testi' AND skey='e3') t);

-- ---------- Aldea Centro Sur ----------
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-queretaro'),'testi','title','text','Titulo de la seccion','Lo que dicen nuestros clientes','What our clients say','',1
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-queretaro') AND section='testi' AND skey='title') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-queretaro'),'testi','q1','richtext','Testimonio 1 - frase','Cuando empezamos éramos solo tres personas. Ahora somos seis y seguimos en Aldea. Han sido muy flexibles y nos han acompañado en cada etapa.','Cuando empezamos éramos solo tres personas. Ahora somos seis y seguimos en Aldea. Han sido muy flexibles y nos han acompañado en cada etapa.','',10
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-queretaro') AND section='testi' AND skey='q1') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-queretaro'),'testi','n1','text','Testimonio 1 - nombre','Miguel Barrientos','Miguel Barrientos','',11
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-queretaro') AND section='testi' AND skey='n1') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-queretaro'),'testi','e1','text','Testimonio 1 - empresa','Opzione','Opzione','',12
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-queretaro') AND section='testi' AND skey='e1') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-queretaro'),'testi','q2','richtext','Testimonio 2 - frase','Teníamos requisitos muy específicos de red, y en Aldea nos apoyaron a configurar nuestra VPN sin problema. Contar con internet de respaldo nos da tranquilidad.','Teníamos requisitos muy específicos de red, y en Aldea nos apoyaron a configurar nuestra VPN sin problema. Contar con internet de respaldo nos da tranquilidad.','',20
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-queretaro') AND section='testi' AND skey='q2') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-queretaro'),'testi','n2','text','Testimonio 2 - nombre','Salvador Marín','Salvador Marín','',21
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-queretaro') AND section='testi' AND skey='n2') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-queretaro'),'testi','e2','text','Testimonio 2 - empresa','Royale','Royale','',22
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-queretaro') AND section='testi' AND skey='e2') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-queretaro'),'testi','q3','richtext','Testimonio 3 - frase','Nos encantó que Aldea estuviera tan bien ubicado. Tenemos todo cerca y eso hace la vida diaria mucho más práctica.','Nos encantó que Aldea estuviera tan bien ubicado. Tenemos todo cerca y eso hace la vida diaria mucho más práctica.','',30
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-queretaro') AND section='testi' AND skey='q3') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-queretaro'),'testi','n3','text','Testimonio 3 - nombre','Eitzel Galindo','Eitzel Galindo','',31
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-queretaro') AND section='testi' AND skey='n3') t);
INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort)
SELECT (SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-queretaro'),'testi','e3','text','Testimonio 3 - empresa','Edenred','Edenred','',32
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM blocks
  WHERE page_id=(SELECT id FROM pages WHERE slug='loc:oficinas-en-renta-queretaro') AND section='testi' AND skey='e3') t);
