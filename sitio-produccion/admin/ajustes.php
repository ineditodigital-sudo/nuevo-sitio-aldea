<?php require __DIR__.'/_init.php';
$pdo=cms_pdo();
$keys=['site_name'=>'Nombre del sitio','phone'=>'Telefono','email'=>'Correo de contacto','gtm_id'=>'Google Tag Manager ID','ga4_property_id'=>'GA4 Property ID','gsc_site_url'=>'Search Console URL','facebook'=>'Facebook','instagram'=>'Instagram','tiktok'=>'TikTok'];
if($_SERVER['REQUEST_METHOD']==='POST' && csrf_ok()){
  $st=$pdo->prepare("INSERT INTO settings (skey,value) VALUES (?,?) ON DUPLICATE KEY UPDATE value=VALUES(value)");
  foreach($keys as $k=>$l) $st->execute([$k,trim($_POST[$k]??'')]);
  flash('Ajustes guardados.'); header('Location: '.$_SERVER['SCRIPT_NAME']); exit;
}
$cur=[]; foreach($pdo->query("SELECT skey,value FROM settings") as $r) $cur[$r['skey']]=$r['value'];
admin_head('ajustes','Ajustes del sitio');
echo '<div class="card fade-up"><form method="post"><input type="hidden" name="csrf" value="'.csrf().'"><div class="form-grid">';
foreach($keys as $k=>$l){ echo '<div class="field"><label>'.e($l).'</label><input type="text" name="'.$k.'" value="'.e($cur[$k]??'').'"></div>'; }
echo '</div><div class="form-actions"><button class="btn">Guardar cambios</button></div></form></div>';
admin_foot();
