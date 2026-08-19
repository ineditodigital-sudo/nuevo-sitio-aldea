<?php require __DIR__.'/_init.php'; require_once __DIR__.'/google_lib.php';

// ---------- Pestana activa (Analitica / SEO) ----------
$tab = ((($_GET['tab'] ?? '')==='seo')) ? 'seo' : 'panel';
$pdo = cms_pdo();

// ---------- SEO: gestion de redirecciones 301 (POST antes de imprimir) ----------
if($tab==='seo' && $_SERVER['REQUEST_METHOD']==='POST' && csrf_ok()){
  $rid=(int)($_POST['id'] ?? 0);
  if(($_POST['_delete'] ?? '')==='1' && $rid){
    $pdo->prepare("DELETE FROM redirects WHERE id=?")->execute([$rid]); flash('Redireccion eliminada.');
  } else {
    $from=trim($_POST['from_path'] ?? ''); $to=trim($_POST['to_path'] ?? '');
    $code=((($_POST['code'] ?? '301')==='302')) ? '302' : '301';
    if($from===''||$to===''){ flash('Completa ambas rutas.'); }
    elseif($rid){ $pdo->prepare("UPDATE redirects SET from_path=?,to_path=?,code=? WHERE id=?")->execute([$from,$to,$code,$rid]); flash('Redireccion actualizada.'); }
    else { $pdo->prepare("INSERT INTO redirects (from_path,to_path,code) VALUES (?,?,?)")->execute([$from,$to,$code]); flash('Redireccion creada.'); }
  }
  header('Location: /admin/analitica.php?tab=seo'); exit;
}

// ---------- Rango de fechas ----------
$preset=preg_replace('/[^0-9]/','',$_GET['range']??'28'); if(!in_array($preset,['7','28','90'],true))$preset='28';
$end=date('Y-m-d'); $start=date('Y-m-d',strtotime('-'.$preset.' days')); $custom=false;
if(!empty($_GET['start'])&&!empty($_GET['end'])&&preg_match('/^\d{4}-\d{2}-\d{2}$/',$_GET['start'])&&preg_match('/^\d{4}-\d{2}-\d{2}$/',$_GET['end'])){
  $start=$_GET['start']; $end=$_GET['end']; $custom=true;
}
$rangeLabel = $custom ? ($start.'  →  '.$end) : ('ultimos '.$preset.' dias');
$ndays = max(2,min(120,(int)round((strtotime($end)-strtotime($start))/86400)+1));

function ic($p){ return '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round">'.$p.'</svg>'; }
function fdur($s){ $s=(int)round((float)$s); if($s<=0)return '0s'; $m=intdiv($s,60); $x=$s%60; return $m? ($m.'m '.$x.'s') : ($x.'s'); }
function fnum($n){ return number_format((float)$n); }
function gaK($rep,$i){ return $rep['rows'][0]['metricValues'][$i]['value']??null; }
function gaRows($rep){ return (isset($rep['rows'])&&is_array($rep['rows']))?$rep['rows']:[]; }
function ga_kpi_mock($v){ return ['rows'=>[['metricValues'=>array_map(fn($x)=>['value'=>$x],$v)]]]; }
function ga_rows_mock($pairs){ $rows=[]; foreach($pairs as $p){ $rows[]=['dimensionValues'=>[['value'=>$p[0]]],'metricValues'=>array_map(fn($x)=>['value'=>$x],array_slice($p,1))]; } return ['rows'=>$rows]; }
function gsc_rows_mock($rows){ $o=[]; foreach($rows as $r){ $o[]=['keys'=>[$r[0]],'clicks'=>$r[1],'impressions'=>$r[2],'ctr'=>$r[3],'position'=>$r[4]]; } return ['rows'=>$o]; }

