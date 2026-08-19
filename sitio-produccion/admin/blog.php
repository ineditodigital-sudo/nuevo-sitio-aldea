<?php require __DIR__.'/_crud.php';
crud_run(['table'=>'posts','active'=>'blog','title'=>'Blog','order'=>'published_at DESC, id DESC',
 'help'=>'Escribe o edita entradas del blog con el editor visual (sin codigo). Para que una entrada aparezca en el sitio, ponla en Estado: Publicado.',
 'fields'=>[
   'cover_image'=>['type'=>'image','label'=>'Imagen de portada','alt'=>true,'hint'=>'Aparece en la tarjeta del blog y arriba de la entrada. Usa una imagen horizontal de buena calidad.'],
   'title_es'=>['type'=>'text','label'=>'Titulo (ES)'],
   'title_en'=>['type'=>'text','label'=>'Titulo (EN)'],
   'slug'=>['type'=>'text','label'=>'Slug (URL)','hint'=>'Parte final de la direccion (ej. mi-entrada). Solo minusculas y guiones. Si ya esta publicada, cambiarlo rompe el enlace en Google.'],
   'excerpt_es'=>['type'=>'textarea','label'=>'Extracto (ES)','rows'=>3,'hint'=>'Resumen corto que se muestra en la tarjeta y en los buscadores.'],
   'excerpt_en'=>['type'=>'textarea','label'=>'Extracto (EN)','rows'=>3],
   'body_es'=>['type'=>'wysiwyg','label'=>'Contenido (ES)'],
   'body_en'=>['type'=>'wysiwyg','label'=>'Contenido (EN)'],
   'author'=>['type'=>'text','label'=>'Autor','default'=>'Aldea'],
   'status'=>['type'=>'select','label'=>'Estado','options'=>['draft'=>'Borrador','publish'=>'Publicado'],'hint'=>'Borrador = no se ve en el sitio. Publicado = visible para todos.'],
   'published_at'=>['type'=>'text','label'=>'Fecha (AAAA-MM-DD)','hint'=>'Fecha que se muestra y ordena las entradas. Formato: 2026-01-31.']],
 'list'=>['cover_image'=>'Portada','title_es'=>'Titulo','status'=>'Estado','published_at'=>'Fecha']]);
