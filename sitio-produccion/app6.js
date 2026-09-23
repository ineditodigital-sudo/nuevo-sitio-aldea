function setLang(lang){
  document.documentElement.lang=lang;
  document.querySelectorAll('[data-es]').forEach(function(el){var t=el.getAttribute('data-'+lang);if(t!=null)el.textContent=t;});
  document.querySelectorAll('[data-ph-es]').forEach(function(el){var t=el.getAttribute('data-ph-'+lang);if(t!=null)el.setAttribute('placeholder',t);});
  document.querySelectorAll('#lang button').forEach(function(b){b.classList.toggle('on',b.getAttribute('data-lang')===lang);});
  try{localStorage.setItem('aldea_lang',lang);}catch(e){}
}
(function(){var box=document.getElementById('lang');var urlLang=document.documentElement.getAttribute('lang')||'es';setLang(urlLang);if(!box)return;box.querySelectorAll('button').forEach(function(b){b.addEventListener('click',function(e){var l=b.getAttribute('data-lang');if(!l)return;var url=box.getAttribute('data-'+l+'-url');if(url&&l!==urlLang){location.href=url;}else{setLang(l);}});});})();

var hdr=document.getElementById('hdr');
if(hdr){var os=function(){hdr.classList.toggle('scr',window.scrollY>20);};os();window.addEventListener('scroll',os,{passive:true});}
var burger=document.getElementById('burger'),nav=document.getElementById('nav');
if(burger&&nav){
  // Menu movil a pantalla completa: bloquea el scroll de fondo, el header pasa a blanco y cierra con Escape.
  var setNav=function(abierto){
    nav.classList.toggle('open',abierto);
    burger.setAttribute('aria-expanded',abierto?'true':'false');
    document.body.classList.toggle('nav-open',abierto);
    if(hdr) hdr.classList.toggle('scr',abierto||window.scrollY>20);
  };
  burger.addEventListener('click',function(){setNav(!nav.classList.contains('open'));});
  document.addEventListener('keydown',function(e){if(e.key==='Escape'&&nav.classList.contains('open')){setNav(false);burger.focus();}});
  window.addEventListener('resize',function(){if(window.innerWidth>980&&nav.classList.contains('open'))setNav(false);});
  nav.querySelectorAll('a').forEach(function(a){a.addEventListener('click',function(){if(a.parentElement&&a.parentElement.classList.contains('hdr-drop')&&window.innerWidth<=980)return;setNav(false);});});}

var PRICES={ags:{privada:'7,400',cowork:'2,700',virtual:'2,400',soon:false},leon:{privada:'8,600',cowork:'3,100',virtual:'2,400',soon:false},slp:{privada:'8,600',cowork:'3,100',virtual:'2,400',soon:false},qro:{privada:'10,800',cowork:'3,100',virtual:'2,400',soon:true}};
function setCity(city){var btn=document.querySelector('#cityTabs button[data-city="'+city+'"]');var d=PRICES[city];if(btn&&btn.getAttribute('data-p')){d={privada:btn.getAttribute('data-p'),cowork:btn.getAttribute('data-w'),virtual:btn.getAttribute('data-v'),soon:btn.getAttribute('data-soon')==='1'};}if(!d)return;var pp=document.getElementById('p-privada'),pc=document.getElementById('p-cowork'),pv=document.getElementById('p-virtual'),sn=document.getElementById('soonNote');if(pp)pp.textContent=d.privada;if(pc)pc.textContent=d.cowork;if(pv)pv.textContent=d.virtual;if(sn)sn.hidden=!d.soon;document.querySelectorAll('#cityTabs button').forEach(function(b){b.classList.toggle('on',b.getAttribute('data-city')===city);});}
document.querySelectorAll('#cityTabs button').forEach(function(b){b.addEventListener('click',function(){setCity(b.getAttribute('data-city'));});});

