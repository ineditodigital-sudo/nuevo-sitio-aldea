<?php require __DIR__.'/_crud.php';
crud_run(['table'=>'testimonials','active'=>'testimonios','title'=>'Testimonios','order'=>'sort,id',
 'help'=>'Resenas de clientes que aparecen en el carrusel de la home. Sube la foto de la persona y el logo de su empresa.',
 'fields'=>['name'=>['type'=>'text','label'=>'Nombre'],'company'=>['type'=>'text','label'=>'Empresa'],'company_logo'=>['type'=>'image','label'=>'Logo de la empresa','alt'=>true,'hint'=>'PNG/WEBP con fondo transparente. Aparece junto a la resena.'],'quote_es'=>['type'=>'textarea','label'=>'Testimonio (ES)','rows'=>4],'quote_en'=>['type'=>'textarea','label'=>'Testimonio (EN)','rows'=>4],'avatar'=>['type'=>'image','label'=>'Foto de la persona','alt'=>true],'sort'=>['type'=>'number','label'=>'Orden'],'published'=>['type'=>'check','label'=>'Publicado','default'=>1]],
 'list'=>['avatar'=>'Foto','name'=>'Nombre','company'=>'Empresa','sort'=>'Orden']]);
