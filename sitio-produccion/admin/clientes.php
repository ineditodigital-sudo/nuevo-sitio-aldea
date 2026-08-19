<?php require __DIR__.'/_crud.php';
crud_run(['table'=>'clients','active'=>'clientes','title'=>'Clientes (logos)','order'=>'sort,id','img_fit'=>'contain',
 'help'=>'Logos del carrusel "Empresas que ya confian en Aldea". Sube PNG/WEBP con fondo transparente.',
 'fields'=>['name'=>['type'=>'text','label'=>'Nombre de la empresa'],'logo'=>['type'=>'image','label'=>'Logo','alt'=>true,'hint'=>'PNG o WEBP con fondo transparente para que se vea bien sobre la pildora blanca.'],'sort'=>['type'=>'number','label'=>'Orden'],'published'=>['type'=>'check','label'=>'Publicado','default'=>1]],
 'list'=>['logo'=>'Logo','name'=>'Empresa','sort'=>'Orden']]);