var io=new IntersectionObserver(function(en){en.forEach(function(e){if(e.isIntersecting){e.target.classList.add('vis');io.unobserve(e.target);}});},{threshold:.12});
function revealNear(){var h=window.innerHeight||800;var a=document.querySelectorAll('.reveal.pre:not(.vis)');for(var i=0;i<a.length;i++){var r=a[i].getBoundingClientRect();if(r.top<h*0.92&&r.bottom>0){a[i].classList.add('vis');}}}document.querySelectorAll('.reveal').forEach(function(el){var r=el.getBoundingClientRect();if(r.top<(window.innerHeight||800)*0.92){el.classList.add('vis');}else{el.classList.add('pre');io.observe(el);}});window.addEventListener('scroll',revealNear,{passive:true});window.addEventListener('resize',revealNear,{passive:true});setTimeout(function(){var a=document.querySelectorAll('.reveal.pre:not(.vis)');for(var i=0;i<a.length;i++)a[i].classList.add('vis');},6000);
var yr=document.getElementById('yr');if(yr)yr.textContent=new Date().getFullYear();
function aldeaSubmit(ev){
  ev.preventDefault();
  var form=ev.target,lang=document.documentElement.lang;
  var msg=form.querySelector('#formMsg')||form.querySelector('small');
  var btn=form.querySelector('button[type=submit]');
  var data=Object.fromEntries(new FormData(form).entries());
  data.source=form.getAttribute('data-source')||location.pathname;
  data.url=location.href;
  if(btn)btn.disabled=true;
  if(msg){msg.style.color='';msg.textContent=lang==='en'?'Sending...':'Enviando...';}
  fetch('/send.php',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify(data)})
   .then(function(r){return r.json();})
   .then(function(res){
     if(res&&res.ok){window.location.href='/formulario-enviado/';return;}
     else{throw new Error();}
   })
   .catch(function(){if(msg){msg.textContent=lang==='en'?'Could not send. Please try again or call us.':'No se pudo enviar. Intenta de nuevo o ll\u00e1manos.';msg.style.color='#c0392b';}})
   .finally(function(){if(btn)btn.disabled=false;});
  return false;
}

// ---- Hero: parallax INDEPENDIENTE por elemento + flotado idle ----
(function(){
  var stage=document.getElementById('xstage'); if(!stage) return;
  var art=stage.parentElement;
  var els=[].slice.call(stage.querySelectorAll('.xfloat'));
  var reduce=window.matchMedia&&window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  var fine=window.matchMedia&&window.matchMedia('(pointer:fine)').matches&&window.innerWidth>980;
  if(reduce||!els.length) return;
  var mx=0,my=0,tmx=0,tmy=0;
  if(fine){
    art.addEventListener('mousemove',function(e){var r=art.getBoundingClientRect();tmx=(e.clientX-r.left)/r.width-0.5;tmy=(e.clientY-r.top)/r.height-0.5;});
    art.addEventListener('mouseleave',function(){tmx=0;tmy=0;});
  }
  function frame(t){
    mx+=(tmx-mx)*0.08; my+=(tmy-my)*0.08;
    for(var i=0;i<els.length;i++){
      var el=els[i],d=el.dataset;
      var z=+d.z||0,depth=+d.depth||0,amp=+d.amp||0,sp=+d.sp||1,rot=+d.rot||0,ph=i*1.7;
      var fy=Math.sin(t/1000*sp+ph)*amp;
      var fx=Math.cos(t/1000*sp*0.8+ph)*amp*0.4;
      var px=mx*depth,py=my*depth;
      var rx=(-my*depth*0.18)+rot,ry=(mx*depth*0.18);
      el.style.transform='translate3d('+(fx+px).toFixed(2)+'px,'+(fy+py).toFixed(2)+'px,'+z+'px) rotateX('+rx.toFixed(2)+'deg) rotateY('+ry.toFixed(2)+'deg)';
    }
    requestAnimationFrame(frame);
  }
  requestAnimationFrame(frame);
})();

// ---- Hero: cambio de imagenes cada cierto tiempo (crossfade) ----
(function(){
  var slots=[].slice.call(document.querySelectorAll('.xphoto'));
  slots.forEach(function(slot,si){
    var imgs=slot.querySelectorAll('img'); if(imgs.length<2) return;
    var cur=0;
    setInterval(function(){
      imgs[cur].classList.remove('on');
      cur=(cur+1)%imgs.length;
      imgs[cur].classList.add('on');
    },4500+si*1500);
  });
})();

