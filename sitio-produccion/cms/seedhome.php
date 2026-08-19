<?php require __DIR__.'/site.php'; header('Content-Type:application/json');
$pdo=cms_pdo();
$pdo->exec("INSERT INTO pages (slug,type,title_es,title_en,published) VALUES ('','home','Inicio','Home',1) ON DUPLICATE KEY UPDATE type='home'");
$pid=$pdo->query("SELECT id FROM pages WHERE slug=''")->fetchColumn();
$F=[
 ['hero','title','text','Titulo principal (linea 1)','Tu espacio de trabajo,','Your workspace,',''],
 ['hero','title2','text','Titulo principal (linea 2, resaltada)','sin complicaciones.','without the hassle.',''],
 ['hero','lead','richtext','Texto de introduccion','Oficinas privadas, coworking y domicilio virtual - todo incluido - para que solo te preocupes de hacer crecer tu negocio.','Private offices, coworking and virtual address - all included - so your only concern is growing your business.',''],
 ['hero','cta1','button','Boton principal','Agenda tu tour','Book a tour','/contacto/'],
 ['hero','cta2','button','Boton secundario','Ver ubicaciones','View locations','/ubicaciones/'],
 ['hero','photo_a','image','Foto flotante 1','/img/loc-leon.webp','',''],
 ['hero','photo_b','image','Foto flotante 2','/img/espacio.webp','',''],
 ['nosotros','chip','eyebrow','Etiqueta','Nosotros','About',''],
 ['nosotros','title','text','Titulo','Creamos espacios donde las empresas crecen, no operan.','We create spaces where companies grow, not operate.',''],
 ['nosotros','lead','richtext','Texto','Empresa 100% mexicana fundada en 2017, con corporativo en Aguascalientes. Servicio cercano, diseno funcional y tecnologia para que encuentres todo listo desde el primer dia.','A 100% Mexican company founded in 2017. Close service, functional design and technology so everything is ready from day one.',''],
 ['soluciones','title','text','Titulo','Un espacio para cada necesidad','A space for every need',''],
 ['soluciones','lead','richtext','Texto','Desde emprendedores hasta grandes empresas, tenemos el espacio ideal para ti.','From entrepreneurs to large companies, we have the ideal space for you.',''],
 ['amenidades','title','text','Titulo','Todo incluido desde el primer dia','All included from day one',''],
 ['amenidades','lead','richtext','Texto','En Aldea no hay letras pequenas. Todas nuestras soluciones incluyen estas amenidades sin costo extra.','At Aldea there is no fine print. Every solution includes these amenities at no extra cost.',''],
 ['precios','title','text','Titulo','Precios claros por ciudad','Clear pricing by city',''],
 ['precios','lead','richtext','Texto','Elige tu ciudad y conoce el precio inicial de cada solucion. Todo incluido.','Choose your city and see the starting price for each solution.',''],
 ['ubicaciones','title','text','Titulo','Oficinas cerca de ti','Offices near you',''],
 ['ubicaciones','lead','richtext','Texto','Ubicaciones estrategicas en el Bajio mexicano. Encuentra tu espacio ideal.','Strategic locations across Mexico Bajio.',''],
 ['clients','title','text','Titulo','Empresas que ya confian en Aldea','Companies that already trust Aldea',''],
 ['testimonios','title','text','Titulo','Lo que dicen nuestros clientes','What our clients say',''],
 ['contacto','title','text','Titulo','Hablemos sobre tu proximo espacio de trabajo','Let us talk about your next workspace',''],
 ['contacto','lead','richtext','Texto','Dejanos tus datos y un asesor se pondra en contacto para entender lo que necesitas.','Leave your details and an advisor will contact you.',''],
 ['contacto','phone','text','Telefono','+52 449 454 0709','+52 449 454 0709','tel:+524494540709'],
 ['contacto','email','text','Correo','contacto@aldea.work','contacto@aldea.work','mailto:contacto@aldea.work'],
];
$ins=$pdo->prepare("INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort) SELECT ?,?,?,?,?,?,?,?,? FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM blocks WHERE page_id=? AND section=? AND skey=?)");
$n=0;$s=0;
foreach($F as $f){ $ins->execute([$pid,$f[0],$f[1],$f[2],$f[3],$f[4],$f[5],$f[6],$s++,$pid,$f[0],$f[1]]); $n+=$ins->rowCount(); }
echo json_encode(['ok'=>true,'page_id'=>$pid,'inserted'=>$n,'total'=>count($F)]);
