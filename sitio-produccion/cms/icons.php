<?php
// Libreria de iconos Aldea (linea). Compartida por el sitio y el CMS.
function aldea_icon_lib(){
  return [
   'building'=>'<path d="M3 21h18M5 21V7l7-4 7 4v14M9 21v-6h6v6"/>',
   'users'=>'<path d="M17 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.9"/>',
   'user'=>'<path d="M20 21a8 8 0 0 0-16 0"/><circle cx="12" cy="7" r="4"/>',
   'wifi'=>'<path d="M5 12.5a10 10 0 0 1 14 0"/><path d="M8.5 15.5a5 5 0 0 1 7 0"/><path d="M12 19h.01"/>',
   'coffee'=>'<path d="M18 8h1a4 4 0 0 1 0 8h-1"/><path d="M2 8h16v9a4 4 0 0 1-4 4H6a4 4 0 0 1-4-4z"/><path d="M6 2v2M10 2v2M14 2v2"/>',
   'shield'=>'<path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>',
   'star'=>'<path d="M12 3l2.5 6.5H21l-5.2 4 2 6.5L12 16l-5.8 4 2-6.5L3 9.5h6.5z"/>',
   'pin'=>'<path d="M12 21s7-5.5 7-11a7 7 0 1 0-14 0c0 5.5 7 11 7 11z"/><circle cx="12" cy="10" r="2.5"/>',
   'printer'=>'<path d="M6 9V3h12v6"/><rect x="6" y="13" width="12" height="8" rx="1"/><path d="M6 17H4a2 2 0 0 1-2-2v-3a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v3a2 2 0 0 1-2 2h-2"/>',
   'box'=>'<path d="M21 8v8a2 2 0 0 1-1 1.7l-7 4a2 2 0 0 1-2 0l-7-4A2 2 0 0 1 3 16V8a2 2 0 0 1 1-1.7l7-4a2 2 0 0 1 2 0l7 4A2 2 0 0 1 21 8z"/><path d="M3.3 7 12 12l8.7-5M12 22V12"/>',
   'calendar'=>'<rect x="3" y="5" width="18" height="16" rx="2"/><path d="M8 3v4M16 3v4M3 10h18"/>',
   'sparkle'=>'<path d="M12 3l1.8 4.4L18 9l-4.2 1.6L12 15l-1.8-4.4L6 9l4.2-1.6z"/>',
   'key'=>'<circle cx="7.5" cy="15.5" r="4.5"/><path d="M10.7 12.3 20 3l1 3-2 2 2 2-3 1-1-1-2 2"/>',
   'heart'=>'<path d="M12 21s-7-4.5-7-10a4 4 0 0 1 7-2 4 4 0 0 1 7 2c0 5.5-7 10-7 10z"/>',
   'check'=>'<path d="M20 6 9 17l-5-5"/>',
   'phone'=>'<path d="M22 16.9v3a2 2 0 0 1-2.2 2 19 19 0 0 1-8.3-3 19 19 0 0 1-6-6 19 19 0 0 1-3-8.4A2 2 0 0 1 4.1 2h3a2 2 0 0 1 2 1.7l.8 3a2 2 0 0 1-.5 1.9L8.1 9.9a16 16 0 0 0 6 6l1.3-1.3a2 2 0 0 1 1.9-.5l3 .8a2 2 0 0 1 1.7 2z"/>',
   'mail'=>'<rect x="3" y="5" width="18" height="14" rx="2"/><path d="m3 7 9 6 9-6"/>',
   'clock'=>'<circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 2"/>',
   'furniture'=>'<path d="M6 13V8a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v5"/><path d="M4 18v-3a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v3"/><path d="M3 18h18M6 18v2M18 18v2"/>',
   'support'=>'<path d="M4 13v-1a8 8 0 0 1 16 0v1"/><rect x="2" y="13" width="4" height="6" rx="1.5"/><rect x="18" y="13" width="4" height="6" rx="1.5"/><path d="M20 19a3 3 0 0 1-3 3h-3"/>',
  ];
}
function aldea_icon($k,$cls=''){ $l=aldea_icon_lib(); $inner=$l[$k]??$l['star']; return '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"'.($cls?' class="'.$cls.'"':'').'>'.$inner.'</svg>'; }

function render_icon($val,$cls=''){ $val=(string)$val;
  if($val!=='' && (strpos($val,'/')!==false || preg_match('/\.(svg|png|jpe?g|webp)$/i',$val))){ return '<img src="'.htmlspecialchars($val,ENT_QUOTES).'" alt=""'.($cls?' class="'.$cls.'"':'').' style="width:100%;height:100%;object-fit:contain">'; }
  return aldea_icon($val?:'star',$cls);
}