// hdr-drop toggle movil
// En el menu movil, el enlace y la flecha abren y cierran el submenu
document.querySelectorAll('.hdr-drop').forEach(function(drop){var t=drop.querySelector('a'),ar=drop.querySelector('.hdr-ar');if(!t)return;
  var tog=function(e){if(window.innerWidth<=980){e.preventDefault();var ab=drop.classList.toggle('open');t.setAttribute('aria-expanded',ab?'true':'false');}};
  t.addEventListener('click',tog);if(ar)ar.addEventListener('click',tog);});

// galeria interactiva ubicaciones
document.querySelectorAll('.lochero-gal').forEach(function(gal){
  var imgs=[].slice.call(gal.querySelectorAll('.lg-img'));
  var thumbs=[].slice.call(gal.querySelectorAll('.lg-thumb'));
  var cnt=gal.querySelector('.lg-count b'); if(imgs.length<2)return;
  var i=0,timer;
  function show(n){i=(n+imgs.length)%imgs.length;imgs.forEach(function(im,k){im.classList.toggle('on',k===i);});thumbs.forEach(function(t,k){t.classList.toggle('on',k===i);});if(cnt)cnt.textContent=i+1;}
  function start(){timer=setInterval(function(){show(i+1);},5000);}
  function reset(){clearInterval(timer);start();}
  var p=gal.querySelector('.lg-prev'),n=gal.querySelector('.lg-next');
  if(p)p.addEventListener('click',function(){show(i-1);reset();});
  if(n)n.addEventListener('click',function(){show(i+1);reset();});
  thumbs.forEach(function(t,k){t.addEventListener('click',function(){show(k);reset();});});
  gal.addEventListener('mouseenter',function(){clearInterval(timer);});
  gal.addEventListener('mouseleave',start); start();
});

// galeria de soluciones + lightbox
(function(){
  var lbx=document.createElement('div'); lbx.className='lbx';
  lbx.innerHTML='<button class="lbx-close" aria-label="Cerrar"><svg viewBox="0 0 24 24"><path d="M6 6l12 12M18 6L6 18"/></svg></button>'+
    '<button class="lbx-nav lbx-prev" aria-label="Anterior"><svg viewBox="0 0 24 24"><path d="M15 18l-6-6 6-6"/></svg></button>'+
    '<img class="lbx-img" src="" alt=""/>'+
    '<button class="lbx-nav lbx-next" aria-label="Siguiente"><svg viewBox="0 0 24 24"><path d="M9 6l6 6-6 6"/></svg></button>'+
    '<span class="lbx-count"><b>1</b>/<span class="lbx-total">1</span></span>';
  document.body.appendChild(lbx);
  var lImg=lbx.querySelector('.lbx-img'),lCur=lbx.querySelector('.lbx-count b'),lTot=lbx.querySelector('.lbx-total');
  var curImgs=[],li=0;
  function lShow(n){li=(n+curImgs.length)%curImgs.length;lImg.src=curImgs[li];lCur.textContent=li+1;}
  window.lOpen=function(imgs,idx){curImgs=imgs;lTot.textContent=imgs.length;lShow(idx);lbx.classList.add('on');document.body.style.overflow='hidden';};
  function lClose(){lbx.classList.remove('on');document.body.style.overflow='';}
  lbx.querySelector('.lbx-close').addEventListener('click',lClose);
  lbx.querySelector('.lbx-prev').addEventListener('click',function(e){e.stopPropagation();lShow(li-1);});
  lbx.querySelector('.lbx-next').addEventListener('click',function(e){e.stopPropagation();lShow(li+1);});
  lbx.addEventListener('click',function(e){if(e.target===lbx)lClose();});
  document.addEventListener('keydown',function(e){if(!lbx.classList.contains('on'))return;if(e.key==='Escape')lClose();else if(e.key==='ArrowLeft')lShow(li-1);else if(e.key==='ArrowRight')lShow(li+1);});

  document.querySelectorAll('.solhero-card.sg').forEach(function(card){
    var imgs=[].slice.call(card.querySelectorAll('.sg-img'));
    var urls=imgs.map(function(im){return im.getAttribute('src');});
    var thumbs=[].slice.call(card.querySelectorAll('.sg-thumb'));
    if(imgs.length<2)return;
    var i=0,timer;
    function show(n){i=(n+imgs.length)%imgs.length;imgs.forEach(function(im,k){im.classList.toggle('on',k===i);});thumbs.forEach(function(t,k){t.classList.toggle('on',k===i);});}
    function start(){timer=setInterval(function(){show(i+1);},4500);}
    function reset(){clearInterval(timer);start();}
    thumbs.forEach(function(t,k){t.addEventListener('click',function(e){e.stopPropagation();show(k);reset();});});
    var exp=card.querySelector('.sg-expand');
    if(exp)exp.addEventListener('click',function(e){e.stopPropagation();window.lOpen(urls,i);});
    card.addEventListener('click',function(e){if(e.target.closest('a')||e.target.closest('button'))return;window.lOpen(urls,i);});
    card.addEventListener('mouseenter',function(){clearInterval(timer);});
    card.addEventListener('mouseleave',start); start();
  });
})();

