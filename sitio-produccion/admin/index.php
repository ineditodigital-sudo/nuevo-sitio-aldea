<?php require __DIR__.'/../cms/lib.php'; cms_require_login(); require __DIR__.'/_layout.php';
function scount($t){ try{ return (int)count_rows($t); }catch(Throwable $e){ return 0; } }
$c=['solutions'=>scount('solutions'),'locations'=>scount('locations'),'posts'=>scount('posts'),'testimonials'=>scount('testimonials'),'clients'=>scount('clients'),'leads'=>scount('leads'),'pages'=>scount('pages')];
$stats=[
 ['leads','Leads recibidos',$c['leads'],'#','dark','<path d="M22 12h-6l-2 3h-4l-2-3H2"/><path d="M5.5 5.5 2 12v6a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2v-6l-3.5-6.5A2 2 0 0 0 16.8 4H7.2a2 2 0 0 0-1.7 1.5z"/>'],
 ['pages','Paginas','paginas.php',$c['pages'],'','<rect x="4" y="3" width="16" height="18" rx="2"/><path d="M8 8h8M8 12h8M8 16h5"/>'],
 ['locations','Ubicaciones','ubicaciones.php',$c['locations'],'','<path d="M12 21s7-5.5 7-11a7 7 0 1 0-14 0c0 5.5 7 11 7 11z"/><circle cx="12" cy="10" r="2.5"/>'],
 ['solutions','Soluciones','soluciones.php',$c['solutions'],'','<rect x="3" y="3" width="7" height="7" rx="1.5"/><rect x="14" y="3" width="7" height="7" rx="1.5"/><rect x="3" y="14" width="7" height="7" rx="1.5"/><rect x="14" y="14" width="7" height="7" rx="1.5"/>'],
 ['posts','Entradas de blog','blog.php',$c['posts'],'','<path d="M12 20h9"/><path d="M16.5 3.5a2.1 2.1 0 0 1 3 3L7 19l-4 1 1-4z"/>'],
 ['testimonials','Testimonios','testimonios.php',$c['testimonials'],'','<path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>'],
 ['clients','Logos de clientes','clientes.php',$c['clients'],'','<rect x="2" y="7" width="20" height="14" rx="2"/><path d="M8 7V5a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/>'],
];
function ic($p){ return '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round">'.$p.'</svg>'; }
// grafico simple: contenido por tipo
$chart=[['Paginas',$c['pages']],['Ubic.',$c['locations']],['Solu.',$c['solutions']],['Blog',$c['posts']],['Testim.',$c['testimonials']],['Clientes',$c['clients']]];
$max=max(1,max(array_map(fn($x)=>$x[1],$chart)));
$leads=[]; try{ $leads=cms_pdo()->query("SELECT * FROM leads ORDER BY id DESC LIMIT 6")->fetchAll(); }catch(Throwable $e){}
admin_head('index','Dashboard');
?>
<p class="adm-hello">Hola <b><?=e(cms_user()['name'])?></b>, este es el estado de tu sitio.</p>

<div class="dash-stats">
<?php foreach($stats as $s):
  if($s[0]==='leads'){ $href=$s[3]; $val=$s[2]; $dark=' dash-stat-dark'; $icon=$s[5]; $lbl=$s[1]; }
  else { $href=$s[2]; $val=$s[3]; $dark=''; $icon=$s[5]; $lbl=$s[1]; }
?>
  <a class="dash-stat<?=$dark?>" href="<?=e($href)?>">
    <span class="dash-stat-ic"><?=ic($icon)?></span>
    <span class="dash-stat-n"><?=$val?></span>
    <span class="dash-stat-l"><?=e($lbl)?></span>
    <span class="dash-stat-go"><?=ic('<path d="M7 17 17 7M7 7h10v10"/>')?></span>
  </a>
<?php endforeach; ?>
</div>

<div class="dash-row">
  <section class="adm-card dash-chart">
    <div class="adm-card-h"><h2>Contenido del sitio</h2><span>Registros por tipo</span></div>
    <div class="bars">
    <?php foreach($chart as $b): $h=round($b[1]/$max*100); ?>
      <div class="bar-col"><div class="bar-track"><div class="bar-fill" style="height:<?=max(6,$h)?>%"><span><?=$b[1]?></span></div></div><small><?=e($b[0])?></small></div>
    <?php endforeach; ?>
    </div>
  </section>

  <section class="adm-card dash-quick">
    <div class="adm-card-h"><h2>Accesos rapidos</h2></div>
    <a class="qa" href="paginas.php"><span class="qa-ic"><?=ic('<rect x="4" y="3" width="16" height="18" rx="2"/><path d="M8 8h8M8 12h8M8 16h5"/>')?></span>Editar paginas</a>
    <a class="qa" href="ubicaciones.php?a=new"><span class="qa-ic"><?=ic('<path d="M12 5v14M5 12h14"/>')?></span>Nueva ubicacion</a>
    <a class="qa" href="blog.php?a=new"><span class="qa-ic"><?=ic('<path d="M12 5v14M5 12h14"/>')?></span>Nueva entrada de blog</a>
    <a class="qa" href="testimonios.php?a=new"><span class="qa-ic"><?=ic('<path d="M12 5v14M5 12h14"/>')?></span>Nuevo testimonio</a>
  </section>

  <section class="adm-card dash-brand">
    <div class="dash-brand-in">
      <span class="dash-brand-tag">Sitio en vivo</span>
      <h3>Revisa tu sitio publicado</h3>
      <p>Todos los cambios que guardas se publican al instante.</p>
      <a href="/" target="_blank" class="btn dash-brand-btn">Ver sitio ↗</a>
    </div>
  </section>
</div>

<section class="adm-card dash-leads">
  <div class="adm-card-h"><h2>Ultimos leads</h2><span>Solicitudes de contacto recibidas</span></div>
  <?php if(!$leads): ?>
    <p class="adm-empty">Aun no hay leads registrados. Cuando alguien envie el formulario de contacto, aparecera aqui.</p>
  <?php else: ?>
  <div class="lead-list">
    <?php foreach($leads as $l): $nm=$l['name']??''; $em=$l['email']??''; $src=$l['source']??''; $dt=$l['created_at']??''; ?>
    <div class="lead-it">
      <span class="lead-av"><?=e(strtoupper(mb_substr($nm?:'?',0,1)))?></span>
      <div class="lead-main"><b><?=e($nm)?></b><small><?=e($em)?></small></div>
      <?php if($src): ?><span class="lead-src"><?=e($src)?></span><?php endif; ?>
      <span class="lead-dt"><?=e($dt?substr($dt,0,10):'')?></span>
    </div>
    <?php endforeach; ?>
  </div>
  <?php endif; ?>
</section>
<?php admin_foot(); ?>
