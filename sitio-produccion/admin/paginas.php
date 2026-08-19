<?php require __DIR__.'/_init.php';
$pdo=cms_pdo();
$pages=$pdo->query("SELECT * FROM pages ORDER BY FIELD(type,'home','simple','contact','faq','legal'),id")->fetchAll();
// contar bloques por pagina
$cnt=[]; foreach($pdo->query("SELECT page_id,COUNT(*) c FROM blocks GROUP BY page_id") as $r){ $cnt[$r['page_id']]=$r['c']; }
$TYPE=['home'=>['Inicio','#2563EB'],'simple'=>['Pagina','#0891b2'],'contact'=>['Contacto','#7c3aed'],'faq'=>['Preguntas','#d97706'],'legal'=>['Legal','#64748b']];
function pgicon($t){
  $m=[
   'home'=>'<path d="M3 11l9-8 9 8"/><path d="M5 10v10h14V10"/>',
   'contact'=>'<rect x="3" y="5" width="18" height="14" rx="2"/><path d="m3 7 9 6 9-6"/>',
   'faq'=>'<circle cx="12" cy="12" r="9"/><path d="M9.5 9a2.5 2.5 0 1 1 3.5 2.3c-.8.4-1 .9-1 1.7"/><path d="M12 17h.01"/>',
   'legal'=>'<path d="M14 3v5h5"/><path d="M14 3H6v18h12V8z"/><path d="M9 13h6M9 17h6"/>',
   'simple'=>'<rect x="4" y="3" width="16" height="18" rx="2"/><path d="M8 8h8M8 12h8M8 16h5"/>',
  ];
  return '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round">'.($m[$t]??$m['simple']).'</svg>';
}
admin_head('paginas','Paginas');
echo '<p class="adm-hello">Elige una pagina para editar sus textos, imagenes y botones. Los cambios se publican al guardar.</p>';
if(!$pages){ echo '<div class="card fade-up"><p class="adm-empty">Aun no hay paginas.</p></div>'; admin_foot(); return; }
echo '<div class="pgcards">';
foreach($pages as $p){ $ty=$TYPE[$p['type']]??['Pagina','#64748b']; $c=$cnt[$p['id']]??0;
  echo '<a class="pgcard fade-up" href="pagina.php?id='.$p['id'].'">';
  echo '<div class="pgcard-ic" style="--c:'.$ty[1].'">'.pgicon($p['type']).'</div>';
  echo '<div class="pgcard-b"><h3>'.e($p['title_es']).'</h3><span class="pgcard-slug">/'.e($p['slug']).'</span></div>';
  echo '<div class="pgcard-f"><span class="pgcard-chip" style="--c:'.$ty[1].'">'.e($ty[0]).'</span>';
  echo '<span class="pgcard-n">'.($c?$c.' bloques':'—').'</span></div>';
  echo '<span class="pgcard-go">Editar &rarr;</span></a>';
}
echo '</div>';
admin_foot();