// carruseles con flechas
document.querySelectorAll('[data-car]').forEach(function(wrap){
  var track=wrap.querySelector('[data-track]');
  var prev=wrap.querySelector('[data-prev]'),next=wrap.querySelector('[data-next]');
  function step(){return Math.max(240,Math.round(track.clientWidth*0.7));}
  if(prev)prev.addEventListener('click',function(){track.scrollBy({left:-step(),behavior:'smooth'});});
  if(next)next.addEventListener('click',function(){track.scrollBy({left:step(),behavior:'smooth'});});
  if(wrap.hasAttribute('data-auto')){
    var timer;
    function go(){track.scrollLeft+track.clientWidth>=track.scrollWidth-6?track.scrollTo({left:0,behavior:'smooth'}):track.scrollBy({left:step(),behavior:'smooth'});}
    function start(){timer=setInterval(go,3000);}
    function stop(){clearInterval(timer);}
    wrap.addEventListener('mouseenter',stop);wrap.addEventListener('mouseleave',start);start();
  }
});

// ---- Hero Home: carrusel de imagenes (solo cambia la imagen; texto y CTAs fijos) ----
(function(){
  var box=document.querySelector('[data-hero]'); if(!box) return;
  var imgs=[].slice.call(box.querySelectorAll('.nhero-img'));
  if(imgs.length<2) return;
  if(window.matchMedia&&window.matchMedia('(prefers-reduced-motion: reduce)').matches) return;
  var i=0;
  setInterval(function(){
    imgs[i].classList.remove('on');
    i=(i+1)%imgs.length;
    imgs[i].classList.add('on');
  },6000);
})();

// ================= CARRUSELES (rail) =================
// La pista corre hasta el borde derecho; las flechas avanzan lo que se ve completo
// y se apagan en los extremos. Si todo cabe, las flechas se ocultan.
document.querySelectorAll('[data-rail]').forEach(function(r){
  var t=r.querySelector('.rail-track'); if(!t) return;
  var p=r.querySelector('[data-rail-prev]'), n=r.querySelector('[data-rail-next]'), ctrl=r.querySelector('.rail-ctrl');
  function paso(){
    var it=t.children[0]; if(!it) return t.clientWidth*0.8;
    var g=parseFloat(getComputedStyle(t).columnGap)||0, w=it.getBoundingClientRect().width+g;
    var visible=t.getBoundingClientRect().right>window.innerWidth ? window.innerWidth-t.getBoundingClientRect().left : t.clientWidth;
    return w*Math.max(1,Math.floor((visible+g)/w));
  }
  function upd(){
    var max=t.scrollWidth-t.clientWidth-2;
    if(p) p.disabled=t.scrollLeft<=2;
    if(n) n.disabled=t.scrollLeft>=max;
    if(ctrl) ctrl.hidden=max<=0;
  }
  if(p) p.addEventListener('click',function(){ t.scrollBy({left:-paso(),behavior:'smooth'}); });
  if(n) n.addEventListener('click',function(){ t.scrollBy({left:paso(),behavior:'smooth'}); });
  t.addEventListener('scroll',upd,{passive:true});
  window.addEventListener('resize',upd,{passive:true});
  upd();
});

