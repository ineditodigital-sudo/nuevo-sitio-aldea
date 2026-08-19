<?php require_once __DIR__.'/_init.php';
function crud_upload($f){
  if(empty($_FILES[$f]) || $_FILES[$f]['error']!==UPLOAD_ERR_OK) return null;
  $rel='/uploads/'.date('Y').'/'.date('m'); $dir=$_SERVER['DOCUMENT_ROOT'].$rel; @mkdir($dir,0755,true);
  $base=preg_replace('/[^a-z0-9]+/i','-',pathinfo($_FILES[$f]['name'],PATHINFO_FILENAME));
  $ext=strtolower(pathinfo($_FILES[$f]['name'],PATHINFO_EXTENSION)) ?: 'jpg';
  $name=trim($base,'-').'-'.substr(md5(uniqid('',true)),0,6).'.'.$ext;
  if(move_uploaded_file($_FILES[$f]['tmp_name'],$dir.'/'.$name)){
    try{ cms_pdo()->prepare("INSERT INTO media (filename,path,bytes) VALUES (?,?,?)")->execute([$name,$rel.'/'.$name,filesize($dir.'/'.$name)]); }catch(Throwable $e){}
    return $rel.'/'.$name;
  }
  return null;
}
function crud_upload_multi($f){ $out=[]; if(empty($_FILES[$f])||!is_array($_FILES[$f]['name']))return $out;
  $rel='/uploads/'.date('Y').'/'.date('m'); $dir=$_SERVER['DOCUMENT_ROOT'].$rel; @mkdir($dir,0755,true);
  foreach($_FILES[$f]['name'] as $i=>$nm){ if(($_FILES[$f]['error'][$i]??1)!==UPLOAD_ERR_OK)continue;
    $base=preg_replace('/[^a-z0-9]+/i','-',pathinfo($nm,PATHINFO_FILENAME)); $ext=strtolower(pathinfo($nm,PATHINFO_EXTENSION))?:'jpg';
    $name=trim($base,'-').'-'.substr(md5(uniqid('',true)),0,6).'.'.$ext;
    if(move_uploaded_file($_FILES[$f]['tmp_name'][$i],$dir.'/'.$name)){ try{ cms_pdo()->prepare("INSERT INTO media (filename,path,bytes) VALUES (?,?,?)")->execute([$name,$rel.'/'.$name,filesize($dir.'/'.$name)]); }catch(Throwable $e){} $out[]=$rel.'/'.$name; }
  }
  return $out;
}
function tip($text){ if($text==='')return ''; return ' <span class="tip" tabindex="0" data-tip="'.htmlspecialchars($text,ENT_QUOTES).'">i</span>'; }
function crud_field($f,$def,$row){
  $v=array_key_exists($f,$row)?$row[$f]:(isset($_GET[$f])?$_GET[$f]:($def['default']??'')); $lab=$def['label']??$f; $t=$def['type']; $hint=$def['hint']??'';
  $isEN=substr($f,-3)==='_en';
  echo '<div class="field'.($isEN?' field-en':'').'">';
  if($t==='check'){ echo '<label class="check"><input type="checkbox" name="'.$f.'" value="1"'.($v?' checked':'').'> '.e($lab).tip($hint).'</label></div>'; return; }
  echo '<label>'.e($lab).tip($hint).'</label>';
  if($t==='text') echo '<input type="text" name="'.$f.'" value="'.e($v).'">';
  elseif($t==='number') echo '<input type="number" name="'.$f.'" value="'.e($v).'">';
  elseif($t==='textarea') echo '<textarea name="'.$f.'" rows="'.($def['rows']??4).'">'.e($v).'</textarea>';
  elseif($t==='select'){ echo '<select name="'.$f.'">'; foreach($def['options'] as $ov=>$ol) echo '<option value="'.e($ov).'"'.((string)$v===(string)$ov?' selected':'').'>'.e($ol).'</option>'; echo '</select>'; }
  elseif($t==='image'){ echo '<div class="pf-img"><div class="pf-thumb" style="'.($v?'background-image:url('.e($v).')':'').'">'.($v?'':'Sin imagen').'</div><div class="pf-img-r"><label class="pf-upl">Cambiar imagen<input type="file" name="'.$f.'" accept="image/*"></label><input type="hidden" name="'.$f.'_keep" value="'.e($v).'">';
    if(!empty($def['alt'])){ $av=$row[$f.'_alt']??''; echo '<input type="text" class="pf-in pf-alt" name="'.$f.'_alt" value="'.e($av).'" placeholder="Texto ALT: describe la imagen (SEO y accesibilidad)">'; }
    echo '</div></div>'; }
  elseif($t==='gallery'){ $imgs=json_decode($v?:'[]',true); if(!is_array($imgs))$imgs=[];
    echo '<div class="gal-ed">'; foreach($imgs as $p){ echo '<div class="gal-it"><img src="'.e($p).'"><input type="hidden" name="'.$f.'_keep[]" value="'.e($p).'"><button type="button" class="gal-rm" title="Quitar" onclick="this.closest(\'.gal-it\').remove()">&times;</button></div>'; }
    echo '</div><label class="pf-upl gal-add">+ Agregar imagenes<input type="file" name="'.$f.'[]" accept="image/*" multiple></label><small class="pf-hint">Puedes seleccionar varias a la vez. Quita las que no quieras con la X.</small>'; }
  elseif($t==='servicematrix'){ $sid=$row['id']??0;
    $locs=cms_pdo()->query("SELECT id,name,city_es FROM locations ORDER BY sort,id")->fetchAll();
    $cur=[]; if($sid){ foreach(cms_pdo()->query("SELECT * FROM service_locations WHERE solution_id=".(int)$sid) as $r)$cur[$r['location_id']]=$r; }
    if(!$sid){ echo '<p class="svc-note">Guarda primero el servicio para asignar precios por sucursal.</p>'; }
    else { echo '<div class="svc-matrix">';
      foreach($locs as $l){ $c=$cur[$l['id']]??null; $av=$c?$c['available']:0; $pr=$c?$c['price']:'';
        echo '<div class="svc-row'.($av?' on':'').'"><label class="svc-av"><input type="checkbox" name="svc['.$l['id'].'][available]" value="1"'.($av?' checked':'').'><span><b>'.e($l['name']).'</b><small>'.e($l['city_es']).'</small></span></label><div class="svc-pr"><span>$</span><input type="text" name="svc['.$l['id'].'][price]" value="'.e($pr).'" placeholder="0,000"></div></div>'; }
      echo '</div>'; }
  }
  elseif($t==='wysiwyg'){ echo '<div class="cf-wys"></div><textarea class="cf-wys-src hidden" name="'.$f.'">'.e($v).'</textarea>'; }
  if($isEN) echo '<small class="field-note field-note-en"><b>Ojo:</b> las traducciones no son automaticas. Escribe aqui el ingles. Si lo dejas vacio, se mostrara el espanol.</small>';
  echo '</div>';
}

