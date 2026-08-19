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
if(burger&&nav){burger.addEventListener('click',function(){nav.classList.toggle('open');});
  nav.querySelectorAll('a').forEach(function(a){a.addEventListener('click',function(){if(a.parentElement&&a.parentElement.classList.contains('hdr-drop')&&window.innerWidth<=980)return;nav.classList.remove('open');});});}

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
document.querySelectorAll('.hdr-drop').forEach(function(drop){var t=drop.querySelector('a');if(t)t.addEventListener('click',function(e){if(window.innerWidth<=980){e.preventDefault();drop.classList.toggle('open');}});});

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