// ================= GALERIAS: visor de fotos y video =================
// Cualquier contenedor con data-galeria='[{tipo,src},...]' abre el visor desde sus [data-i].
// [data-gal-todas] abre la vista con todas las fotos; desde ahi cada foto abre el visor.
(function(){
  var cont=document.querySelector('[data-galeria]'); if(!cont) return;
  var items=[]; try{ items=JSON.parse(cont.getAttribute('data-galeria'))||[]; }catch(e){ return; }
  if(!items.length) return;
  var ultimoFoco=null;

  var box=document.createElement('div'); box.className='lgx'; box.hidden=true;
  box.setAttribute('role','dialog'); box.setAttribute('aria-modal','true'); box.setAttribute('aria-label','Galería');
  box.innerHTML='<button class="lgx-x" aria-label="Cerrar"><svg viewBox="0 0 24 24"><path d="M6 6l12 12M18 6L6 18"/></svg></button>'+
    '<button class="lgx-nav lgx-prev" aria-label="Anterior"><svg viewBox="0 0 24 24"><path d="M15 18l-6-6 6-6"/></svg></button>'+
    '<div class="lgx-stage"></div>'+
    '<button class="lgx-nav lgx-next" aria-label="Siguiente"><svg viewBox="0 0 24 24"><path d="M9 6l6 6-6 6"/></svg></button>'+
    '<span class="lgx-count"><b>1</b>/'+items.length+'</span>';
  document.body.appendChild(box);
  var stage=box.querySelector('.lgx-stage'), cur=box.querySelector('.lgx-count b'), i=0;

  function embed(u){
    var m=u.match(/(?:youtu\.be\/|v=)([\w-]{6,})/);
    if(/youtube\.com|youtu\.be/i.test(u)&&m) return 'https://www.youtube-nocookie.com/embed/'+m[1]+'?autoplay=1&rel=0';
    var v=u.match(/vimeo\.com\/(?:video\/)?(\d+)/);
    if(/vimeo\.com/i.test(u)&&v) return 'https://player.vimeo.com/video/'+v[1]+'?autoplay=1';
    return null;
  }
  function pinta(n){
    i=(n+items.length)%items.length;
    var it=items[i]; cur.textContent=i+1;
    if(it.tipo==='video'){
      var e=embed(it.src);
      stage.innerHTML = e
        ? '<iframe class="lgx-video" src="'+e+'" title="Video" allow="autoplay; fullscreen; picture-in-picture" allowfullscreen></iframe>'
        : '<video class="lgx-video" src="'+it.src+'" controls autoplay playsinline></video>';
    } else {
      stage.innerHTML='<img class="lgx-img" src="'+it.src+'" alt="">';
    }
  }
  function abre(n){ ultimoFoco=document.activeElement; pinta(n); box.hidden=false; document.body.style.overflow='hidden'; box.querySelector('.lgx-x').focus(); }
  function cierra(){ box.hidden=true; stage.innerHTML=''; if(vista.hidden) document.body.style.overflow=''; if(ultimoFoco&&ultimoFoco.focus) ultimoFoco.focus(); }

  // Vista "todas las fotos"
  var vista=document.createElement('div'); vista.className='gview'; vista.hidden=true;
  vista.setAttribute('role','dialog'); vista.setAttribute('aria-modal','true');
  var titulo=cont.getAttribute('data-titulo')||'';
  var h='<div class="gview-bar"><b>'+titulo.replace(/</g,'&lt;')+'</b><button class="gview-x" aria-label="Cerrar"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M6 6l12 12M18 6L6 18"/></svg></button></div><div class="gview-grid">';
  items.forEach(function(it,k){ if(it.tipo!=='video') h+='<button type="button" data-k="'+k+'"><img src="'+(it.sm||it.src)+'" alt="" loading="lazy"></button>'; });
  vista.innerHTML=h+'</div>';
  document.body.appendChild(vista);
  function abreVista(){ ultimoFoco=document.activeElement; vista.hidden=false; vista.scrollTop=0; document.body.style.overflow='hidden'; vista.querySelector('.gview-x').focus(); }
  function cierraVista(){ vista.hidden=true; document.body.style.overflow=''; if(ultimoFoco&&ultimoFoco.focus) ultimoFoco.focus(); }
  vista.querySelector('.gview-x').addEventListener('click',cierraVista);
  vista.querySelectorAll('[data-k]').forEach(function(b){ b.addEventListener('click',function(){ abre(parseInt(b.getAttribute('data-k'),10)||0); }); });

  document.querySelectorAll('[data-galeria] [data-i], [data-gal-i]').forEach(function(b){
    b.addEventListener('click',function(){ abre(parseInt(b.getAttribute('data-i')||b.getAttribute('data-gal-i'),10)||0); });
  });
  document.querySelectorAll('[data-gal-todas]').forEach(function(b){ b.addEventListener('click',abreVista); });
  box.querySelector('.lgx-x').addEventListener('click',cierra);
  box.querySelector('.lgx-prev').addEventListener('click',function(e){ e.stopPropagation(); pinta(i-1); });
  box.querySelector('.lgx-next').addEventListener('click',function(e){ e.stopPropagation(); pinta(i+1); });
  box.addEventListener('click',function(e){ if(e.target===box) cierra(); });
  document.addEventListener('keydown',function(e){
    if(!box.hidden){
      if(e.key==='Escape') cierra();
      else if(e.key==='ArrowLeft') pinta(i-1);
      else if(e.key==='ArrowRight') pinta(i+1);
    } else if(!vista.hidden && e.key==='Escape') cierraVista();
  });

  // Movil: la galeria se desliza; el contador dice que foto se ve.
  var grid=cont.querySelector('.sgal-grid'), cnt=cont.querySelector('.sgal-count b');
  if(grid&&cnt){
    grid.addEventListener('scroll',function(){
      var it=grid.children[0]; if(!it) return;
      cnt.textContent=Math.min(grid.children.length,Math.round(grid.scrollLeft/(it.getBoundingClientRect().width+6))+1);
    },{passive:true});
  }
})();

