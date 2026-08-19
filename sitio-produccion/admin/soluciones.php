<?php require __DIR__.'/_crud.php';
crud_run(['table'=>'solutions','active'=>'soluciones','title'=>'Servicios','order'=>'sort,id',
 'help'=>'Cada servicio tiene su pagina (nombre, descripcion, que incluye, imagenes) y su disponibilidad + precio por sucursal. Marca "Mostrar en el menu" para que aparezca en "Lo que ofrecemos".',
 'fields'=>[
   'title_es'=>['type'=>'text','label'=>'Nombre del servicio (ES)'],
   'title_en'=>['type'=>'text','label'=>'Nombre del servicio (EN)'],
   'slug'=>['type'=>'text','label'=>'Slug (URL)','hint'=>'Direccion de la pagina (ej. coworking). Solo minusculas y guiones. Cambiarlo en una pagina publicada afecta el SEO.'],
   'excerpt_es'=>['type'=>'textarea','label'=>'Descripcion corta (ES)','rows'=>3,'hint'=>'Resumen que aparece en las tarjetas de la home y del listado.'],
   'excerpt_en'=>['type'=>'textarea','label'=>'Descripcion corta (EN)','rows'=>3],
   'body_es'=>['type'=>'wysiwyg','label'=>'Descripcion ampliada (ES)'],
   'includes_es'=>['type'=>'textarea','label'=>'Que incluye (ES)','rows'=>5,'hint'=>'Un punto por linea. Cada linea se muestra como un elemento de la lista de beneficios.'],
   'includes_en'=>['type'=>'textarea','label'=>'Que incluye (EN)','rows'=>5],
   'hero_image'=>['type'=>'image','label'=>'Imagen principal','alt'=>true],
   'gallery'=>['type'=>'gallery','label'=>'Galeria de fotos','hint'=>'Se muestran como galeria/carrusel en la pagina del servicio.'],
   'availability'=>['type'=>'servicematrix','label'=>'Disponibilidad y precio por sucursal','hint'=>'Marca en que sedes esta disponible y su precio. Si una sede no esta marcada, el servicio no aparece en esa ciudad.'],
   'in_menu'=>['type'=>'check','label'=>'Mostrar en el menu','default'=>1,'hint'=>'Si esta activo, aparece en el menu "Lo que ofrecemos".'],
   'sort'=>['type'=>'number','label'=>'Orden','hint'=>'Menor numero = aparece primero.'],
   'published'=>['type'=>'check','label'=>'Publicado','default'=>1,'hint'=>'Desactivado = la pagina no se muestra en el sitio.']],
 'list'=>['hero_image'=>'Imagen','title_es'=>'Servicio','slug'=>'Slug','sort'=>'Orden']]);