if($tab==='panel'){
$connected=g_connected();
$demo=!$connected;

$sLabels=[];$sUsers=[];$sSess=[];$chL=[];$chV=[];$dvL=[];$dvV=[];$qL=[];$qClk=[];$qImp=[];

if($demo){
  // ---------- DATOS DE EJEMPLO (no reales) ----------
  $gaErr=false; $gscErr=false;
  $gaKpi = ga_kpi_mock([1247,864,1693,4318,134,0.583]);
  $gaChannels = ga_rows_mock([['Organic Search',742],['Direct',498],['Referral',203],['Organic Social',158],['Paid Search',92]]);
  $gaNewRet = ga_rows_mock([['new',864],['returning',383]]);
  $gaDevices = ga_rows_mock([['mobile',1042],['desktop',558],['tablet',93]]);
  $gaPages = ga_rows_mock([['/',1180,168000],['/coworking/',640,92000],['/oficinas-en-renta-queretaro/',512,80000],['/lo-que-ofrecemos/',430,54000],['/ubicaciones/',388,41000],['/oficinas-en-renta-leon-guanajuato/',301,39000],['/domicilio-virtual/',255,28000],['/blog/',214,22000]]);
  $gtot = ['clicks'=>1284,'impressions'=>42800,'ctr'=>0.030,'position'=>12.4];
  $gscQueries = gsc_rows_mock([['coworking queretaro',210,4100,0.051,6.2],['oficinas en renta leon',168,3600,0.046,7.8],['oficina privada aguascalientes',132,2950,0.044,9.1],['coworking san luis potosi',119,2600,0.045,8.4],['domicilio virtual queretaro',98,2100,0.046,10.3],['renta de oficinas bajio',77,1980,0.038,12.7],['aldea networking',66,890,0.074,2.1],['espacios de trabajo flexibles',54,1720,0.031,14.9]]);
  $gscPages = gsc_rows_mock([['https://aldea.work/coworkings-queretaro/',242,5200,0.046,7.1],['https://aldea.work/oficinas-en-renta-leon-guanajuato/',188,4100,0.046,8.3],['https://aldea.work/',150,3800,0.039,9.0],['https://aldea.work/oficinas-en-renta-aguascalientes/',121,2900,0.042,9.8],['https://aldea.work/domicilio-virtual/',97,2200,0.044,11.2]]);
  // series pseudo-aleatorias estables
  mt_srand(20260722);
  for($i=$ndays-1;$i>=0;$i--){ $d=strtotime("-$i days",strtotime($end));
    $wd=(int)date('N',$d); $wk=($wd>=6)?0.55:1.0;
    $u=(int)round((28+mt_rand(0,22))*$wk); $s=(int)round($u*(1.25+mt_rand(0,25)/100));
    $sLabels[]=date('d/m',$d); $sUsers[]=$u; $sSess[]=$s;
    $qL[]=date('d/m',$d); $qClk[]=(int)round((30+mt_rand(0,26))*$wk); $qImp[]=(int)round((900+mt_rand(0,700))*$wk);
  }
  foreach(gaRows($gaChannels) as $r){ $chL[]=$r['dimensionValues'][0]['value']; $chV[]=(int)$r['metricValues'][0]['value']; }
  foreach(gaRows($gaDevices) as $r){ $dvL[]=$r['dimensionValues'][0]['value']; $dvV[]=(int)$r['metricValues'][0]['value']; }
} else {
  // ---------- DATOS REALES ----------
  $gaProp = g_get('ga4_property_id');
  $gaKpi  = $gaProp? ga4_dates($start,$end,['activeUsers','newUsers','sessions','screenPageViews','averageSessionDuration','engagementRate'],[],1) : ['_error'=>'noprop'];
  $gaErr  = !$gaProp || isset($gaKpi['_error']);
  if(!$gaErr){
    $gaSeries   = ga4_dates($start,$end,['activeUsers','sessions'],['date'],400,null,'date');
    $gaChannels = ga4_dates($start,$end,['sessions'],['sessionDefaultChannelGroup'],8,'sessions');
    $gaNewRet   = ga4_dates($start,$end,['activeUsers'],['newVsReturning'],4,'activeUsers');
    $gaDevices  = ga4_dates($start,$end,['sessions'],['deviceCategory'],4,'sessions');
    $gaPages    = ga4_dates($start,$end,['screenPageViews','userEngagementDuration'],['pagePath'],15,'screenPageViews');
    $tmp=[]; foreach(gaRows($gaSeries) as $r){ $d=$r['dimensionValues'][0]['value']; $tmp[$d]=[(int)($r['metricValues'][0]['value']??0),(int)($r['metricValues'][1]['value']??0)]; }
    ksort($tmp); foreach($tmp as $d=>$v){ $sLabels[]=substr($d,4,2).'/'.substr($d,6,2); $sUsers[]=$v[0]; $sSess[]=$v[1]; }
    foreach(gaRows($gaChannels) as $r){ $chL[]=$r['dimensionValues'][0]['value']; $chV[]=(int)$r['metricValues'][0]['value']; }
    foreach(gaRows($gaDevices) as $r){ $dvL[]=$r['dimensionValues'][0]['value']; $dvV[]=(int)$r['metricValues'][0]['value']; }
  }
  $gscSite = g_get('gsc_site_url');
  $gscTot  = $gscSite? gsc_dates($start,$end,[],1) : ['_error'=>'nosite'];
  $gscErr  = !$gscSite || isset($gscTot['_error']);
  $gtot = (!$gscErr && !empty($gscTot['rows'][0]))? $gscTot['rows'][0] : null;
  if(!$gscErr){
    $gscSeries  = gsc_dates($start,$end,['date'],400);
    $gscQueries = gsc_dates($start,$end,['query'],25);
    $gscPages   = gsc_dates($start,$end,['page'],15);
    $tmp=[]; foreach(gaRows($gscSeries) as $r){ $d=$r['keys'][0]??''; $tmp[$d]=[(int)($r['clicks']??0),(int)($r['impressions']??0)]; }
    ksort($tmp); foreach($tmp as $d=>$v){ $qL[]=substr($d,5); $qClk[]=$v[0]; $qImp[]=$v[1]; }
  }
}

} // fin datos panel
admin_head('analitica','SEO y Analitica');
$gaColor='#e8710a'; $gscColor='#1a73e8';
?>
<style>
.an-toolbar{display:flex;align-items:center;justify-content:space-between;gap:1rem;flex-wrap:wrap;margin-bottom:1.3rem}
.an-range{display:flex;gap:.4rem;background:#fff;border:1px solid #e6e9f0;border-radius:12px;padding:.3rem}
.an-range a{padding:.4rem .85rem;border-radius:9px;text-decoration:none;color:#5b667c;font-weight:600;font-size:.88rem}
.an-range a.on{background:#0f1f3a;color:#fff}
.an-custom{display:flex;align-items:center;gap:.4rem;font-size:.85rem;color:#8a93a5}
.an-custom input{border:1px solid #e6e9f0;border-radius:9px;padding:.4rem .5rem;font:inherit;color:#182338}
.an-demo{display:flex;align-items:center;gap:.8rem;background:#fff8e6;border:1px solid #ffe08a;color:#7a5b00;border-radius:14px;padding:.9rem 1.1rem;margin-bottom:1.4rem;font-size:.93rem}
.an-demo .ic{flex:0 0 26px;height:26px;width:26px;border-radius:50%;background:#f0a500;color:#fff;display:flex;align-items:center;justify-content:center;font-weight:800}
.an-demo b{color:#5c4400}
.an-demo a.btn{margin-left:auto;white-space:nowrap}
.an-demobadge{display:inline-block;margin-left:.5rem;font-size:.66rem;font-weight:800;letter-spacing:.04em;color:#a97a00;background:#fff2cc;border:1px solid #ffe08a;border-radius:6px;padding:.08rem .4rem;vertical-align:middle}
.an-wrap-demo{position:relative}
.an-wrap-demo:before{content:"EJEMPLO";position:absolute;inset:0;display:flex;align-items:center;justify-content:center;font-size:2.6rem;font-weight:800;color:rgba(240,165,0,.10);letter-spacing:.3em;pointer-events:none;z-index:2}
.an-sec{display:flex;align-items:center;gap:.6rem;margin:1.8rem 0 1rem;font-size:1.12rem;color:#0f1f3a}
.an-sec small{color:#9aa3b2;font-weight:500;font-size:.8rem}
.an-sec .an-brand{height:26px;width:26px;border-radius:7px;display:flex;align-items:center;justify-content:center;color:#fff}
.an-sec .an-brand svg{width:16px;height:16px}
.an-grid2{display:grid;grid-template-columns:1.5fr 1fr;gap:1.2rem;margin-bottom:1.2rem}
.an-grid3{display:grid;grid-template-columns:1fr 1fr 1fr;gap:1.2rem;margin-bottom:1.2rem}
@media(max-width:900px){.an-grid2,.an-grid3{grid-template-columns:1fr}}
.an-canwrap{position:relative;height:260px}
.an-canwrap.sm{height:210px}
.an-tbl{width:100%;border-collapse:collapse;font-size:.9rem}
.an-tbl th{text-align:left;color:#8a93a5;font-weight:600;font-size:.76rem;text-transform:uppercase;letter-spacing:.03em;padding:.5rem .6rem;border-bottom:1px solid #eef1f6}
.an-tbl td{padding:.55rem .6rem;border-bottom:1px solid #f2f4f8;color:#25324a}
.an-tbl td.num{text-align:right;font-variant-numeric:tabular-nums;white-space:nowrap}
.an-tbl tr:hover td{background:#f8fafc}
.an-kw{max-width:340px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;font-weight:600;color:#182338}
.an-pos{display:inline-block;min-width:34px;text-align:center;padding:.12rem .4rem;border-radius:6px;background:#eef1f6;color:#33415c;font-weight:700;font-size:.82rem}
.an-mini{display:flex;align-items:center;gap:.7rem;padding:.45rem 0}
.an-mini .an-mname{flex:1 1 auto;color:#334;font-weight:500}
.an-mini .an-mbar{flex:0 0 42%;height:8px;background:#eef1f6;border-radius:99px;overflow:hidden}
.an-mini .an-mbar span{display:block;height:100%;background:#3b5bdb;border-radius:99px}
.an-mini b{flex:0 0 auto;min-width:46px;text-align:right;font-variant-numeric:tabular-nums}

/* --- Pestanas SEO/Analitica --- */
.an-tabs{display:flex;gap:.3rem;border-bottom:1px solid #e6e9f0;margin:-.3rem 0 1.5rem}
.an-tab{display:inline-flex;align-items:center;gap:.45rem;padding:.7rem 1.1rem;text-decoration:none;color:#5b667c;font-weight:600;font-size:.94rem;border-bottom:2px solid transparent;margin-bottom:-1px}
.an-tab svg{width:16px;height:16px}
.an-tab.on{color:#0f1f3a;border-bottom-color:#0f1f3a}
.an-grid2seo{display:grid;grid-template-columns:.85fr 1.15fr;gap:1.2rem}
@media(max-width:900px){.an-grid2seo{grid-template-columns:1fr}}
.seo-form{display:flex;flex-direction:column;gap:.9rem}
.seo-form label{display:flex;flex-direction:column;gap:.35rem;font-size:.82rem;color:#5b667c;font-weight:600}
.seo-form input,.seo-form select{border:1px solid #e6e9f0;border-radius:10px;padding:.6rem .7rem;font:inherit;color:#182338}
.seo-form-a{display:flex;gap:.5rem;margin-top:.2rem}
.seo-rowa{white-space:nowrap;text-align:right}
.seo-ed{color:#3b5bdb;text-decoration:none;font-weight:600;font-size:.84rem;margin-right:.7rem}
.seo-del{background:none;border:0;color:#e03131;font:inherit;font-weight:600;font-size:.84rem;cursor:pointer;padding:0}
.seo-info b{font-size:1.4rem;color:#0f1f3a;display:block;margin:.15rem 0}
.seo-info span.sub{color:#8a93a5;font-size:.82rem}
.seo-info a{color:#3b5bdb;text-decoration:none;font-weight:600;font-size:.86rem}
</style>

<div class="an-tabs">
  <a href="?tab=panel" class="an-tab<?=$tab==='panel'?' on':''?>"><?=ic('<path d="M4 20V10M10 20V4M16 20v-8M22 20H2"/>')?>Analitica</a>
  <a href="?tab=seo" class="an-tab<?=$tab==='seo'?' on':''?>"><?=ic('<circle cx="11" cy="11" r="7"/><path d="m21 21-4.3-4.3"/>')?>SEO tecnico</a>
</div>

<?php if($tab==='panel'): ?>
<div class="an-toolbar">
  <div class="an-range">
    <?php $r7=(!$custom&&$preset==='7')?' on':''; $r28=(!$custom&&$preset==='28')?' on':''; $r90=(!$custom&&$preset==='90')?' on':''; ?>
    <a class="<?=$r7?>" href="?range=7">7 dias</a>
    <a class="<?=$r28?>" href="?range=28">28 dias</a>
    <a class="<?=$r90?>" href="?range=90">90 dias</a>
  </div>
  <form class="an-custom" method="get">
    <span>Personalizado:</span>
    <input type="date" name="start" value="<?=e($custom?$start:'')?>">
    <span>a</span>
    <input type="date" name="end" value="<?=e($custom?$end:'')?>">
    <button class="btn btn-ghost" type="submit">Aplicar</button>
  </form>
</div>

<?php if($demo): ?>
<div class="an-demo"><span class="ic">!</span><span><b>Datos de ejemplo (no reales).</b> Esto es una muestra de como se vera el tablero. Los numeros, graficas y busquedas de abajo son <b>ficticios</b>. Conecta Google para ver tus datos reales.</span><a href="/admin/conexiones.php" class="btn">Conectar Google</a></div>
<div class="an-wrap-demo">
<?php endif; ?>

<h2 class="an-sec"><span class="an-brand" style="background:<?=$gaColor?>"><?=ic('<path d="M4 20V10M10 20V4M16 20v-8M22 20H2"/>')?></span>Google Analytics 4 <small><?=e($rangeLabel)?></small><?php if($demo)echo '<span class="an-demobadge">EJEMPLO</span>';?></h2>

<?php if($gaErr): ?>
<div class="adm-help"><span class="adm-help-ic">!</span><span><?=$gaProp?'No se pudieron leer datos de GA4. Revisa el <b>GA4 Property ID</b> en Conexiones y que la cuenta conectada tenga acceso. Detalle: '.e($gaKpi['_msg']??''):'Falta configurar el <b>GA4 Property ID</b> en Conexiones.'?></span></div>
<?php else: ?>
<div class="dash-stats">
  <div class="dash-stat dash-stat-dark"><span class="dash-stat-ic"><?=ic('<path d="M17 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.9"/>')?></span><span class="dash-stat-n"><?=fnum(gaK($gaKpi,0))?></span><span class="dash-stat-l">Usuarios</span></div>
  <div class="dash-stat"><span class="dash-stat-ic"><?=ic('<path d="M12 5v14M5 12h14"/>')?></span><span class="dash-stat-n"><?=fnum(gaK($gaKpi,1))?></span><span class="dash-stat-l">Usuarios nuevos</span></div>
  <div class="dash-stat"><span class="dash-stat-ic"><?=ic('<circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 2"/>')?></span><span class="dash-stat-n"><?=fnum(gaK($gaKpi,2))?></span><span class="dash-stat-l">Sesiones</span></div>
  <div class="dash-stat"><span class="dash-stat-ic"><?=ic('<path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7-10-7-10-7z"/><circle cx="12" cy="12" r="3"/>')?></span><span class="dash-stat-n"><?=fnum(gaK($gaKpi,3))?></span><span class="dash-stat-l">Vistas</span></div>
  <div class="dash-stat"><span class="dash-stat-ic"><?=ic('<circle cx="12" cy="12" r="9"/><path d="M12 8v4l2 2"/>')?></span><span class="dash-stat-n"><?=fdur(gaK($gaKpi,4))?></span><span class="dash-stat-l">Duracion media</span></div>
  <div class="dash-stat"><span class="dash-stat-ic"><?=ic('<path d="m9 11 3 3 8-8"/><path d="M20 12v6a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h9"/>')?></span><span class="dash-stat-n"><?=round(((float)gaK($gaKpi,5))*100,1)?>%</span><span class="dash-stat-l">Interaccion</span></div>
</div>

<div class="an-grid2">
  <section class="adm-card">
    <div class="adm-card-h"><h2>Visitantes por dia</h2><span>Usuarios y sesiones en el periodo</span></div>
    <div class="an-canwrap"><canvas id="cGaSeries"></canvas></div>
  </section>
  <section class="adm-card">
    <div class="adm-card-h"><h2>Adquisicion</h2><span>Sesiones por canal</span></div>
    <div class="an-canwrap sm"><canvas id="cGaChan"></canvas></div>
  </section>
</div>

<div class="an-grid3">
  <section class="adm-card">
    <div class="adm-card-h"><h2>Nuevos vs recurrentes</h2><span>Retencion de usuarios</span></div>
    <?php $nr=gaRows($gaNewRet); $nrTot=0; foreach($nr as $r)$nrTot+=(int)$r['metricValues'][0]['value']; $nrTot=max(1,$nrTot);
      $NRL=['new'=>'Nuevos','returning'=>'Recurrentes','(not set)'=>'Sin definir'];
      if(!$nr) echo '<p class="adm-empty">Sin datos aun.</p>';
      foreach($nr as $r){ $k=$r['dimensionValues'][0]['value']; $c=(int)$r['metricValues'][0]['value']; ?>
      <div class="an-mini"><span class="an-mname"><?=e($NRL[$k]??$k)?></span><span class="an-mbar"><span style="width:<?=round($c/$nrTot*100)?>%"></span></span><b><?=round($c/$nrTot*100)?>%</b></div>
    <?php } ?>
  </section>
  <section class="adm-card">
    <div class="adm-card-h"><h2>Dispositivos</h2><span>Sesiones por dispositivo</span></div>
    <div class="an-canwrap sm"><canvas id="cGaDev"></canvas></div>
  </section>
  <section class="adm-card">
    <div class="adm-card-h"><h2>Resumen</h2><span>Del periodo seleccionado</span></div>
    <div class="an-mini"><span class="an-mname">Usuarios/dia (prom.)</span><b><?=count($sUsers)?fnum(array_sum($sUsers)/max(1,count($sUsers))):'-'?></b></div>
    <div class="an-mini"><span class="an-mname">Vistas/sesion</span><b><?=(float)gaK($gaKpi,2)?round(((float)gaK($gaKpi,3))/max(1,(float)gaK($gaKpi,2)),1):'-'?></b></div>
    <div class="an-mini"><span class="an-mname">Duracion media</span><b><?=fdur(gaK($gaKpi,4))?></b></div>
    <div class="an-mini"><span class="an-mname">Interaccion</span><b><?=round(((float)gaK($gaKpi,5))*100,1)?>%</b></div>
  </section>
</div>

<section class="adm-card" style="margin-bottom:1.2rem">
  <div class="adm-card-h"><h2>Paginas mas vistas</h2><span>Vistas y tiempo medio de interaccion por pagina</span></div>
  <table class="an-tbl"><thead><tr><th>Pagina</th><th style="text-align:right">Vistas</th><th style="text-align:right">Tiempo medio</th></tr></thead><tbody>
  <?php $pr=gaRows($gaPages); if(!$pr) echo '<tr><td colspan="3"><p class="adm-empty">Sin datos aun.</p></td></tr>';
    foreach($pr as $r){ $path=$r['dimensionValues'][0]['value']; $views=(int)$r['metricValues'][0]['value']; $eng=(float)$r['metricValues'][1]['value']; $avg=$views?$eng/$views:0; ?>
    <tr><td class="an-kw" title="<?=e($path)?>"><?=e($path)?></td><td class="num"><?=fnum($views)?></td><td class="num"><?=fdur($avg)?></td></tr>
  <?php } ?>
  </tbody></table>
</section>
<?php endif; ?>

<h2 class="an-sec"><span class="an-brand" style="background:<?=$gscColor?>"><?=ic('<circle cx="11" cy="11" r="7"/><path d="m21 21-4.3-4.3"/>')?></span>Google Search Console <small><?=e($rangeLabel)?></small><?php if($demo)echo '<span class="an-demobadge">EJEMPLO</span>';?></h2>

<?php if($gscErr): ?>
<div class="adm-help"><span class="adm-help-ic">!</span><span><?=$gscSite?'No se pudieron leer datos de Search Console. Revisa la <b>URL de la propiedad</b> en Conexiones (ej. sc-domain:aldea.work). Detalle: '.e($gscTot['_msg']??''):'Falta configurar la <b>URL de la propiedad</b> de Search Console en Conexiones.'?></span></div>
<?php elseif(!$gtot): ?>
<div class="adm-help"><span class="adm-help-ic">i</span><span>Aun no hay datos de Search Console para este periodo (o la propiedad no coincide).</span></div>
<?php else: ?>
<div class="dash-stats">
  <div class="dash-stat dash-stat-dark"><span class="dash-stat-ic"><?=ic('<path d="m9 11 3 3 8-8"/><path d="M20 12v6a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h9"/>')?></span><span class="dash-stat-n"><?=fnum((int)$gtot['clicks'])?></span><span class="dash-stat-l">Clics</span></div>
  <div class="dash-stat"><span class="dash-stat-ic"><?=ic('<path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7-10-7-10-7z"/><circle cx="12" cy="12" r="3"/>')?></span><span class="dash-stat-n"><?=fnum((int)$gtot['impressions'])?></span><span class="dash-stat-l">Impresiones</span></div>
  <div class="dash-stat"><span class="dash-stat-ic"><?=ic('<path d="M3 3v18h18"/><path d="m7 14 4-4 3 3 5-5"/>')?></span><span class="dash-stat-n"><?=round(((float)$gtot['ctr'])*100,1)?>%</span><span class="dash-stat-l">CTR</span></div>
  <div class="dash-stat"><span class="dash-stat-ic"><?=ic('<path d="M12 2v4M12 18v4M4.9 4.9l2.8 2.8M16.3 16.3l2.8 2.8M2 12h4M18 12h4"/>')?></span><span class="dash-stat-n"><?=number_format((float)$gtot['position'],1)?></span><span class="dash-stat-l">Posicion media</span></div>
</div>

<section class="adm-card" style="margin-bottom:1.2rem">
  <div class="adm-card-h"><h2>Clics e impresiones por dia</h2><span>Rendimiento en la busqueda de Google</span></div>
  <div class="an-canwrap"><canvas id="cGscSeries"></canvas></div>
</section>

<div class="an-grid2">
  <section class="adm-card">
    <div class="adm-card-h"><h2>Frases clave</h2><span>Por las que apareces y te buscan, con tu posicion</span></div>
    <table class="an-tbl"><thead><tr><th>Consulta</th><th style="text-align:right">Clics</th><th style="text-align:right">Impr.</th><th style="text-align:right">CTR</th><th style="text-align:right">Pos.</th></tr></thead><tbody>
    <?php $qr=gaRows($gscQueries); if(!$qr) echo '<tr><td colspan="5"><p class="adm-empty">Sin datos aun.</p></td></tr>';
      foreach($qr as $r){ $kw=$r['keys'][0]??''; ?>
      <tr><td class="an-kw" title="<?=e($kw)?>"><?=e($kw)?></td><td class="num"><?=fnum((int)$r['clicks'])?></td><td class="num"><?=fnum((int)$r['impressions'])?></td><td class="num"><?=round(((float)$r['ctr'])*100,1)?>%</td><td class="num"><span class="an-pos"><?=number_format((float)$r['position'],1)?></span></td></tr>
    <?php } ?>
    </tbody></table>
  </section>
  <section class="adm-card">
    <div class="adm-card-h"><h2>Paginas en Google</h2><span>Las que reciben mas clics</span></div>
    <table class="an-tbl"><thead><tr><th>Pagina</th><th style="text-align:right">Clics</th><th style="text-align:right">Pos.</th></tr></thead><tbody>
    <?php $pgr=gaRows($gscPages); if(!$pgr) echo '<tr><td colspan="3"><p class="adm-empty">Sin datos aun.</p></td></tr>';
      foreach($pgr as $r){ $pg=$r['keys'][0]??''; $pgShort=preg_replace('#^https?://[^/]+#','',$pg); ?>
      <tr><td class="an-kw" title="<?=e($pg)?>"><?=e($pgShort?:$pg)?></td><td class="num"><?=fnum((int)$r['clicks'])?></td><td class="num"><span class="an-pos"><?=number_format((float)$r['position'],1)?></span></td></tr>
    <?php } ?>
    </tbody></table>
  </section>
</div>
<?php endif; ?>

<?php if($demo): ?></div><?php endif; ?>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.min.js"></script>
<script>
(function(){
  if(typeof Chart==='undefined')return;
  Chart.defaults.font.family="'Raleway',sans-serif"; Chart.defaults.color='#8a93a5';
  var dc=['#3b5bdb','#e8710a','#1a7f4b','#8a94a6','#9c36b5','#1098ad','#e03131'];
  function mk(id,cfg){ var el=document.getElementById(id); if(el) new Chart(el,cfg); }
  var line={responsive:true,maintainAspectRatio:false,interaction:{mode:'index',intersect:false},plugins:{legend:{position:'bottom',labels:{usePointStyle:true,boxWidth:8}}},scales:{y:{beginAtZero:true,grid:{color:'#eef1f6'}},x:{grid:{display:false}}}};
  var donut={responsive:true,maintainAspectRatio:false,cutout:'62%',plugins:{legend:{position:'right',labels:{usePointStyle:true,boxWidth:8,padding:12}}}};
  var lineDual={responsive:true,maintainAspectRatio:false,interaction:{mode:'index',intersect:false},plugins:{legend:{position:'bottom',labels:{usePointStyle:true,boxWidth:8}}},scales:{y:{position:'left',beginAtZero:true,grid:{color:'#eef1f6'}},y1:{position:'right',beginAtZero:true,grid:{display:false}},x:{grid:{display:false}}}};
<?php if(!$gaErr): ?>
  mk('cGaSeries',{type:'line',data:{labels:<?=json_encode($sLabels)?>,datasets:[
    {label:'Usuarios',data:<?=json_encode($sUsers)?>,borderColor:'#3b5bdb',backgroundColor:'rgba(59,91,219,.12)',fill:true,tension:.35,pointRadius:0,borderWidth:2},
    {label:'Sesiones',data:<?=json_encode($sSess)?>,borderColor:'#e8710a',backgroundColor:'rgba(232,113,10,.08)',fill:true,tension:.35,pointRadius:0,borderWidth:2}
  ]},options:line});
  mk('cGaChan',{type:'doughnut',data:{labels:<?=json_encode($chL)?>,datasets:[{data:<?=json_encode($chV)?>,backgroundColor:dc,borderWidth:0}]},options:donut});
  mk('cGaDev',{type:'doughnut',data:{labels:<?=json_encode($dvL)?>,datasets:[{data:<?=json_encode($dvV)?>,backgroundColor:dc,borderWidth:0}]},options:donut});
<?php endif; ?>
<?php if(!$gscErr && $gtot): ?>
  mk('cGscSeries',{type:'line',data:{labels:<?=json_encode($qL)?>,datasets:[
    {label:'Clics',data:<?=json_encode($qClk)?>,borderColor:'#1a73e8',backgroundColor:'rgba(26,115,232,.14)',fill:true,tension:.35,pointRadius:0,borderWidth:2,yAxisID:'y'},
    {label:'Impresiones',data:<?=json_encode($qImp)?>,borderColor:'#9aa3b2',fill:false,tension:.35,pointRadius:0,borderWidth:2,yAxisID:'y1'}
  ]},options:lineDual});
<?php endif; ?>
})();
</script>
<?php else: /* ===== PESTANA SEO TECNICO ===== */
$reds = $pdo->query("SELECT * FROM redirects ORDER BY id DESC")->fetchAll();
$eid=(int)($_GET['edit'] ?? 0); $editRow=null;
if($eid){ foreach($reds as $rr){ if((int)$rr['id']===$eid){ $editRow=$rr; break; } } }
$host=$_SERVER['HTTP_HOST'] ?? 'aldea.work';
$is_temporal = strpos($host,'temporal.')===0;
?>
<h2 class="an-sec"><span class="an-brand" style="background:#1a7f4b"><?=ic('<circle cx="11" cy="11" r="7"/><path d="m21 21-4.3-4.3"/>')?></span>SEO tecnico <small>redirecciones, sitemap y robots</small></h2>

<div class="an-grid3">
  <section class="adm-card seo-info">
    <div class="adm-card-h"><h2>Sitemap</h2><span>Indice de URLs para Google</span></div>
    <b><?=count($reds)>=0?'sitemap.xml':''?></b>
    <p class="sub" style="margin:.2rem 0 .7rem">Se genera automatico con todas las paginas y su hreflang ES/EN.</p>
    <a href="/sitemap.xml" target="_blank">Ver sitemap ↗</a>
  </section>
  <section class="adm-card seo-info">
    <div class="adm-card-h"><h2>robots.txt</h2><span>Reglas para buscadores</span></div>
    <b style="font-size:1rem;color:<?=$is_temporal?'#e03131':'#1a7f4b'?>"><?=$is_temporal?'Bloqueado (entorno de pruebas)':'Indexacion permitida'?></b>
    <p class="sub" style="margin:.2rem 0 .7rem"><?=$is_temporal?'En temporal se bloquea a propósito. En produccion se abre solo.':'Permite indexar y expone el sitemap.'?></p>
    <a href="/robots.txt" target="_blank">Ver robots.txt ↗</a>
  </section>
  <section class="adm-card seo-info">
    <div class="adm-card-h"><h2>Redirecciones 301</h2><span>URLs viejas → nuevas</span></div>
    <b><?=count($reds)?></b>
    <p class="sub">activas ahora mismo. Conservan el SEO al cambiar rutas.</p>
  </section>
</div>

<div class="an-grid2seo">
  <section class="adm-card">
    <div class="adm-card-h"><h2><?=$editRow?'Editar redireccion':'Nueva redireccion'?></h2><span>Envia una URL vieja a la nueva sin perder posicionamiento</span></div>
    <form method="post" class="seo-form">
      <input type="hidden" name="csrf" value="<?=csrf()?>">
      <?php if($editRow): ?><input type="hidden" name="id" value="<?=(int)$editRow['id']?>"><?php endif; ?>
      <label>Desde (ruta vieja)<input type="text" name="from_path" required placeholder="/pagina-antigua/" value="<?=e($editRow['from_path'] ?? '')?>"></label>
      <label>Hacia (ruta nueva)<input type="text" name="to_path" required placeholder="/pagina-nueva/" value="<?=e($editRow['to_path'] ?? '')?>"></label>
      <label>Tipo
        <select name="code">
          <option value="301"<?=(($editRow['code'] ?? '301')==='301')?' selected':''?>>301 — permanente (recomendado)</option>
          <option value="302"<?=(($editRow['code'] ?? '')==='302')?' selected':''?>>302 — temporal</option>
        </select>
      </label>
      <div class="seo-form-a">
        <button class="btn"><?=$editRow?'Guardar cambios':'Agregar redireccion'?></button>
        <?php if($editRow): ?><a class="btn btn-ghost" href="?tab=seo">Cancelar</a><?php endif; ?>
      </div>
    </form>
  </section>
  <section class="adm-card">
    <div class="adm-card-h"><h2>Redirecciones activas</h2><span><?=count($reds)?> en total</span></div>
    <table class="an-tbl"><thead><tr><th>Desde</th><th>Hacia</th><th>Tipo</th><th></th></tr></thead><tbody>
    <?php if(!$reds) echo '<tr><td colspan="4"><p class="adm-empty">Aun no hay redirecciones.</p></td></tr>';
      foreach($reds as $r): ?>
      <tr>
        <td class="an-kw" title="<?=e($r['from_path'])?>"><?=e($r['from_path'])?></td>
        <td class="an-kw" title="<?=e($r['to_path'])?>"><?=e($r['to_path'])?></td>
        <td><span class="an-pos"><?=e($r['code'])?></span></td>
        <td class="seo-rowa">
          <a class="seo-ed" href="?tab=seo&edit=<?=(int)$r['id']?>">Editar</a>
          <form method="post" style="display:inline" onsubmit="return confirm('Eliminar esta redireccion?')">
            <input type="hidden" name="csrf" value="<?=csrf()?>"><input type="hidden" name="id" value="<?=(int)$r['id']?>"><input type="hidden" name="_delete" value="1">
            <button class="seo-del" type="submit">Eliminar</button>
          </form>
        </td>
      </tr>
    <?php endforeach; ?>
    </tbody></table>
  </section>
</div>
<?php endif; /* fin pestanas */ ?>
<?php admin_foot(); ?>