// Oficinas Corporativas: video "una sola renta". Se detiene fuera de pantalla,
// no arranca solo con movimiento reducido y tiene boton de pausa.
(function(){
  var v=document.querySelector('[data-renta-video]'); if(!v) return;
  var b=document.querySelector('[data-renta-pausa]');
  var PAUSA='<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M6 6a1 1 0 0 1 1 -1h2a1 1 0 0 1 1 1v12a1 1 0 0 1 -1 1h-2a1 1 0 0 1 -1 -1l0 -12"/><path d="M14 6a1 1 0 0 1 1 -1h2a1 1 0 0 1 1 1v12a1 1 0 0 1 -1 1h-2a1 1 0 0 1 -1 -1l0 -12"/></svg>';
  var PLAY='<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M7 4v16l13 -8z"/></svg>';
  var en=document.documentElement.lang==='en';
  var pausadoAMano=window.matchMedia&&window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  function boton(){ if(!b) return; b.innerHTML=v.paused?PLAY:PAUSA; b.setAttribute('aria-label',v.paused?(en?'Play animation':'Reproducir animación'):(en?'Pause animation':'Pausar animación')); }
  // En movil se reproduce la version vertical: el poster tambien debe ser el vertical.
  if(window.matchMedia&&window.matchMedia('(max-width: 700px)').matches&&v.poster) v.poster=v.poster.replace('-16x9.webp','-4x5.webp');
  if(pausadoAMano){ v.removeAttribute('autoplay'); v.pause(); }
  if('IntersectionObserver' in window){
    new IntersectionObserver(function(es){ es.forEach(function(e){
      if(pausadoAMano) return;
      if(e.isIntersecting){ var p=v.play(); if(p&&p.catch) p.catch(function(){}); } else v.pause();
      boton();
    }); },{threshold:.2}).observe(v);
  } else if(!pausadoAMano){ var p0=v.play(); if(p0&&p0.catch) p0.catch(function(){}); }
  v.addEventListener('play',boton); v.addEventListener('pause',boton);
  if(b) b.addEventListener('click',function(){ if(v.paused){ pausadoAMano=false; var p=v.play(); if(p&&p.catch) p.catch(function(){}); } else { pausadoAMano=true; v.pause(); } });
  boton();
})();

// "Cotizar" de cada espacio: baja al formulario y preselecciona el producto.
document.querySelectorAll('.esp-cta').forEach(function(b){
  b.addEventListener('click',function(){
    var sel=document.getElementById('prodSel');
    if(sel){
      var v=b.getAttribute('data-producto');
      for(var k=0;k<sel.options.length;k++){ if(sel.options[k].value===v){ sel.selectedIndex=k; break; } }
      sel.classList.add('campo-listo');
      setTimeout(function(){ sel.classList.remove('campo-listo'); },1600);
    }
    var f=document.getElementById('formulario');
    if(f) f.scrollIntoView({behavior:'smooth',block:'start'});
  });
});

