<?php require __DIR__.'/_init.php';
$pdo=cms_pdo();
if($_SERVER['REQUEST_METHOD']==='POST' && csrf_ok() && isset($_POST['lead_id'],$_POST['lead_status'])){
  $st=$_POST['lead_status']; if(in_array($st,['new','contacted','archived'])){
    $pdo->prepare("UPDATE leads SET status=? WHERE id=?")->execute([$st,(int)$_POST['lead_id']]);
  }
  flash('Lead actualizado.'); header('Location: '.$_SERVER['SCRIPT_NAME']); exit;
}
function lq1($sql){ try{ return (int)cms_pdo()->query($sql)->fetchColumn(); }catch(Throwable $e){ return 0; } }
$total=lq1("SELECT COUNT(*) FROM leads");
$mes=lq1("SELECT COUNT(*) FROM leads WHERE created_at>=DATE_FORMAT(NOW(),'%Y-%m-01')");
$sem=lq1("SELECT COUNT(*) FROM leads WHERE created_at>=DATE_SUB(NOW(),INTERVAL 7 DAY)");
$nuevos=lq1("SELECT COUNT(*) FROM leads WHERE status='new'");
$series=[]; for($i=13;$i>=0;$i--){ $series[date('Y-m-d',strtotime("-$i day"))]=0; }
try{ foreach($pdo->query("SELECT DATE(created_at) d,COUNT(*) c FROM leads WHERE created_at>=DATE_SUB(CURDATE(),INTERVAL 13 DAY) GROUP BY DATE(created_at)") as $r){ if(isset($series[$r['d']]))$series[$r['d']]=(int)$r['c']; } }catch(Throwable $e){}
$maxS=max(1,max($series?:[1]));
$bysrc=[]; try{ $bysrc=$pdo->query("SELECT COALESCE(NULLIF(source,''),'(desconocido)') s,COUNT(*) c FROM leads GROUP BY s ORDER BY c DESC LIMIT 8")->fetchAll(); }catch(Throwable $e){}
$maxSrc=1; foreach($bysrc as $b)$maxSrc=max($maxSrc,(int)$b['c']);
$byst=['new'=>0,'contacted'=>0,'archived'=>0]; try{ foreach($pdo->query("SELECT status,COUNT(*) c FROM leads GROUP BY status") as $r){ $byst[$r['status']]=(int)$r['c']; } }catch(Throwable $e){}
$recent=[]; try{ $recent=$pdo->query("SELECT * FROM leads ORDER BY id DESC LIMIT 30")->fetchAll(); }catch(Throwable $e){}
$STL=['new'=>['Nuevo','#2563eb'],'contacted'=>['Contactado','#1a7f4b'],'archived'=>['Archivado','#8a94a6']];
function lic($p){ return '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round">'.$p.'</svg>'; }

admin_head('leads','Leads');
echo '<div class="adm-help"><span class="adm-help-ic">i</span><span>Los <b>prospectos</b> que llegan por el formulario de contacto del sitio: cuantos, de que pagina vienen y en que estado estan. Marca cada uno como Contactado o Archivado para llevar el seguimiento.</span></div>';
?>
<div class="dash-stats">
  <div class="dash-stat dash-stat-dark"><span class="dash-stat-ic"><?=lic('<path d="M22 12h-6l-2 3h-4l-2-3H2"/><path d="M5.5 5.5 2 12v6a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2v-6l-3.5-6.5A2 2 0 0 0 16.8 4H7.2a2 2 0 0 0-1.7 1.5z"/>')?></span><span class="dash-stat-n"><?=$total?></span><span class="dash-stat-l">Leads totales</span></div>
  <div class="dash-stat"><span class="dash-stat-ic"><?=lic('<rect x="3" y="4" width="18" height="18" rx="2"/><path d="M16 2v4M8 2v4M3 10h18"/>')?></span><span class="dash-stat-n"><?=$mes?></span><span class="dash-stat-l">Este mes</span></div>
  <div class="dash-stat"><span class="dash-stat-ic"><?=lic('<path d="M12 8v4l3 2"/><circle cx="12" cy="12" r="9"/>')?></span><span class="dash-stat-n"><?=$sem?></span><span class="dash-stat-l">Ultimos 7 dias</span></div>
  <div class="dash-stat"><span class="dash-stat-ic"><?=lic('<path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.7 21a2 2 0 0 1-3.4 0"/>')?></span><span class="dash-stat-n"><?=$nuevos?></span><span class="dash-stat-l">Sin atender</span></div>
