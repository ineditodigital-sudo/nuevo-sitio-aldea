function setLang(lang){
  document.documentElement.lang=lang;
  document.querySelectorAll('[data-es]').forEach(function(el){var t=el.getAttribute('data-'+lang);if(t!=null)el.textContent=t;});
  document.querySelectorAll('[data-ph-es]').forEach(function(el){var t=el.getAttribute('data-ph-'+lang);if(t!=null)el.setAttribute('placeholder',t);});
  document.querySelectorAll('#lang button').forEach(function(b){b.classList.toggle('on',b.getAttribute('data-lang')===lang);});
  try{localStorage.setItem('aldea_lang',lang);}catch(e){}
}
document.querySelectorAll('#lang button').forEach(function(b){b.addEventListener('click',function(){setLang(b.getAttribute('data-lang'));});});
var _l='es';try{_l=localStorage.getItem('aldea_lang')||'es';}catch(e){}
setLang(_l);

var hdr=document.getElementById('hdr');
if(hdr){var os=function(){hdr.classList.toggle('scr',window.scrollY>20);};os();window.addEventListener('scroll',os,{passive:true});}

var burger=document.getElementById('burger'),nav=document.getElementById('nav');
if(burger&&nav){burger.addEventListener('click',function(){nav.classList.toggle('open');});
  nav.querySelectorAll('a').forEach(function(a){a.addEventListener('click',function(){nav.classList.remove('open');});});}

var PRICES={
  ags:{privada:'7,400',cowork:'2,700',virtual:'2,400',soon:false},
  leon:{privada:'8,600',cowork:'3,100',virtual:'2,400',soon:false},
  slp:{privada:'8,600',cowork:'3,100',virtual:'2,400',soon:false},
  qro:{privada:'10,800',cowork:'3,100',virtual:'2,400',soon:true}
};
function setCity(city){
  var d=PRICES[city];if(!d)return;
  var pp=document.getElementById('p-privada'),pc=document.getElementById('p-cowork'),pv=document.getElementById('p-virtual'),sn=document.getElementById('soonNote');
  if(pp)pp.textContent=d.privada;if(pc)pc.textContent=d.cowork;if(pv)pv.textContent=d.virtual;if(sn)sn.hidden=!d.soon;
  document.querySelectorAll('#cityTabs button').forEach(function(b){b.classList.toggle('on',b.getAttribute('data-city')===city);});
}
document.querySelectorAll('#cityTabs button').forEach(function(b){b.addEventListener('click',function(){setCity(b.getAttribute('data-city'));});});

var io=new IntersectionObserver(function(en){en.forEach(function(e){if(e.isIntersecting){e.target.classList.add('vis');io.unobserve(e.target);}});},{threshold:.12});
document.querySelectorAll('.reveal').forEach(function(el){io.observe(el);});

var yr=document.getElementById('yr');if(yr)yr.textContent=new Date().getFullYear();

function aldeaSubmit(ev){
  ev.preventDefault();
  var lang=document.documentElement.lang,msg=document.getElementById('formMsg');
  if(msg){msg.textContent=lang==='en'?'✓ Thanks! This is a preview — the form will connect to the CRM in production.':'✓ ¡Gracias! Esta es una vista previa — el formulario se conectará al CRM en producción.';msg.style.color='#1a7f4b';}
  ev.target.reset();return false;
}
