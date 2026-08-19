<?php require __DIR__.'/_init.php';
$pdo=cms_pdo();
if($_SERVER['REQUEST_METHOD']==='POST' && csrf_ok()){
  $st=$pdo->prepare("UPDATE locations SET price_privada=?,price_cowork=?,price_virtual=? WHERE id=?");
  foreach(($_POST['loc']??[]) as $id=>$p){ $st->execute([trim($p['privada']??''),trim($p['cowork']??''),trim($p['virtual']??''),(int)$id]); }
  flash('Precios actualizados.'); header('Location: '.$_SERVER['SCRIPT_NAME']); exit;
}
$locs=$pdo->query("SELECT * FROM locations ORDER BY sort,id")->fetchAll();
admin_head('precios','Precios por ciudad');
if(!$locs){ echo '<p class="adm-empty">Aun no hay ubicaciones. Crea sedes en el modulo Ubicaciones.</p>'; admin_foot(); return; }
echo '<div class="card fade-up"><form method="post"><input type="hidden" name="csrf" value="'.csrf().'"><table class="adm-tbl"><thead><tr><th>Sede</th><th>Oficina privada</th><th>Coworking</th><th>Domicilio virtual</th></tr></thead><tbody>';
foreach($locs as $l){ $i=$l['id'];
  echo '<tr><td><b>'.e($l['name']).'</b><br><small>'.e($l['city_es']).'</small></td>';
  echo '<td><input class="pinput" name="loc['.$i.'][privada]" value="'.e($l['price_privada']).'"></td>';
  echo '<td><input class="pinput" name="loc['.$i.'][cowork]" value="'.e($l['price_cowork']).'"></td>';
  echo '<td><input class="pinput" name="loc['.$i.'][virtual]" value="'.e($l['price_virtual']).'"></td></tr>';
}
echo '</tbody></table><div class="form-actions"><button class="btn">Guardar precios</button></div></form></div>';
admin_foot();
