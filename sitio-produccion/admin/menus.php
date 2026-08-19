<?php require __DIR__.'/_crud.php';

$cfg=['table'=>'menu_items','active'=>'menus','title'=>'Menus (header / footer)','order'=>'menu,sort,id',
 'help'=>'Enlaces del menu superior (Header) y del pie de pagina (Footer). Las soluciones y ubicaciones se agregan solas a sus submenus.',
 'fields'=>['menu'=>['type'=>'select','label'=>'Menu','options'=>['header'=>'Header','footer'=>'Footer'],'hint'=>'Header = menu de arriba. Footer = pie de pagina.'],'label_es'=>['type'=>'text','label'=>'Texto (ES)'],'label_en'=>['type'=>'text','label'=>'Texto (EN)'],'href'=>['type'=>'text','label'=>'Enlace','hint'=>'Direccion interna (ej. /ubicaciones/) o externa (https://...). Respeta las barras / al inicio y final.'],'sort'=>['type'=>'number','label'=>'Orden','hint'=>'Menor numero = aparece primero.'],'published'=>['type'=>'check','label'=>'Visible','default'=>1]],
 'list'=>['menu'=>'Menu','label_es'=>'Texto','href'=>'Enlace','sort'=>'Orden']];

// El formulario de edicion/alta y el guardado los maneja el CRUD generico.
$action=$_GET['a']??'list';
if($action==='edit'||$action==='new'||$_SERVER['REQUEST_METHOD']==='POST'){ crud_run($cfg); exit; }

// --- Vista de lista personalizada: agrupada por menu ---
$pdo=cms_pdo();
$rows=$pdo->query("SELECT * FROM menu_items ORDER BY menu,sort,id")->fetchAll();
$groups=['header'=>[],'footer'=>[]];
foreach($rows as $r){ $m=($r['menu']==='footer')?'footer':'header'; $groups[$m][]=$r; }

admin_head('menus','Menus (header / footer)');
?>
<style>
.menu-help{display:flex;gap:.6rem;align-items:flex-start;background:#eef3ff;border:1px solid #dbe4ff;color:#33415c;border-radius:14px;padding:.85rem 1rem;margin-bottom:1.4rem;font-size:.92rem}
.menu-help .ic{flex:0 0 22px;height:22px;width:22px;border-radius:50%;background:#3b5bdb;color:#fff;display:flex;align-items:center;justify-content:center;font-style:italic;font-weight:700;font-size:.8rem}
.menu-sec{background:#fff;border:1px solid #e6e9f0;border-radius:16px;padding:1.1rem 1.2rem 1.3rem;margin-bottom:1.4rem;box-shadow:0 1px 2px rgba(20,30,60,.04)}
.menu-sec-head{display:flex;align-items:center;justify-content:space-between;gap:1rem;padding-bottom:.9rem;border-bottom:1px solid #eef1f6;margin-bottom:.6rem}
.menu-sec-head .t{display:flex;align-items:center;gap:.7rem}
.menu-sec-ic{height:38px;width:38px;border-radius:11px;background:#0f1f3a;color:#fff;display:flex;align-items:center;justify-content:center}
.menu-sec-ic svg{width:20px;height:20px;fill:none;stroke:currentColor;stroke-width:2}
.menu-sec-head h2{margin:0;font-size:1.08rem;color:#0f1f3a}
.menu-sec-head p{margin:.15rem 0 0;font-size:.83rem;color:#8a93a5}
.menu-sec-count{font-size:.8rem;color:#8a93a5;font-weight:600}
.menu-row{display:flex;align-items:center;gap:.9rem;padding:.7rem .6rem;border-radius:10px;text-decoration:none;color:inherit;transition:background .12s}
.menu-row:hover{background:#f5f7fb}
.menu-row+.menu-row{border-top:1px solid #f0f2f7}
.menu-ord{flex:0 0 30px;height:30px;width:30px;border-radius:8px;background:#eef1f6;color:#5b667c;font-weight:700;font-size:.85rem;display:flex;align-items:center;justify-content:center}
.menu-main{flex:1 1 auto;min-width:0}
.menu-txt{font-weight:600;color:#182338}
.menu-en{color:#9aa3b2;font-weight:500;font-size:.82rem;margin-left:.4rem}
.menu-href{display:block;font-size:.82rem;color:#7a8598;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.menu-badge{flex:0 0 auto;font-size:.72rem;font-weight:700;padding:.2rem .55rem;border-radius:999px}
.menu-badge.on{background:#e7f6ec;color:#1f9254}
.menu-badge.off{background:#fdecec;color:#c0392b}
.menu-go{flex:0 0 auto;color:#3b5bdb;font-weight:600;font-size:.85rem}
.menu-empty{color:#9aa3b2;padding:.8rem .6rem;font-size:.9rem}
.menu-add{display:inline-flex;align-items:center;gap:.35rem}
</style>

<div class="menu-help"><span class="ic">i</span><span>Este sitio tiene <b>un</b> menu superior (Header) y <b>un</b> pie de pagina (Footer). Abajo ves los enlaces de cada uno. Las soluciones y ubicaciones se agregan solas a sus submenus.</span></div>

<?php
function menu_section($key,$title,$sub,$icon,$items){
  echo '<div class="menu-sec">';
  echo '<div class="menu-sec-head"><div class="t"><span class="menu-sec-ic">'.$icon.'</span><div><h2>'.$title.'</h2><p>'.$sub.'</p></div></div>';
  echo '<div style="display:flex;align-items:center;gap:1rem"><span class="menu-sec-count">'.count($items).' enlace'.(count($items)==1?'':'s').'</span><a class="btn menu-add" href="?a=new&menu='.$key.'">+ Agregar enlace</a></div></div>';
  if(!$items){ echo '<p class="menu-empty">Sin enlaces todavia.</p>'; }
  foreach($items as $r){
    $on=!empty($r['published']);
    echo '<a class="menu-row" href="?a=edit&id='.$r['id'].'">';
    echo '<span class="menu-ord">'.e($r['sort']).'</span>';
    echo '<span class="menu-main"><span class="menu-txt">'.e($r['label_es']?:'(sin texto)').(!empty($r['label_en'])?'<span class="menu-en">EN: '.e($r['label_en']).'</span>':'').'</span>';
    echo '<span class="menu-href">'.e($r['href']?:'—').'</span></span>';
    echo '<span class="menu-badge '.($on?'on':'off').'">'.($on?'Visible':'Oculto').'</span>';
    echo '<span class="menu-go">Editar &rarr;</span></a>';
  }
  echo '</div>';
}
$icoHeader='<svg viewBox="0 0 24 24"><rect x="3" y="4" width="18" height="5" rx="1.5"/><line x1="7" y1="13" x2="7" y2="13.01"/><line x1="11" y1="13" x2="17" y2="13"/></svg>';
$icoFooter='<svg viewBox="0 0 24 24"><rect x="3" y="15" width="18" height="5" rx="1.5"/><line x1="7" y1="9" x2="7" y2="9.01"/><line x1="11" y1="9" x2="17" y2="9"/></svg>';
menu_section('header','Menu superior (Header)','La barra de navegacion de la parte de arriba del sitio.',$icoHeader,$groups['header']);
menu_section('footer','Pie de pagina (Footer)','Los enlaces del pie de pagina, abajo del todo.',$icoFooter,$groups['footer']);
admin_foot();