function crud_run($cfg){
  $pdo=cms_pdo(); $t=$cfg['table']; $fields=$cfg['fields']; $self=$_SERVER['SCRIPT_NAME'];
  $action=$_GET['a']??'list'; $id=(int)($_GET['id']??0);
  if($_SERVER['REQUEST_METHOD']==='POST' && csrf_ok()){
    if(($_POST['_delete']??'')==='1' && $id){ $pdo->prepare("DELETE FROM `$t` WHERE id=?")->execute([$id]); flash('Registro eliminado.'); header("Location: $self"); exit; }
    $cols=[];$vals=[];
    foreach($fields as $f=>$def){
      if($def['type']==='servicematrix') continue;
      $cols[]=$f;
      if($def['type']==='image'){ $up=crud_upload($f); $vals[]=$up!==null?$up:($_POST[$f.'_keep']??''); if(!empty($def['alt'])){ $cols[]=$f.'_alt'; $vals[]=$_POST[$f.'_alt']??''; } }
      elseif($def['type']==='gallery'){ $keep=$_POST[$f.'_keep']??[]; if(!is_array($keep))$keep=[]; $up=crud_upload_multi($f); $vals[]=json_encode(array_values(array_merge($keep,$up)),JSON_UNESCAPED_SLASHES|JSON_UNESCAPED_UNICODE); }
      elseif($def['type']==='check'){ $vals[]=!empty($_POST[$f])?1:0; }
      else { $vals[]=$_POST[$f]??''; }
    }
    if($id){ $set=implode(',',array_map(fn($c)=>"`$c`=?",$cols)); $vals[]=$id; $pdo->prepare("UPDATE `$t` SET $set WHERE id=?")->execute($vals); $sid=$id; flash('Cambios guardados.'); }
    else { $cc=implode(',',array_map(fn($c)=>"`$c`",$cols)); $ph=implode(',',array_fill(0,count($cols),'?')); $pdo->prepare("INSERT INTO `$t` ($cc) VALUES ($ph)")->execute($vals); $sid=(int)$pdo->lastInsertId(); flash('Registro creado.'); }
    if(isset($_POST['svc']) && !empty($sid)){
      $pdo->prepare("DELETE FROM service_locations WHERE solution_id=?")->execute([$sid]);
      $sins=$pdo->prepare("INSERT INTO service_locations (solution_id,location_id,price,available) VALUES (?,?,?,?)");
      foreach($_POST['svc'] as $lid=>$d){ $av=!empty($d['available'])?1:0; $pr=trim($d['price']??''); if($av||$pr!=='') $sins->execute([$sid,(int)$lid,$pr,$av]); }
    }
    header("Location: $self"); exit;
  }
  admin_head($cfg['active'],$cfg['title']);
  if(!empty($cfg['help'])) echo '<div class="adm-help"><span class="adm-help-ic">i</span><span>'.$cfg['help'].'</span></div>';
  if($action==='edit'||$action==='new'){
    $row=$id?$pdo->query("SELECT * FROM `$t` WHERE id=$id")->fetch():[];
    echo '<div class="crud-edit fade-up"><div class="crud-edit-head"><a href="'.$self.'" class="adm-back">&larr; '.e($cfg['title']).'</a><h2>'.($id?'Editar registro':'Nuevo registro').'</h2></div>';
    echo '<form method="post" enctype="multipart/form-data"><input type="hidden" name="csrf" value="'.csrf().'">';
    echo '<div class="crud-edit-card"><div class="crud-edit-grid">';
    foreach($fields as $f=>$def) crud_field($f,$def,$row);
    echo '</div></div>';
    echo '<div class="crud-actions"><div class="crud-actions-l">';
    if($id) echo '<button class="btn btn-del" name="_delete" value="1" onclick="return confirm(\'¿Eliminar este registro?\')">Eliminar</button>';
    echo '</div><div class="crud-actions-r"><a class="btn btn-ghost" href="'.$self.'">Cancelar</a> <button class="btn">Guardar cambios</button></div></div>';
    echo '</form></div>';
    if(strpos(json_encode($fields),'"wysiwyg"')!==false){
      echo '<link href="https://cdnjs.cloudflare.com/ajax/libs/quill/1.3.7/quill.snow.min.css" rel="stylesheet"><script src="https://cdnjs.cloudflare.com/ajax/libs/quill/1.3.7/quill.min.js"></script>';
      echo '<script>(function(){var eds=[];document.querySelectorAll(".cf-wys").forEach(function(el){var src=el.nextElementSibling;var q=new Quill(el,{theme:"snow",modules:{toolbar:[[{header:[2,3,false]}],["bold","italic","underline"],[{list:"ordered"},{list:"bullet"}],["blockquote","link","image"],["clean"]]}});q.root.innerHTML=src.value;q.getModule("toolbar").addHandler("image",function(){var inp=document.createElement("input");inp.type="file";inp.accept="image/*";inp.onchange=function(){if(!inp.files[0])return;var fd=new FormData();fd.append("file",inp.files[0]);fetch("/admin/upload.php",{method:"POST",body:fd}).then(function(r){return r.json();}).then(function(d){if(d.url){var range=q.getSelection(true)||{index:q.getLength()};q.insertEmbed(range.index,"image",d.url);q.setSelection(range.index+1);}else{alert("No se pudo subir la imagen");}});};inp.click();});eds.push({q:q,src:src});});var form=document.querySelector(".crud-edit form");if(form)form.addEventListener("submit",function(){eds.forEach(function(e){e.src.value=e.q.root.innerHTML;});});})();</script>';
    }
  } else {
    $rows=$pdo->query("SELECT * FROM `$t` ORDER BY ".($cfg['order']??'id DESC'))->fetchAll();
    echo '<div class="crud-bar"><span class="crud-bar-t">'.count($rows).' '.e(mb_strtolower($cfg['title'])).'</span><a class="btn" href="?a=new">+ Nuevo</a></div>';
    if(!$rows){ echo '<div class="adm-card"><p class="adm-empty">Aun no hay registros. Crea el primero con "+ Nuevo".</p></div>'; }
    else{
      $imgcol=null;$titlecol=null;$metacols=[];
      foreach($cfg['list'] as $col=>$lab){
        if(($fields[$col]['type']??'')==='image' && $imgcol===null){ $imgcol=$col; continue; }
        if($titlecol===null){ $titlecol=$col; continue; }
        $metacols[$col]=$lab;
      }
      $fit=$cfg['img_fit']??'cover';
      echo '<div class="crud-cards fade-up">';
      foreach($rows as $r){
        echo '<a class="crud-card" href="?a=edit&id='.$r['id'].'">';
        if($imgcol!==null){ $iv=$r[$imgcol]??''; echo $iv? '<div class="crud-card-img" style="background-image:url('.e($iv).');background-size:'.$fit.'"></div>' : '<div class="crud-card-img crud-card-noimg">Sin imagen</div>'; }
        echo '<div class="crud-card-b">';
        if(array_key_exists('published',$r)) echo '<span class="crud-badge '.($r['published']?'on':'off').'">'.($r['published']?'Publicado':'Oculto').'</span>';
        echo '<h3>'.e(mb_strimwidth((string)($r[$titlecol]??'—'),0,52,'…')).'</h3>';
        foreach($metacols as $col=>$lab){ $v=$r[$col]??''; if($v==='')continue; echo '<span class="crud-m"><b>'.e($lab).':</b> '.e(mb_strimwidth((string)$v,0,48,'…')).'</span>'; }
        echo '</div><span class="crud-card-go">Editar &rarr;</span></a>';
      }
      echo '</div>';
    }
  }
  admin_foot();
}
