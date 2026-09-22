<?php require __DIR__.'/_init.php'; require_once __DIR__.'/_crud.php'; require_once __DIR__.'/../cms/icons.php';
$pdo=cms_pdo();
$pid=(int)($_GET['id']??0);
$page=$pdo->prepare("SELECT * FROM pages WHERE id=?"); $page->execute([$pid]); $page=$page->fetch();
if(!$page){ admin_head('paginas','Pagina'); echo '<p class="adm-empty">Pagina no encontrada. <a href="/admin/paginas.php">Volver</a></p>'; admin_foot(); return; }

if($_SERVER['REQUEST_METHOD']==='POST' && csrf_ok()){
  $u=$pdo->prepare("UPDATE blocks SET value_es=?,value_en=?,href=?,meta=? WHERE id=? AND page_id=?");
  foreach(($_POST['b']??[]) as $id=>$v){
    $es=$v['es']??''; $en=$v['en']??''; $hr=trim($v['href']??'');
    if(!empty($_FILES['img']['name'][$id])){
      $_FILES['imgone']=['name'=>$_FILES['img']['name'][$id],'type'=>$_FILES['img']['type'][$id],'tmp_name'=>$_FILES['img']['tmp_name'][$id],'error'=>$_FILES['img']['error'][$id],'size'=>$_FILES['img']['size'][$id]];
      $up=crud_upload('imgone'); if($up) $es=$up;
    }
    $mm=$_POST['m'][$id]??[]; $mm=array_filter($mm,function($x){return $x!==''&&$x!==null;});
    $meta=$mm?json_encode($mm,JSON_UNESCAPED_UNICODE):null;
    $u->execute([$es,$en,$hr,$meta,(int)$id,$pid]);
  }
  if(isset($_POST['seo'])){
    $s=$_POST['seo'];
    $pdo->prepare("UPDATE pages SET seo_title_es=?,seo_desc_es=?,seo_title_en=?,seo_desc_en=?,noindex=? WHERE id=?")
        ->execute([trim($s['title_es']??''),trim($s['desc_es']??''),trim($s['title_en']??''),trim($s['desc_en']??''),isset($s['noindex'])?1:0,$pid]);
  }
  flash('Cambios guardados y publicados en el sitio.');
  header('Location: '.$_SERVER['SCRIPT_NAME'].'?id='.$pid); exit;
}

$__orden="'hero','page','clients','empresas','soluciones','amenidades',"
        ."'quees','lista','incluye','pasos','flex','porque','espacios',"
        ."'operacion','equipo','proceso','renta','servicios','tech',"
        ."'galeria','proyecto','ubicaciones','mapa','corporativas',"
        ."'testimonios','testi','numeros','personas','valores','vivealdea',"
        ."'contacto','form','visita','faq',"
        ."'nosotros','precios','body'";
