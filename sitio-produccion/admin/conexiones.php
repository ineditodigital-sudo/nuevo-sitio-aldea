<?php require __DIR__.'/_init.php'; require_once __DIR__.'/google_lib.php';
if($_SERVER['REQUEST_METHOD']==='POST' && csrf_ok()){
  if(($_POST['_disconnect']??'')==='1'){ g_disconnect(); flash('Desconectado de Google.'); }
  else { foreach(['google_client_id','google_client_secret','ga4_property_id','gsc_site_url'] as $k) g_set($k,trim($_POST[$k]??'')); flash('Datos guardados.'); }
  header('Location: '.$_SERVER['SCRIPT_NAME']); exit;
}
$cid=g_get('google_client_id'); $cs=g_get('google_client_secret'); $conn=g_connected(); $ru=g_redirect_uri();
admin_head('conexiones','Conexiones');
?>
<div class="adm-help"><span class="adm-help-ic">i</span><span>Conecta Google Analytics 4 y Search Console <b>una sola vez</b> para ver las metricas dentro del panel. La conexion se hace con botones, sin tocar codigo. Solo el primer paso (crear las claves) se hace en Google Cloud.</span></div>

<div class="conx-grid">
  <section class="adm-card">
    <div class="adm-card-h"><h2>Estado de la conexion</h2></div>
    <?php if($conn): ?>
      <div class="conx-status ok"><span class="conx-badge on">Conectado</span> Google esta conectado. La seccion de Analitica ya muestra datos reales de GA4 y Search Console.</div>
      <form method="post" style="margin-top:1rem"><input type="hidden" name="csrf" value="<?=csrf()?>"><button class="btn btn-del" name="_disconnect" value="1" onclick="return confirm('¿Desconectar Google?')">Desconectar</button></form>
    <?php elseif($cid && $cs): ?>
      <div class="conx-status"><span class="conx-badge off">Sin conectar</span> Las claves estan guardadas. Ahora pulsa el boton para autorizar con tu cuenta de Google.</div>
      <a class="btn conx-gbtn" href="<?=e(g_auth_url())?>"><svg viewBox="0 0 24 24" width="18" height="18"><path fill="#fff" d="M12 11v2.8h4.6c-.2 1.2-1.5 3.5-4.6 3.5-2.8 0-5-2.3-5-5.1s2.2-5.1 5-5.1c1.6 0 2.6.7 3.2 1.2l2.2-2.1C17.9 4.5 15.7 3.5 13 3.5 7.9 3.5 3.8 7.6 3.8 12.7s4.1 9.2 9.2 9.2c5.3 0 8.8-3.7 8.8-9 0-.6-.1-1-.2-1.5H12z"/></svg> Conectar con Google</a>
    <?php else: ?>
      <div class="conx-status"><span class="conx-badge off">Falta configurar</span> Primero pega el Client ID y Client Secret (abajo), guarda, y aparecera el boton "Conectar con Google".</div>
    <?php endif; ?>
  </section>

  <section class="adm-card">
    <div class="adm-card-h"><h2>Como obtener las claves (una vez)</h2><span>En Google Cloud — quien tenga acceso a la cuenta de Google</span></div>
    <ol class="conx-steps">
      <li>Entra a <b>console.cloud.google.com</b> y crea (o elige) un proyecto.</li>
      <li>Activa las APIs: <b>Google Analytics Data API</b> y <b>Search Console API</b>.</li>
      <li>En "Credenciales" crea un <b>ID de cliente de OAuth</b> tipo "Aplicacion web".</li>
      <li>En "URIs de redireccion autorizados" pega exactamente:<br><code class="conx-code"><?=e($ru)?></code><br><small>(al pasar a produccion, agrega tambien la de aldea.work)</small></li>
      <li>Copia el <b>Client ID</b> y el <b>Client Secret</b> y pegalos aqui abajo.</li>
    </ol>
  </section>
</div>

<section class="adm-card" style="margin-top:1.2rem">
  <div class="adm-card-h"><h2>Claves y propiedades</h2></div>
  <form method="post"><input type="hidden" name="csrf" value="<?=csrf()?>">
    <div class="crud-edit-grid">
      <div class="field"><label>Google Client ID <span class="tip" data-tip="Se genera en Google Cloud > Credenciales > ID de cliente OAuth (Aplicacion web).">i</span></label><input type="text" name="google_client_id" value="<?=e($cid)?>" placeholder="xxxx.apps.googleusercontent.com"></div>
      <div class="field"><label>Google Client Secret</label><input type="text" name="google_client_secret" value="<?=e($cs)?>" placeholder="GOCSPX-..."></div>
      <div class="field"><label>GA4 Property ID <span class="tip" data-tip="Solo el numero. En GA4: Administrar > Detalles de la propiedad. Ej. 493812345.">i</span></label><input type="text" name="ga4_property_id" value="<?=e(g_get('ga4_property_id'))?>" placeholder="493812345"></div>
      <div class="field"><label>Search Console — URL de la propiedad <span class="tip" data-tip="Tal cual aparece en Search Console. Para dominio: sc-domain:aldea.work. Para prefijo: https://aldea.work/">i</span></label><input type="text" name="gsc_site_url" value="<?=e(g_get('gsc_site_url'))?>" placeholder="sc-domain:aldea.work"></div>
    </div>
    <div class="crud-actions"><div></div><div class="crud-actions-r"><button class="btn">Guardar</button></div></div>
  </form>
</section>
<?php admin_foot(); ?>