</div>

<div class="dash-row" style="grid-template-columns:1.6fr 1fr">
  <section class="adm-card">
    <div class="adm-card-h"><h2>Leads en los ultimos 14 dias</h2><span>Solicitudes recibidas por dia</span></div>
    <div class="bars">
    <?php foreach($series as $d=>$c){ $h=round($c/$maxS*100); ?>
      <div class="bar-col"><div class="bar-track"><div class="bar-fill" style="height:<?=max(4,$h)?>%"><?php if($c)echo '<span>'.$c.'</span>';?></div></div><small><?=date('d/m',strtotime($d))?></small></div>
    <?php } ?>
    </div>
  </section>
  <section class="adm-card">
    <div class="adm-card-h"><h2>Por estado</h2></div>
    <?php $tot=array_sum($byst)?:1; foreach($byst as $k=>$c){ $st=$STL[$k]; ?>
      <div class="an-strow"><span class="an-dot" style="background:<?=$st[1]?>"></span><span class="an-stname"><?=$st[0]?></span><span class="an-stbar"><span style="width:<?=round($c/$tot*100)?>%;background:<?=$st[1]?>"></span></span><b><?=$c?></b></div>
    <?php } ?>
  </section>
</div>

<section class="adm-card" style="margin-bottom:1.2rem">
  <div class="adm-card-h"><h2>De que paginas llegan</h2><span>Origen de los leads (que formulario del sitio usaron)</span></div>
  <?php if(!$bysrc): ?><p class="adm-empty">Aun no hay datos.</p><?php else: foreach($bysrc as $b): ?>
    <div class="an-srcrow"><span class="an-srcname"><?=e($b['s'])?></span><span class="an-srcbar"><span style="width:<?=round($b['c']/$maxSrc*100)?>%"></span></span><b><?=$b['c']?></b></div>
  <?php endforeach; endif; ?>
</section>

<section class="adm-card" style="margin-bottom:1.2rem">
  <div class="adm-card-h"><h2>Leads recientes</h2><span>Cambia el estado para llevar seguimiento</span></div>
  <?php if(!$recent): ?>
    <p class="adm-empty">Aun no hay leads. Cuando alguien envie el formulario de contacto del sitio, aparecera aqui automaticamente.</p>
  <?php else: ?>
  <div class="lead-list">
  <?php foreach($recent as $l): $stc=$STL[$l['status']]??$STL['new']; ?>
    <div class="lead-it">
      <span class="lead-av"><?=e(strtoupper(mb_substr($l['name']?:'?',0,1)))?></span>
      <div class="lead-main"><b><?=e($l['name'])?><?=!empty($l['company'])?' <span style="font-weight:400;color:#5c6880">· '.e($l['company']).'</span>':''?></b><small><?=e($l['email'])?><?=$l['phone']?' · '.e($l['phone']):''?><?php
        $extra=[]; if(!empty($l['city']))$extra[]=$l['city']; if(!empty($l['team_size']))$extra[]=$l['team_size'].' pers.';
        if($extra)echo ' · '.e(implode(' · ',$extra));
      ?></small></div>
      <span class="lead-src" title="Pagina de origen"><?=e($l['source']?:'web')?></span>
      <span class="lead-dt"><?=e(substr((string)$l['created_at'],0,10))?></span>
      <form method="post" class="lead-stform">
        <input type="hidden" name="csrf" value="<?=csrf()?>"><input type="hidden" name="lead_id" value="<?=$l['id']?>">
        <select name="lead_status" onchange="this.form.submit()" class="lead-stsel" style="--c:<?=$stc[1]?>">
          <?php foreach($STL as $k=>$v): ?><option value="<?=$k?>"<?=$l['status']===$k?' selected':''?>><?=$v[0]?></option><?php endforeach; ?>
        </select>
      </form>
    </div>
  <?php endforeach; ?>
  </div>
  <?php endif; ?>
</section>
<?php admin_foot(); ?>