// FIELD() devuelve 0 si la seccion no esta en la lista, y 0 ordena antes
// que 1: sin este IF, una seccion nueva se colaria delante de Portada.
$blocks=$pdo->query("SELECT * FROM blocks WHERE page_id=$pid
  ORDER BY IF(FIELD(section,$__orden)=0,900,FIELD(section,$__orden)),sort,id")->fetchAll();
$isLegal=$page['type']==='legal';
// metadatos por seccion: [nombre, descripcion (que parte del sitio), icono svg-path]
$SM=[
 'hero'=>['Portada','Lo primero que ve el visitante: titulo grande, texto y botones.','<path d="M3 5h18v14H3z"/><path d="M3 9h18"/>'],
 'nosotros'=>['Nosotros','Bloque de presentacion de la empresa.','<path d="M17 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.9"/>'],
 'soluciones'=>['Soluciones','Titulo de la seccion de servicios.','<rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/>'],
 'amenidades'=>['Amenidades','Titulo de la seccion "todo incluido".','<path d="M12 3l1.9 5.8H20l-4.9 3.6 1.9 5.8L12 14.6 6.9 18.2l1.9-5.8L4 8.8h6.1z"/>'],
 'precios'=>['Precios','Titulo de la seccion de precios por ciudad.','<path d="M20 12V7H4v10h8"/><circle cx="12" cy="12" r="2"/><path d="M17 15l2 2 4-4"/>'],
 'ubicaciones'=>['Ubicaciones','Titulo de la seccion de sedes.','<path d="M12 21s7-5.5 7-11a7 7 0 1 0-14 0c0 5.5 7 11 7 11z"/><circle cx="12" cy="10" r="2.5"/>'],
 'clients'=>['Clientes','Titulo del carrusel de empresas.','<rect x="2" y="7" width="20" height="14" rx="2"/><path d="M8 7V5a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/>'],
 'corporativas'=>['Oficinas Corporativas','Bloque del Home para proyectos de +100 personas.','<path d="M3 21h18M5 21V5l7-2v18M12 21V9l7 3v9"/><path d="M8 8h.01M8 12h.01M15 14h.01"/>'],
 'numeros'=>['Aldea en numeros','Las cifras que aparecen en el Home. Valida los datos antes de publicar.','<path d="M4 19V9M10 19V5M16 19v-7M22 19H2"/>'],
 'personas'=>['Las personas','Foto y texto de la seccion sobre el equipo.','<path d="M17 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.9"/>'],
 'valores'=>['Nuestros valores','Las cinco frases y el nombre de cada valor.','<path d="M12 3l1.9 5.8H20l-4.9 3.6 1.9 5.8L12 14.6 6.9 18.2l1.9-5.8L4 8.8h6.1z"/>'],
 'vivealdea'=>['Asi se vive Aldea','La galeria de fotos del equipo. Sin fotos, la seccion no se muestra.','<rect x="3" y="5" width="18" height="14" rx="2"/><circle cx="9" cy="10" r="2"/><path d="m21 17-5-5-4 4-2-2-4 4"/>'],
 'testimonios'=>['Testimonios','Titulo de la seccion de opiniones.','<path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>'],
 'tech'=>['Tecnologia (sin uso)','Ya no se muestra: cada pagina tiene ahora su propia seccion de Tecnologia.','<rect x="4" y="9" width="16" height="11" rx="2"/><path d="M8 9V6M16 9V6M9 13v3M15 13v3"/>'],
 'contacto'=>['Contacto','Telefono y correo que se muestran en los formularios de servicios y sedes.','<rect x="3" y="5" width="18" height="14" rx="2"/><path d="m3 7 9 6 9-6"/>'],
 'benefits'=>['Beneficios (sin uso)','Quedo del diseno anterior de las paginas de servicio. Ya no se muestra.','<path d="M20 6 9 17l-5-5"/>'],
 'cta'=>['Llamado a la accion (CTA)','Bloque de cierre. Hoy solo aparece al final de los articulos del blog.','<path d="M13 2 3 14h9l-1 8 10-12h-9z"/>'],
 'body'=>['Contenido','El cuerpo principal de esta pagina.','<rect x="4" y="3" width="16" height="18" rx="2"/><path d="M8 8h8M8 12h8M8 16h5"/>'],
 'empresas'=>['Empresas que confian','Titulo de la franja de logos de clientes.','<rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/>'],
 'quees'=>['Que es esta solucion','Explicacion con foto y los bloques de apoyo.','<rect x="4" y="3" width="16" height="18" rx="2"/><path d="M8 8h8M8 12h8M8 16h5"/>'],
 'lista'=>['Bloque de argumentos','La lista de puntos y su frase de cierre.','<path d="M8 6h13M8 12h13M8 18h13M3 6h.01M3 12h.01M3 18h.01"/>'],
 'incluye'=>['Que incluye','Las dos columnas de lo que incluye la membresia.','<path d="M20 6 9 17l-5-5"/>'],
 'pasos'=>['Pasos','El proceso en tres pasos.','<path d="M4 18h4v-4H4zM10 14h4V8h-4zM16 10h4V4h-4z"/>'],
 'flex'=>['Flexibilidad y plazos','Texto sobre contratacion y sus etiquetas.','<path d="M12 3l1.9 5.8H20l-4.9 3.6 1.9 5.8L12 14.6 6.9 18.2l1.9-5.8L4 8.8h6.1z"/>'],
 'galeria'=>['Galeria','Titulo y subtexto. Las fotos se cambian en Servicios.','<rect x="3" y="5" width="18" height="14" rx="2"/><circle cx="9" cy="10" r="2"/><path d="m21 17-5-5-4 4-2-2-4 4"/>'],
 'form'=>['Formulario','Titulo, texto y boton del formulario de la pagina.','<rect x="3" y="4" width="18" height="16" rx="2"/><path d="M7 9h10M7 13h6"/>'],
 'faq'=>['Preguntas frecuentes','Las preguntas y respuestas del acordeon.','<circle cx="12" cy="12" r="9"/><path d="M9.5 9a2.5 2.5 0 1 1 3 2.4V13"/><path d="M12 17h.01"/>'],
 'porque'=>['Por que esta sede','Texto de la sede y sus tres diferenciadores.','<path d="M12 21s7-5.5 7-11a7 7 0 1 0-14 0c0 5.5 7 11 7 11z"/><circle cx="12" cy="10" r="2.5"/>'],
 'espacios'=>['Espacios disponibles','Las cuatro tarjetas con precio. Los precios se editan en Ubicaciones.','<rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/>'],
 'servicios'=>['Servicios incluidos','Los servicios con icono que se listan en la pagina.','<path d="M20 6 9 17l-5-5"/>'],
 'mapa'=>['Mapa y ubicacion','Titulo de la seccion del mapa.','<path d="M12 21s7-5.5 7-11a7 7 0 1 0-14 0c0 5.5 7 11 7 11z"/><circle cx="12" cy="10" r="2.5"/>'],
 'visita'=>['Agenda tu visita','Textos de la ventana para agendar una visita.','<rect x="3" y="5" width="18" height="16" rx="2"/><path d="M8 3v4M16 3v4M3 10h18"/>'],
 'testi'=>['Testimonios de la sede','Citas propias de esta sede. Vacio = seccion oculta.','<path d="M17 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.9"/>'],
 'operacion'=>['Alrededor de tu operacion','Texto, foto y los cinco ejes del proyecto.','<path d="M3 21h18M5 21V5l7-2v18M12 21V9l7 3v9"/><path d="M8 8h.01M8 12h.01M15 14h.01"/>'],
 'equipo'=>['Un solo equipo','El alcance que cubre Aldea y su frase de cierre.','<path d="M17 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.9"/>'],
 'proceso'=>['Como trabajamos','Las cinco etapas del proyecto.','<path d="M4 18h4v-4H4zM10 14h4V8h-4zM16 10h4V4h-4z"/>'],
 'renta'=>['Todo en una renta','La formula y los beneficios.','<circle cx="12" cy="12" r="9"/><path d="M15 9.5A3 3 0 0 0 12 8c-2 0-3 1-3 2s1 2 3 2 3 1 3 2-1 2-3 2a3 3 0 0 1-3-1.5M12 6v12"/>'],
 'proyecto'=>['Del proyecto al espacio','La secuencia visual. Sin fotos, la seccion no se muestra.','<rect x="3" y="5" width="18" height="14" rx="2"/><circle cx="9" cy="10" r="2"/><path d="m21 17-5-5-4 4-2-2-4 4"/>'],
];
// 'page' guarda ajustes tecnicos (que plantilla usa), no contenido editable
$blocks=array_values(array_filter($blocks,function($b){ return $b['section']!=='page'; }));
$groups=[]; foreach($blocks as $b){ $groups[$b['section']][]=$b; }
$secs=array_keys($groups);

admin_head('paginas','Editar: '.$page['title_es']);
function selctl($name,$val,$opts,$label){ $h='<label class="sc"><span>'.$label.'</span><select name="'.$name.'">'; foreach($opts as $k=>$t){ $h.='<option value="'.htmlspecialchars($k).'"'.((string)$val===(string)$k?' selected':'').'>'.htmlspecialchars($t).'</option>'; } return $h.'</select></label>'; }
function colorctl($name,$val,$presets,$label){ $val=(string)$val;
  $h='<div class="sc cc" data-cc><span>'.$label.'</span><input type="hidden" name="'.$name.'" value="'.htmlspecialchars($val).'" class="cc-val"><div class="cc-sw"><button type="button" class="cc-b'.($val===''?' on':'').'" data-c="">Auto</button>';
  foreach($presets as $hex=>$nm){ $h.='<button type="button" class="cc-b'.(strtolower($val)===strtolower($hex)?' on':'').'" data-c="'.$hex.'" style="--sw:'.$hex.'" title="'.htmlspecialchars($nm).'"></button>'; }
  $h.='<input type="color" class="cc-cust" value="'.($val!==''&&$val[0]==='#'?htmlspecialchars($val):'#000000').'"></div></div>'; return $h;
}
function iconfield($id,$val){ $lib=aldea_icon_lib(); $val=(string)$val; $custom=($val!==''&&!isset($lib[$val]));
  $h='<div class="ic-wrap"><input type="hidden" name="b['.$id.'][es]" value="'.htmlspecialchars($val).'" class="ic-val"><div class="ic-pick" data-icp>';
  foreach($lib as $k=>$_){ $h.='<button type="button" class="ic-b'.($val===$k?' on':'').'" data-k="'.$k.'" title="'.$k.'">'.aldea_icon($k).'</button>'; }
  $h.='</div><div class="ic-upl-row">';
  if($custom) $h.='<span class="ic-custom" title="Icono propio"><img src="'.htmlspecialchars($val).'" alt=""></span>';
  $h.='<label class="pf-upl pf-upl-sm">Subir icono propio<input type="file" name="img['.$id.']" accept=".svg,.png,image/*"></label><small class="pf-hint">SVG o PNG con fondo transparente</small></div></div>';
  return $h; }
function colorfield($id,$val){ $val=(string)$val; $pr=['#182943'=>'Navy','#2563EB'=>'Azul','#e0a13c'=>'Acento','#0f1c30'=>'Navy oscuro','#ffffff'=>'Blanco']; $h='<div class="cc" data-cc><input type="hidden" name="b['.$id.'][es]" value="'.htmlspecialchars($val).'" class="cc-val"><div class="cc-sw"><button type="button" class="cc-b'.($val===''?' on':'').'" data-c="">Auto</button>'; foreach($pr as $hex=>$nm){ $h.='<button type="button" class="cc-b'.(strtolower($val)===strtolower($hex)?' on':'').'" data-c="'.$hex.'" style="--sw:'.$hex.'" title="'.$nm.'"></button>'; } $h.='<input type="color" class="cc-cust" value="'.($val!==''&&$val[0]==='#'?htmlspecialchars($val):'#000000').'"></div></div>'; return $h; }
function stylectl($id,$metaJson,$type){ if(in_array($type,['icon','color']))return ''; $m=json_decode((string)$metaJson,true); if(!is_array($m))$m=[]; $g=function($k)use($m){return $m[$k]??'';};
  ob_start(); ?>
  <div class="pf-style"><span class="pf-style-t">Estilo</span><div class="pf-style-b">
  <?php if($type==='button'||$type==='link'): ?>
    <?=colorctl("m[$id][bg]",$g('bg'),['#2563EB'=>'Azul','#182943'=>'Navy','#e0a13c'=>'Acento','#ffffff'=>'Blanco'],'Fondo')?>
    <?=colorctl("m[$id][color]",$g('color'),['#ffffff'=>'Blanco','#182943'=>'Navy'],'Texto')?>
    <?=selctl("m[$id][size]",$g('size'),['' =>'Normal','pequeno'=>'Peque&ntilde;o','grande'=>'Grande'],'Tama&ntilde;o')?>
    <?=selctl("m[$id][radius]",$g('radius'),['' =>'Por defecto','redondo'=>'Redondo','pildora'=>'P&iacute;ldora','cuadrado'=>'Cuadrado'],'Bordes')?>
  <?php elseif($type==='image'): ?>
    <?=selctl("m[$id][radius]",$g('radius'),['' =>'Por defecto','redondo'=>'Redondo','pildora'=>'P&iacute;ldora','cuadrado'=>'Cuadrado'],'Bordes')?>
  <?php else: ?>
    <?=colorctl("m[$id][color]",$g('color'),['#182943'=>'Navy','#2563EB'=>'Azul','#e0a13c'=>'Acento','#ffffff'=>'Blanco','#5b6577'=>'Gris'],'Color')?>
    <?=selctl("m[$id][size]",$g('size'),['' =>'Normal','pequeno'=>'Peque&ntilde;o','grande'=>'Grande','xl'=>'Muy grande'],'Tama&ntilde;o')?>
    <?=selctl("m[$id][align]",$g('align'),['' =>'Por defecto','left'=>'Izquierda','center'=>'Centro','right'=>'Derecha'],'Alineaci&oacute;n')?>
  <?php endif; ?>
  </div></div>
  <?php return ob_get_clean();
}
function pf_field($b,$isLegal){ $id=$b['id']; $t=$b['type']; $adv=($t==='richtext'&&$b['skey']==='body'&&!$isLegal); $wys=($t==='richtext'&&!$adv); ?>
        <div class="pf">
          <label class="pf-l"><?=e($b['label']?:$b['skey'])?></label>
          <?php if($t==='icon'): ?>
            <?=iconfield($id,$b['value_es'])?>
          <?php elseif($t==='color'): ?>
            <?=colorfield($id,$b['value_es'])?>
          <?php elseif($t==='image'): ?>
            <div class="pf-img">
              <div class="pf-thumb" style="<?=$b['value_es']?'background-image:url('.e($b['value_es']).')':''?>"><?=$b['value_es']?'':'Sin imagen'?></div>
              <div class="pf-img-r">
                <label class="pf-upl">Cambiar imagen<input type="file" name="img[<?=$id?>]" accept="image/*" onchange="pfPrev(this)"></label>
                <input type="text" class="pf-in pf-path" name="b[<?=$id?>][es]" value="<?=e($b['value_es'])?>" placeholder="/img/archivo.webp">
              </div>
            </div>
          <?php else: ?>
            <div class="pf-tabs" data-fid="<?=$id?>"><button type="button" class="on" data-l="es">Espanol</button><button type="button" data-l="en">English</button></div>
            <div class="pf-pane" data-fid="<?=$id?>" data-l="es">
              <?php if($wys): ?><div class="pf-wys"></div><textarea class="pf-src hidden" name="b[<?=$id?>][es]"><?=e($b['value_es'])?></textarea>
              <?php elseif($adv): ?><details class="pf-adv"><summary>Editar contenido avanzado (HTML)</summary><textarea class="pf-in pf-code" name="b[<?=$id?>][es]" rows="10"><?=e($b['value_es'])?></textarea></details>
              <?php else: ?><input type="text" class="pf-in" name="b[<?=$id?>][es]" value="<?=e($b['value_es'])?>"><?php endif; ?>
            </div>
            <div class="pf-pane hidden" data-fid="<?=$id?>" data-l="en">
              <?php if($wys): ?><div class="pf-wys"></div><textarea class="pf-src hidden" name="b[<?=$id?>][en]"><?=e($b['value_en'])?></textarea>
              <?php elseif($adv): ?><textarea class="pf-in pf-code" name="b[<?=$id?>][en]" rows="10" placeholder="(opcional) version en ingles"><?=e($b['value_en'])?></textarea>
              <?php else: ?><input type="text" class="pf-in" name="b[<?=$id?>][en]" value="<?=e($b['value_en'])?>"><?php endif; ?>
            </div>
            <?php if($t==='button'||$t==='link'): ?><div class="pf-href"><span>Enlace del boton</span><input type="text" class="pf-in" name="b[<?=$id?>][href]" value="<?=e($b['href'])?>" placeholder="/contacto/ o https://..."></div><?php endif; ?>
          <?php endif; ?>
          <?=stylectl($id,$b['meta']??'',$t)?>
        </div>
      <?php }
?>
<link href="https://cdnjs.cloudflare.com/ajax/libs/quill/1.3.7/quill.snow.min.css" rel="stylesheet">
<div class="ed-top">
  <a href="/admin/paginas.php" class="ed-back">&larr; Paginas</a>
  <div class="ed-top-t"><b><?=e($page['title_es'])?></b><span>/<?=e($page['slug'])?></span></div>
  <div class="ed-top-a"><button type="button" id="edPvOpen" class="btn btn-ghost btn-sm ed-pvtoggle"><svg viewBox="0 0 24 24" width="15" height="15" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="vertical-align:-2px;margin-right:.3rem"><path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7-10-7-10-7z"/><circle cx="12" cy="12" r="3"/></svg>Vista previa</button><a href="/<?=e($page['slug'])?>" target="_blank" class="btn btn-ghost btn-sm">Ver pagina ↗</a></div>
</div>
<?php if(!$blocks): ?>
<div class="card fade-up"><p class="adm-empty">Esta pagina aun no tiene bloques editables.</p></div>
<?php admin_foot(); return; endif; ?>

<form method="post" enctype="multipart/form-data" id="pgform">
<input type="hidden" name="csrf" value="<?=csrf()?>">
<div class="ed-wrap">
  <nav class="ed-nav">
    <p class="ed-nav-tip">Cada boton es una <b>seccion de la pagina</b>, en el mismo orden en que se ve en el sitio. Haz clic para editarla.</p>
    <?php $first=true; foreach($secs as $sec): $m=$SM[$sec]??[ucfirst($sec),'',$SM['body'][2]]; ?>
    <button type="button" class="ed-navi<?=$first?' on':''?>" data-go="s_<?=e($sec)?>">
      <span class="ed-navi-ic"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><?=$m[2]?></svg></span>
      <span><?=e($m[0])?></span>
    </button>
    <?php $first=false; endforeach; ?>
    <button type="button" class="ed-navi" data-go="s_seo">
      <span class="ed-navi-ic"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="7"/><path d="m21 21-4.3-4.3"/></svg></span>
      <span>SEO</span>
    </button>
  </nav>

  <div class="ed-panels">
    <?php $first=true; foreach($groups as $sec=>$items): $m=$SM[$sec]??[ucfirst($sec),'',$SM['body'][2]]; ?>
    <section class="ed-panel<?=$first?' on':''?>" id="s_<?=e($sec)?>">
      <header class="ed-phead"><span class="ed-phead-ic"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><?=$m[2]?></svg></span><div><h2><?=e($m[0])?></h2><p><?=e($m[1])?></p></div></header>
      <div class="ed-fields">
      <?php $done=[]; $cards=''; foreach($items as $b):
        if(preg_match('/^([a-z]+\d+)_/',$b['skey'],$cm)):
          $cp=$cm[1]; if(isset($done[$cp])) continue; $done[$cp]=1;
          $cf=array_values(array_filter($items,function($x)use($cp){return strpos($x['skey'],$cp.'_')===0;}));
          $bg='';$icon='';$ttl='';$txt='';
          foreach($cf as $x){ $sk=$x['skey']; if(substr($sk,-3)==='_bg')$bg=$x['value_es']; if(substr($sk,-5)==='_icon')$icon=$x['value_es']; if(substr($sk,-6)==='_title')$ttl=$x['value_es']; if(substr($sk,-5)==='_text'&&$txt==='')$txt=$x['value_es']; }
          $lbl=$ttl!==''?$ttl:($txt!==''?$txt:$cp);
          ob_start(); ?>
          <div class="pf-card">
            <div class="pf-card-prev<?=$bg?'':' pf-card-prev-light'?>" style="<?=$bg?'background:'.e($bg):''?>"><span class="pf-card-ic"><?=render_icon($icon?:'star')?></span><b><?=e(mb_strimwidth($lbl,0,32,'…'))?></b></div>
            <div class="pf-card-fields"><?php foreach($cf as $x) pf_field($x,$isLegal); ?></div>
          </div>
          <?php $cards.=ob_get_clean();
        else: pf_field($b,$isLegal); endif;
      endforeach;
      if($cards!==''): ?><div class="pf-cardgrid"><?=$cards?></div><?php endif; ?>
      </div>
    </section>
    <?php $first=false; endforeach; ?>

    <section class="ed-panel" id="s_seo">
      <header class="ed-phead"><span class="ed-phead-ic"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="7"/><path d="m21 21-4.3-4.3"/></svg></span><div><h2>SEO y buscadores</h2><p>Como aparece esta pagina en Google.</p></div></header>
      <div class="ed-fields">
        <div class="pf"><label class="pf-l">Titulo en Google (ES)</label><input type="text" class="pf-in" name="seo[title_es]" value="<?=e($page['seo_title_es'])?>"></div>
        <div class="pf"><label class="pf-l">Descripcion en Google (ES)</label><textarea class="pf-in" name="seo[desc_es]" rows="2"><?=e($page['seo_desc_es'])?></textarea></div>
        <div class="pf"><label class="pf-l">Titulo en Google (EN)</label><input type="text" class="pf-in" name="seo[title_en]" value="<?=e($page['seo_title_en'])?>"></div>
        <div class="pf"><label class="pf-l">Descripcion en Google (EN)</label><textarea class="pf-in" name="seo[desc_en]" rows="2"><?=e($page['seo_desc_en'])?></textarea></div>
        <label class="pf-check"><input type="checkbox" name="seo[noindex]" <?=$page['noindex']?'checked':''?>> Ocultar esta pagina de Google (noindex)</label>
      </div>
    </section>
  </div>
</div>

<div class="pg2-save"><span class="pg2-save-t">Los cambios se publican al guardar</span><button class="btn" id="pgsave">Guardar cambios</button></div>
</form>
<style>
/* El ancho del panel y el hueco que deja se toman de la misma variable:
   si no coinciden, la cabecera del panel queda debajo de la vista previa. */
:root{--pvw:min(42vw,760px)}
.ed-pv{position:fixed;top:0;right:0;width:var(--pvw);height:100vh;background:#fff;box-shadow:-6px 0 30px rgba(15,25,50,.14);z-index:1200;display:flex;flex-direction:column;overflow:hidden;transform:translateX(101%);transition:transform .28s ease}
body.pv-on .ed-pv{transform:none}
body.pv-on main{padding-right:var(--pvw)}
/* Con la vista previa abierta el espacio es estrecho: el indice de secciones
   pasa a barra horizontal para que el formulario use todo el ancho. */
body.pv-on .ed-wrap{grid-template-columns:1fr}
body.pv-on .ed-nav{position:static;flex-direction:row;flex-wrap:wrap;gap:.35rem}
body.pv-on .ed-navi{width:auto}
body.pv-on .pf-cardgrid{grid-template-columns:1fr}
.ed-pvtoggle{border-color:#0f1f3a}
.ed-nav-tip{font-size:.78rem;line-height:1.45;color:#7a849a;padding:.5rem .7rem .7rem;margin:0;border-bottom:1px solid #eef1f6;margin-bottom:.35rem}
.ed-nav-tip b{color:#3a4459}
body.pv-on .ed-nav-tip{flex:1 1 100%;border-bottom:0;padding-bottom:.4rem;margin-bottom:.2rem}
body.pv-on .ed-pvtoggle{background:#0f1f3a;color:#fff}
.ed-pvbar{display:flex;align-items:center;gap:.55rem;padding:.55rem .9rem;border-bottom:1px solid #eef1f6;background:#f8fafc;flex:0 0 auto}
.ed-pvbar b{font-size:.9rem;color:#0f1f3a}
.ed-pvhint{font-size:.75rem;color:#9aa3b2;margin-right:auto}
.ed-pvx{background:none;border:0;font-size:1.15rem;line-height:1;cursor:pointer;color:#8a93a5}
.ed-pvscroll{flex:1 1 0;min-height:0;overflow-y:auto;overflow-x:hidden;background:#fff;-webkit-overflow-scrolling:touch}
#edPvFrame{display:block;width:100%;border:0;background:#fff;pointer-events:none}
@media(max-width:1100px){:root{--pvw:100vw}body.pv-on main{padding-right:0}}
</style>
<div id="edPv" class="ed-pv">
  <div class="ed-pvbar"><b>Vista previa en vivo</b><span class="ed-pvhint">Clic en una seccion (izquierda) para saltar a ella. Se actualiza al guardar.</span><button type="button" id="edPvReload" class="btn btn-ghost btn-sm">Refrescar</button><a href="<?=$page['slug']===''?'/':($page['slug']==='__global'?'/oficina-privada/':'/'.e($page['slug']).'/')?>" target="_blank" class="btn btn-ghost btn-sm">Abrir &#8599;</a><button type="button" id="edPvClose" class="ed-pvx" title="Cerrar">&times;</button></div>
  <div class="ed-pvscroll" id="edPvScroll"><iframe id="edPvFrame" src="<?=$page['slug']===''?'/':($page['slug']==='__global'?'/oficina-privada/':'/'.e($page['slug']).'/')?>?pv=1" title="Vista previa" scrolling="no"></iframe></div>
</div>
<script>
(function(){
 var body=document.body,frame=document.getElementById('edPvFrame'),scr=document.getElementById('edPvScroll');
 function op(){body.classList.add('pv-on');fit();} function cl(){body.classList.remove('pv-on');}
 var o=document.getElementById('edPvOpen'),c=document.getElementById('edPvClose'),r=document.getElementById('edPvReload');
 function fit(){try{var d=frame.contentDocument;if(d&&d.body){frame.style.height=Math.max(d.body.scrollHeight,d.documentElement.scrollHeight)+'px';}}catch(e){}}
 frame.addEventListener('load',function(){fit();setTimeout(fit,400);setTimeout(fit,1200);});
 window.addEventListener('resize',fit);
 if(o)o.onclick=function(){ if(body.classList.contains('pv-on'))cl(); else op(); }; if(c)c.onclick=cl; if(r)r.onclick=function(){try{frame.contentWindow.location.reload();}catch(e){frame.src=frame.src;}};
 function offTop(el){var y=0;while(el){y+=el.offsetTop;el=el.offsetParent;}return y;}
 document.querySelectorAll('.ed-navi').forEach(function(b){b.addEventListener('click',function(){var go=(b.getAttribute('data-go')||'').replace(/^s_/,'');if(!body.classList.contains('pv-on'))return;setTimeout(function(){try{fit();var doc=frame.contentDocument;if(!doc)return;var el=doc.querySelector('[data-pv="'+go+'"]')||doc.getElementById(go)||doc.querySelector('[data-pv]');if(el){scr.scrollTo({top:Math.max(0,offTop(el)-90),behavior:'smooth'});el.classList.add('pv-flash');setTimeout(function(){el.classList.remove('pv-flash');},1700);}}catch(e){}},160);});});
 if(window.innerWidth>=1300)op();
})();
</script>


<script src="https://cdnjs.cloudflare.com/ajax/libs/quill/1.3.7/quill.min.js"></script>
<script>
// navegacion de secciones
document.querySelectorAll('.ed-navi').forEach(function(n){
  n.addEventListener('click',function(){
    document.querySelectorAll('.ed-navi').forEach(function(x){x.classList.toggle('on',x===n);});
    var id=n.dataset.go;
    document.querySelectorAll('.ed-panel').forEach(function(p){p.classList.toggle('on',p.id===id);});
    document.querySelector('.ed-panels').scrollTo({top:0,behavior:'smooth'});
  });
});
// pestañas ES/EN
document.querySelectorAll('.pf-tabs').forEach(function(t){var fid=t.dataset.fid;
  t.querySelectorAll('button').forEach(function(btn){btn.addEventListener('click',function(){
    t.querySelectorAll('button').forEach(function(b){b.classList.toggle('on',b===btn);});
    document.querySelectorAll('.pf-pane[data-fid="'+fid+'"]').forEach(function(p){p.classList.toggle('hidden',p.dataset.l!==btn.dataset.l);});
  });});
});
// WYSIWYG
var TB=[['bold','italic','underline'],[{header:2},{header:3}],[{list:'ordered'},{list:'bullet'}],['link'],['clean']];
var editors=[];
document.querySelectorAll('.pf-wys').forEach(function(el){var src=el.nextElementSibling;var q=new Quill(el,{theme:'snow',modules:{toolbar:TB}});q.root.innerHTML=src.value;editors.push({q:q,src:src});});
function pfPrev(inp){if(!inp.files||!inp.files[0])return;var r=new FileReader();var thumb=inp.closest('.pf-img').querySelector('.pf-thumb');r.onload=function(e){thumb.style.backgroundImage='url('+e.target.result+')';thumb.textContent='';};r.readAsDataURL(inp.files[0]);}
document.querySelectorAll('[data-cc]').forEach(function(cc){var val=cc.querySelector('.cc-val');cc.querySelectorAll('.cc-b').forEach(function(b){b.addEventListener('click',function(){val.value=b.dataset.c;cc.querySelectorAll('.cc-b').forEach(function(x){x.classList.toggle('on',x===b);});});});var cust=cc.querySelector('.cc-cust');if(cust)cust.addEventListener('input',function(){val.value=cust.value;cc.querySelectorAll('.cc-b').forEach(function(x){x.classList.remove('on');});});});
document.querySelectorAll('[data-icp]').forEach(function(ip){var val=ip.previousElementSibling;ip.querySelectorAll('.ic-b').forEach(function(b){b.addEventListener('click',function(){val.value=b.dataset.k;ip.querySelectorAll('.ic-b').forEach(function(x){x.classList.toggle('on',x===b);});});});});
document.getElementById('pgform').addEventListener('submit',function(){editors.forEach(function(ed){ed.src.value=ed.q.root.innerHTML;});});
</script>
<?php admin_foot();
