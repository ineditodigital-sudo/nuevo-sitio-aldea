<?php
function adm_icon($k){ $m=[
 'index'=>'<rect x="3" y="3" width="8" height="8" rx="2"/><rect x="13" y="3" width="8" height="5" rx="2"/><rect x="13" y="10" width="8" height="11" rx="2"/><rect x="3" y="13" width="8" height="8" rx="2"/>',
 'paginas'=>'<rect x="4" y="3" width="16" height="18" rx="2"/><path d="M8 8h8M8 12h8M8 16h5"/>',
 'soluciones'=>'<rect x="3" y="3" width="7" height="7" rx="1.5"/><rect x="14" y="3" width="7" height="7" rx="1.5"/><rect x="3" y="14" width="7" height="7" rx="1.5"/><rect x="14" y="14" width="7" height="7" rx="1.5"/>',
 'ubicaciones'=>'<path d="M12 21s7-5.5 7-11a7 7 0 1 0-14 0c0 5.5 7 11 7 11z"/><circle cx="12" cy="10" r="2.5"/>',
 'blog'=>'<path d="M12 20h9"/><path d="M16.5 3.5a2.1 2.1 0 0 1 3 3L7 19l-4 1 1-4z"/>',
 'testimonios'=>'<path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>',
 'clientes'=>'<rect x="2" y="7" width="20" height="14" rx="2"/><path d="M8 7V5a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/>',
 'precios'=>'<path d="M20 12V7H4v10h8"/><circle cx="12" cy="12" r="2"/><path d="M17 15l2 2 4-4"/>',
 'menus'=>'<path d="M4 6h16M4 12h16M4 18h10"/>',
 'seo'=>'<circle cx="11" cy="11" r="7"/><path d="m21 21-4.3-4.3"/>',
 'analitica'=>'<path d="M4 20V10M10 20V4M16 20v-8M22 20H2"/>',
 'leads'=>'<path d="M22 12h-6l-2 3h-4l-2-3H2"/><path d="M5.5 5.5 2 12v6a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2v-6l-3.5-6.5A2 2 0 0 0 16.8 4H7.2a2 2 0 0 0-1.7 1.5z"/>',
 'conexiones'=>'<path d="M10 13a5 5 0 0 0 7 0l3-3a5 5 0 0 0-7-7l-1 1"/><path d="M14 11a5 5 0 0 0-7 0l-3 3a5 5 0 0 0 7 7l1-1"/>',
 'ajustes'=>'<circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.6 1.6 0 0 0 .3 1.8l.1.1a2 2 0 1 1-2.8 2.8l-.1-.1a1.6 1.6 0 0 0-2.7 1.1V21a2 2 0 1 1-4 0v-.1A1.6 1.6 0 0 0 7 19.4a1.6 1.6 0 0 0-1.8.3l-.1.1a2 2 0 1 1-2.8-2.8l.1-.1a1.6 1.6 0 0 0-1.1-2.7H1a2 2 0 1 1 0-4h.1A1.6 1.6 0 0 0 4.6 7a1.6 1.6 0 0 0-.3-1.8l-.1-.1a2 2 0 1 1 2.8-2.8l.1.1A1.6 1.6 0 0 0 9 3.6h.1A1.6 1.6 0 0 0 10 1.9V1a2 2 0 1 1 4 0v.1a1.6 1.6 0 0 0 2.7 1.1 1.6 1.6 0 0 0 1.8-.3l.1-.1a2 2 0 1 1 2.8 2.8l-.1.1a1.6 1.6 0 0 0 1.1 2.7H23a2 2 0 1 1 0 4h-.1a1.6 1.6 0 0 0-1.5 1z"/>',
]; return '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round">'.($m[$k]??$m['paginas']).'</svg>'; }

function admin_head($active='',$title='Panel'){
  if(!headers_sent()) header('Cache-Control: no-store, no-cache, must-revalidate, max-age=0');
  $u=cms_user();
  $groups=[
   'Contenido'=>[['index','Dashboard'],['paginas','Paginas'],['soluciones','Servicios'],['ubicaciones','Ubicaciones'],['blog','Blog'],['testimonios','Testimonios'],['clientes','Clientes'],['precios','Precios']],
   'Sistema'=>[['menus','Menus'],['analitica','SEO y Analitica'],['leads','Leads'],['conexiones','Conexiones'],['ajustes','Ajustes']],
  ];
  $ini=strtoupper(mb_substr($u['name']??'A',0,1));
  ?><!doctype html><html lang="es"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
  <title><?=e($title)?> · Aldea CMS</title>
  <link rel="icon" href="/img/favicon.svg">
  <link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Jost:wght@400;500;600;700&family=Raleway:wght@300;400;500;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="/admin/admin.css?v=<?=@filemtime(__DIR__."/admin.css")?>"></head><body>
  <div class="adm">
    <aside class="adm-side">
      <div class="adm-logo"><img src="/img/logo-blanco.svg" alt="Aldea"><span>CMS</span></div>
      <nav class="adm-nav">
      <?php foreach($groups as $gname=>$items): ?>
        <p class="adm-navsec"><?=e($gname)?></p>
        <?php foreach($items as $n): $on=$active===$n[0]?' on':''; ?>
          <a class="adm-nav-i<?=$on?>" href="/admin/<?=$n[0]==='index'?'':$n[0].'.php'?>"><span class="adm-nav-ic"><?=adm_icon($n[0])?></span><?=e($n[1])?></a>
        <?php endforeach; ?>
      <?php endforeach; ?>
      </nav>
      <a class="adm-logout" href="/admin/logout.php"><span class="adm-nav-ic"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><path d="m16 17 5-5-5-5M21 12H9"/></svg></span>Cerrar sesion</a>
    </aside>
    <main class="adm-main">
      <header class="adm-top">
        <div class="adm-top-l"><h1><?=e($title)?></h1></div>
        <div class="adm-search"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round"><circle cx="11" cy="11" r="7"/><path d="m21 21-4.3-4.3"/></svg><input id="admSearch" type="text" placeholder="Buscar en esta pagina..." autocomplete="off"></div>
        <div class="adm-user">
          <a href="/" target="_blank" class="adm-viewsite">Ver sitio ↗</a>
          <div class="adm-ava"><?=e($ini)?></div>
          <div class="adm-user-i"><b><?=e($u['name']??'')?></b><small><?=e($u['email']??'')?></small></div>
        </div>
      </header>
      <?php if($f=flash()): ?><div class="adm-flash"><?=e($f)?></div><?php endif; ?>
      <div class="adm-body">
<?php }
function admin_foot(){ echo '</div></main></div><script>(function(){var s=document.getElementById("admSearch");if(!s)return;s.addEventListener("input",function(){var q=s.value.trim().toLowerCase();document.querySelectorAll(".pgcard,.crud-card,.adm-mod,.adm-card").forEach(function(c){c.style.display=(!q||c.innerText.toLowerCase().indexOf(q)>-1)?"":"none";});});})();</script></body></html>'; }
