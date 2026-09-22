<?php require __DIR__.'/site.php'; header('Content-Type:application/json');
$pdo=cms_pdo();
$pdo->exec("INSERT INTO pages (slug,type,title_es,title_en,published) VALUES ('','home','Inicio','Home',1) ON DUPLICATE KEY UPDATE type='home'");
$pid=$pdo->query("SELECT id FROM pages WHERE slug=''")->fetchColumn();
$F=[
 ['hero','title','text','Titulo principal (linea 1)','Tu espacio de trabajo,','Your workspace,',''],
 ['hero','title2','text','Titulo principal (linea 2, resaltada)','sin complicaciones.','without the hassle.',''],
 ['hero','lead','richtext','Texto de introduccion','Oficinas privadas y espacios de trabajo completamente equipados, con mobiliario, internet y servicios incluidos.','Private offices and fully equipped workspaces, with furniture, internet and services included.',''],
 ['hero','cta1','button','Boton principal','Ver ubicaciones','View locations','#ubicaciones'],
 ['hero','cta2','button','Boton secundario','Conoce nuestros espacios','Discover our spaces','#soluciones'],
 ['hero','lead2','richtext','Texto secundario','Para equipos desde 1 hasta más de 100 personas en Querétaro, León, San Luis Potosí y Aguascalientes.','For teams from 1 to more than 100 people in Queretaro, Leon, San Luis Potosi and Aguascalientes.',''],
 ['hero','photo_a','image','Imagen del hero 1','/img/home-hero.webp','',''],
 ['hero','photo_b','image','Imagen del hero 2','/img/espacio.webp','',''],
 ['hero','photo_c','image','Imagen del hero 3','/img/sala.webp','',''],
 ['hero','photo_d','image','Imagen del hero 4','/img/sol-coworking.webp','',''],
 ['soluciones','title','text','Titulo','Encuentra el espacio que necesitas','Find the space you need',''],
 ['soluciones','lead','richtext','Texto','Desde un lugar para trabajar hasta una oficina privada para todo tu equipo.','From a place to work to a private office for your whole team.',''],
 ['amenidades','title','text','Titulo','Tú te ocupas de tu empresa. Nosotros de tu oficina.','You take care of your business. We take care of your office.',''],
 ['amenidades','lead','richtext','Texto','Nos encargamos del espacio y de los servicios necesarios para que tú y tu equipo puedan trabajar desde el primer día.','We handle the space and the services so you and your team can work from day one.',''],
 ['amenidades','nota','text','Nota al pie','Los servicios incluidos pueden variar según la solución y ubicación contratada.','Included services may vary by solution and location.',''],
 ['ubicaciones','title','text','Titulo','Encuentra tu Aldea','Find your Aldea',''],
 ['ubicaciones','lead','richtext','Texto','Estamos presentes en cuatro ciudades del Bajío. Elige tu ubicación y conoce nuestros espacios.','We are present in four cities of the Bajio. Choose your location and discover our spaces.',''],
 ['clients','title','text','Titulo','Empresas que confían en Aldea','Companies that trust Aldea',''],
 ['corporativas','chip','eyebrow','Etiqueta','PARA EQUIPOS DE +100 PERSONAS','FOR TEAMS OF +100 PEOPLE',''],
 ['corporativas','title','text','Titulo','Oficinas Corporativas a la Medida','Tailor-made Corporate Offices',''],
 ['corporativas','text1','richtext','Texto 1','Diseñamos, adecuamos, equipamos y operamos espacios de trabajo exclusivos para grandes equipos.','We design, fit out, equip and operate exclusive workspaces for large teams.',''],
 ['corporativas','text2','richtext','Texto 2','Desarrollamos cada proyecto alrededor de las necesidades reales de tu empresa: distribución, infraestructura, mobiliario, tecnología, servicios y operación.','We build every project around your real needs: layout, infrastructure, furniture, technology, services and operation.',''],
 ['corporativas','step1','text','Paso 1','Entendemos tu operación','We map your operation',''],
 ['corporativas','step2','text','Paso 2','Diseñamos la solución','We design the solution',''],
 ['corporativas','step3','text','Paso 3','Adecuamos y equipamos','We fit out and equip',''],
 ['corporativas','step4','text','Paso 4','Operamos tu oficina','We run your office',''],
 ['corporativas','cta','button','Boton','Conoce más →','Learn more →','/oficinas-personalizadas/'],
 ['testimonios','title','text','Titulo','Lo que dicen nuestros clientes','What our clients say',''],
 ['numeros','title','text','Titulo','Aldea en números','Aldea by the numbers',''],
 ['numeros','n1_value','text','Dato 1 - cifra','4','4',''],
 ['numeros','n1_label','text','Dato 1 - etiqueta','Ciudades','Cities',''],
 ['numeros','n2_value','text','Dato 2 - cifra','2017','2017',''],
 ['numeros','n2_label','text','Dato 2 - etiqueta','Desde','Since',''],
 ['numeros','n3_value','text','Dato 3 - cifra','+X','+X',''],
 ['numeros','n3_label','text','Dato 3 - etiqueta','Empresas','Companies',''],
 ['numeros','n4_value','text','Dato 4 - cifra','+X','+X',''],
 ['numeros','n4_label','text','Dato 4 - etiqueta','Miembros','Members',''],
 ['numeros','n5_value','text','Dato 5 - cifra','+X','+X',''],
 ['numeros','n5_label','text','Dato 5 - etiqueta','m² de espacio','sq m of space',''],
 ['numeros','cta','button','Boton (opcional, vacia para ocultar)','Conoce Aldea →','Discover Aldea →','/acerca-de-aldea/'],
 ['contacto','title','text','Titulo','Hablemos sobre tu próximo espacio de trabajo','Let us talk about your next workspace',''],
 ['contacto','lead','richtext','Texto','Déjanos tus datos y nuestro equipo comercial se pondrá en contacto contigo para conocer lo que necesitas.','Leave your details and our sales team will get in touch to understand what you need.',''],
 ['contacto','phone','text','Telefono','+52 449 454 0709','+52 449 454 0709','tel:+524494540709'],
 ['contacto','email','text','Correo','contacto@aldea.work','contacto@aldea.work','mailto:contacto@aldea.work'],
];
$ins=$pdo->prepare("INSERT INTO blocks (page_id,section,skey,type,label,value_es,value_en,href,sort) SELECT ?,?,?,?,?,?,?,?,? FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM blocks WHERE page_id=? AND section=? AND skey=?)");
$n=0;$s=0;
foreach($F as $f){ $ins->execute([$pid,$f[0],$f[1],$f[2],$f[3],$f[4],$f[5],$f[6],$s++,$pid,$f[0],$f[1]]); $n+=$ins->rowCount(); }
echo json_encode(['ok'=>true,'page_id'=>$pid,'inserted'=>$n,'total'=>count($F)]);
