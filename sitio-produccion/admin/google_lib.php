<?php
// Libreria de conexion con Google (GA4 Data API + Search Console API)
function g_set($k,$v){ cms_pdo()->prepare("INSERT INTO settings (skey,value) VALUES (?,?) ON DUPLICATE KEY UPDATE value=VALUES(value)")->execute([$k,$v]); }
function g_get($k,$d=''){ $r=cms_pdo()->prepare("SELECT value FROM settings WHERE skey=?"); $r->execute([$k]); $v=$r->fetchColumn(); return $v!==false?$v:$d; }
function g_redirect_uri(){ $h=$_SERVER['HTTP_HOST']??'temporal.aldea.work'; return 'https://'.$h.'/admin/google-callback.php'; }
function g_scopes(){ return 'https://www.googleapis.com/auth/analytics.readonly https://www.googleapis.com/auth/webmasters.readonly'; }
function g_auth_url(){
  $cid=g_get('google_client_id'); if(!$cid) return '';
  $p=['client_id'=>$cid,'redirect_uri'=>g_redirect_uri(),'response_type'=>'code','scope'=>g_scopes(),'access_type'=>'offline','include_granted_scopes'=>'true','prompt'=>'consent'];
  return 'https://accounts.google.com/o/oauth2/v2/auth?'.http_build_query($p);
}
function g_http($url,$post=null,$headers=[]){
  if(!function_exists('curl_init')){ return [0,'']; }
  $ch=curl_init($url); curl_setopt_array($ch,[CURLOPT_RETURNTRANSFER=>true,CURLOPT_TIMEOUT=>25,CURLOPT_HTTPHEADER=>$headers,CURLOPT_SSL_VERIFYPEER=>true]);
  if($post!==null){ curl_setopt($ch,CURLOPT_POST,true); curl_setopt($ch,CURLOPT_POSTFIELDS,$post); }
  $r=curl_exec($ch); $code=curl_getinfo($ch,CURLINFO_HTTP_CODE); curl_close($ch); return [$code,$r];
}
function g_exchange_code($code){
  $cid=g_get('google_client_id'); $cs=g_get('google_client_secret');
  [$c,$b]=g_http('https://oauth2.googleapis.com/token',http_build_query([
    'code'=>$code,'client_id'=>$cid,'client_secret'=>$cs,'redirect_uri'=>g_redirect_uri(),'grant_type'=>'authorization_code']),
    ['Content-Type: application/x-www-form-urlencoded']);
  $j=json_decode($b,true);
  if(!empty($j['refresh_token'])) g_set('google_refresh_token',$j['refresh_token']);
  if(!empty($j['access_token'])){ g_set('google_access_token',$j['access_token']); g_set('google_token_expires',time()+(int)($j['expires_in']??3600)); return true; }
  return false;
}
function g_access_token(){
  $at=g_get('google_access_token'); $exp=(int)g_get('google_token_expires');
  if($at && $exp>time()+60) return $at;
  $rt=g_get('google_refresh_token'); $cid=g_get('google_client_id'); $cs=g_get('google_client_secret');
  if(!$rt||!$cid||!$cs) return null;
  [$c,$b]=g_http('https://oauth2.googleapis.com/token',http_build_query([
    'client_id'=>$cid,'client_secret'=>$cs,'refresh_token'=>$rt,'grant_type'=>'refresh_token']),
    ['Content-Type: application/x-www-form-urlencoded']);
  $j=json_decode($b,true);
  if(!empty($j['access_token'])){ g_set('google_access_token',$j['access_token']); g_set('google_token_expires',time()+(int)($j['expires_in']??3600)); return $j['access_token']; }
  return null;
}
function g_connected(){ return g_get('google_refresh_token')!==''; }
function g_disconnect(){ foreach(['google_refresh_token','google_access_token','google_token_expires'] as $k) g_set($k,''); }
function g_api_post($url,$payload){ $t=g_access_token(); if(!$t)return null; [$c,$b]=g_http($url,json_encode($payload),["Authorization: Bearer $t","Content-Type: application/json"]); $j=json_decode($b,true); return $c==200?$j:['_error'=>$c,'_msg'=>($j['error']['message']??'')]; }
function ga4_report($metrics,$dimensions=[],$days=28,$limit=10,$orderMetric=null){
  $pid=preg_replace('/[^0-9]/','',g_get('ga4_property_id')); if(!$pid)return ['_error'=>'noprop'];
  $payload=['dateRanges'=>[['startDate'=>$days.'daysAgo','endDate'=>'today']],'metrics'=>array_map(fn($m)=>['name'=>$m],$metrics),'limit'=>$limit];
  if($dimensions)$payload['dimensions']=array_map(fn($d)=>['name'=>$d],$dimensions);
  if($orderMetric)$payload['orderBys']=[['metric'=>['metricName'=>$orderMetric],'desc'=>true]];
  return g_api_post("https://analyticsdata.googleapis.com/v1beta/properties/$pid:runReport",$payload);
}
function gsc_query($dimensions=['query'],$days=28,$limit=10){
  $site=g_get('gsc_site_url'); if(!$site)return ['_error'=>'nosite'];
  $payload=['startDate'=>date('Y-m-d',strtotime("-$days days")),'endDate'=>date('Y-m-d'),'dimensions'=>$dimensions,'rowLimit'=>$limit];
  return g_api_post("https://searchconsole.googleapis.com/webmasters/v3/sites/".rawurlencode($site)."/searchAnalytics/query",$payload);
}

function ga4_dates($start,$end,$metrics,$dims=[],$limit=10,$orderMetric=null,$orderDim=null){
  $pid=preg_replace('/[^0-9]/','',g_get('ga4_property_id')); if(!$pid)return ['_error'=>'noprop'];
  $payload=['dateRanges'=>[['startDate'=>$start,'endDate'=>$end]],'metrics'=>array_map(fn($m)=>['name'=>$m],$metrics),'limit'=>$limit];
  if($dims)$payload['dimensions']=array_map(fn($d)=>['name'=>$d],$dims);
  if($orderMetric)$payload['orderBys']=[['metric'=>['metricName'=>$orderMetric],'desc'=>true]];
  elseif($orderDim)$payload['orderBys']=[['dimension'=>['dimensionName'=>$orderDim],'desc'=>false]];
  return g_api_post("https://analyticsdata.googleapis.com/v1beta/properties/$pid:runReport",$payload);
}
function gsc_dates($start,$end,$dims=['query'],$limit=10){
  $site=g_get('gsc_site_url'); if(!$site)return ['_error'=>'nosite'];
  $payload=['startDate'=>$start,'endDate'=>$end,'dimensions'=>$dims,'rowLimit'=>$limit];
  return g_api_post("https://searchconsole.googleapis.com/webmasters/v3/sites/".rawurlencode($site)."/searchAnalytics/query",$payload);
}