// Modal "Agenda tu visita"
(function(){
  var m=document.getElementById('vmodal'); if(!m) return;
  function abre(){ m.hidden=false; document.body.style.overflow='hidden';
    var f=m.querySelector('input[name=visit_date]');
    if(f && !f.min){ var d=new Date(); d.setDate(d.getDate()+1);
      f.min=d.toISOString().slice(0,10); }
  }
  function cierra(){ m.hidden=true; document.body.style.overflow=''; }
  document.querySelectorAll('[data-visita]').forEach(function(b){ b.addEventListener('click',abre); });
  m.querySelectorAll('[data-vclose]').forEach(function(b){ b.addEventListener('click',cierra); });
  document.addEventListener('keydown',function(e){ if(!m.hidden && e.key==='Escape') cierra(); });
})();

// Campañas: guarda los UTM de la primera visita y los adjunta a los formularios.
(function(){
  var CLAVES=['utm_source','utm_medium','utm_campaign','utm_content','utm_term'];
  var q=new URLSearchParams(location.search), hay=false, datos={};
  CLAVES.forEach(function(k){ var v=q.get(k); if(v){ datos[k]=v; hay=true; } });
  try{
    if(hay) sessionStorage.setItem('aldea_utm',JSON.stringify(datos));
    else datos=JSON.parse(sessionStorage.getItem('aldea_utm')||'{}');
  }catch(e){}
  document.querySelectorAll('form[data-utm]').forEach(function(f){
    CLAVES.forEach(function(k){
      if(!datos[k]) return;
      var h=document.createElement('input'); h.type='hidden'; h.name=k; h.value=datos[k]; f.appendChild(h);
    });
  });
})();

// Carruseles tactiles en movil ([data-swipe]): linea de progreso bajo la fila. Solo se ve
// cuando la fila de verdad se desliza (en escritorio son rejillas y la linea queda oculta).
(function(){
  document.querySelectorAll('[data-swipe]').forEach(function(f){
    var bar=document.createElement('div'); bar.className='swipe-bar'; bar.setAttribute('aria-hidden','true'); bar.hidden=true;
    var t=document.createElement('i'); bar.appendChild(t); f.insertAdjacentElement('afterend',bar);
    var pend=false;
    var pinta=function(){ pend=false;
      var max=f.scrollWidth-f.clientWidth;
      if(max<=2){ bar.hidden=true; return; }
      bar.hidden=false;
      var w=f.clientWidth/f.scrollWidth, x=Math.min(1,Math.max(0,f.scrollLeft/max));
      t.style.width=(w*100)+'%';
      t.style.transform='translateX('+(x*(1/w-1)*100)+'%)';
    };
    f.addEventListener('scroll',function(){ if(!pend){ pend=true; requestAnimationFrame(pinta); } },{passive:true});
    window.addEventListener('resize',pinta);
    pinta();
  });
})();

// Barra de acciones en movil (#mbar): aparece cuando los botones del inicio ya quedaron arriba
// y se esconde mientras el formulario o el pie estan en pantalla (ahi ya estan esas acciones).
(function(){
  var bar=document.getElementById('mbar'); if(!bar||!('IntersectionObserver' in window)) return;
  var inicio=document.querySelector('.hero-cta');
  var fines=[document.getElementById('formulario'),document.querySelector('.ftr')].filter(Boolean);
  var pasado=!inicio, visibles=0;
  var pinta=function(){ var on=pasado&&visibles===0; bar.classList.toggle('on',on); if(on) bar.removeAttribute('inert'); else bar.setAttribute('inert',''); };
  if(inicio) new IntersectionObserver(function(es){ var e=es[es.length-1]; pasado=!e.isIntersecting&&e.boundingClientRect.top<0; pinta(); }).observe(inicio);
  var estado=new WeakMap();
  var io=new IntersectionObserver(function(es){ es.forEach(function(e){ var antes=estado.get(e.target)||false; if(e.isIntersecting!==antes){ visibles+=e.isIntersecting?1:-1; estado.set(e.target,e.isIntersecting); } }); pinta(); });
  fines.forEach(function(el){ io.observe(el); });
  pinta();
})();
