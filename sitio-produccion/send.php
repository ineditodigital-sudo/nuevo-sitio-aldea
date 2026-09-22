<?php
header('Content-Type: application/json; charset=utf-8');
if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') { http_response_code(405); echo json_encode(['ok'=>false]); exit; }
$raw = file_get_contents('php://input');
$d = json_decode($raw, true);
if (!is_array($d)) $d = $_POST;
$name    = trim((string)($d['name'] ?? ''));
$email   = trim((string)($d['email'] ?? ''));
$phone   = trim((string)($d['phone'] ?? ''));
$message = trim((string)($d['message'] ?? ''));
$company = trim((string)($d['company'] ?? ''));
$city    = trim((string)($d['city'] ?? ''));
$team    = trim((string)($d['team_size'] ?? ''));
$source  = trim((string)($d['source'] ?? 'web'));
$location  = trim((string)($d['location'] ?? ''));
$product   = trim((string)($d['product'] ?? ''));
$formType  = trim((string)($d['form_type'] ?? 'contacto'));
$visitDate = trim((string)($d['visit_date'] ?? ''));
$visitTime = trim((string)($d['visit_time'] ?? ''));
$role      = trim((string)($d['role'] ?? ''));
$targetDate= trim((string)($d['target_date'] ?? ''));
$utm = [];
foreach (['utm_source','utm_medium','utm_campaign','utm_content','utm_term'] as $k) {
  $utm[$k] = trim((string)($d[$k] ?? ''));
}
$url     = trim((string)($d['url'] ?? ''));
if (!empty($d['website'])) { echo json_encode(['ok'=>true]); exit; } // honeypot
if ($name === '' || !filter_var($email, FILTER_VALIDATE_EMAIL)) { http_response_code(422); echo json_encode(['ok'=>false,'error'=>'Datos invalidos']); exit; }
function h($s){ return htmlspecialchars($s, ENT_QUOTES, 'UTF-8'); }
// Guardar el lead en la base (no romper el envio si falla)
try{
  require_once __DIR__.'/cms/db.php';
  $ip=$_SERVER['REMOTE_ADDR']??'';
  try{
    cms_pdo()->prepare("INSERT INTO leads (name,email,phone,company,city,team_size,message,source,url,ip,location,product,form_type,visit_date,visit_time,utm_source,utm_medium,utm_campaign,utm_content,utm_term,role,target_date) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)")
      ->execute([$name,$email,$phone,$company,$city,$team,$message,$source,$url,$ip,
                 $location,$product,$formType,($visitDate?:null),($visitTime?:null),
                 $utm['utm_source'],$utm['utm_medium'],$utm['utm_campaign'],$utm['utm_content'],$utm['utm_term'],
                 $role,$targetDate]);
  }catch(Throwable $e2){
    // Base sin las columnas nuevas: guardar los datos extra dentro del mensaje
    $extra=[]; if($company!=='')$extra[]='Empresa: '.$company; if($city!=='')$extra[]='Ciudad de interes: '.$city; if($team!=='')$extra[]='Numero de personas: '.$team;
    if($location!=='')$extra[]='Sede: '.$location; if($product!=='')$extra[]='Producto: '.$product;
    if($visitDate!=='')$extra[]='Visita: '.$visitDate.' '.$visitTime;
    if($role!=='')$extra[]='Cargo: '.$role; if($targetDate!=='')$extra[]='Fecha objetivo: '.$targetDate;
    foreach($utm as $uk=>$uv){ if($uv!=='')$extra[]=$uk.': '.$uv; }
    $msg2=trim(($extra?implode("\n",$extra)."\n":'').$message);
    cms_pdo()->prepare("INSERT INTO leads (name,email,phone,message,source,url,ip) VALUES (?,?,?,?,?,?,?)")
      ->execute([$name,$email,$phone,$msg2,$source,$url,$ip]);
  }
}catch(Throwable $e){}
$host   = $_SERVER['HTTP_HOST'] ?? 'aldea.work';
$parts  = explode('.', $host);
$domain = implode('.', array_slice($parts, -2));
$logo   = 'https://'.$host.'/img/logo-blanco.png';
$to     = 'contacto@aldea.work';
if ($formType === 'visita') {
  $subject = 'VISITA AGENDADA'.($location!==''?' - '.strtoupper($location):'').' - '.$name;
} elseif ($formType === 'corporativo') {
  $subject = 'PROYECTO CORPORATIVO - '.($company!==''?$company:$name);
} else {
  $ctx = $location!=='' ? $location : $city;
  $subject = 'Nuevo contacto desde el sitio'.($ctx!==''?' ('.$ctx.')':'').' - '.$name;
}
function row($label,$value){ if($value==='') return ''; return '<tr><td style="padding:11px 0;border-bottom:1px solid #e5eaf1;width:120px;color:#5c6577;font-size:14px;vertical-align:top;">'.$label.'</td><td style="padding:11px 0;border-bottom:1px solid #e5eaf1;color:#16203a;font-size:15px;">'.$value.'</td></tr>'; }
$rows = row('Nombre', h($name))
      . row('Empresa', h($company))
      . row('Email', '<a href="mailto:'.h($email).'" style="color:#2563eb;text-decoration:none;">'.h($email).'</a>')
      . row('Telefono', $phone!=='' ? '<a href="tel:'.h($phone).'" style="color:#2563eb;text-decoration:none;">'.h($phone).'</a>' : '')
      . row('Cargo', h($role))
      . row('Ciudad de interes', h($city))
      . row('Fecha objetivo', h($targetDate))
      . row('No. de personas', h($team))
      . row('Sede', h($location))
      . row('Espacio de interes', h($product))
      . row('Fecha de visita', $visitDate!=='' ? h($visitDate.($visitTime!==''?' a las '.$visitTime:'')) : '')
      . row('Campana', h(trim(implode(' / ', array_filter([$utm['utm_source'],$utm['utm_medium'],$utm['utm_campaign']])))))
      . row('Origen', h($source))
      . row('Pagina', $url!=='' ? '<a href="'.h($url).'" style="color:#2563eb;text-decoration:none;">'.h($url).'</a>' : '');
$msgbox = $message!=='' ? '<div style="margin-top:18px;background:#f4f7fb;border-left:3px solid #2563eb;border-radius:8px;padding:14px 16px;color:#16203a;font-size:15px;line-height:1.6;">'.nl2br(h($message)).'</div>' : '';
$html = '<!doctype html><html><body style="margin:0;background:#f4f7fb;font-family:Arial,Helvetica,sans-serif;">'
  .'<table width="100%" cellpadding="0" cellspacing="0" style="background:#f4f7fb;padding:24px 12px;"><tr><td align="center">'
  .'<table width="600" cellpadding="0" cellspacing="0" style="max-width:600px;width:100%;background:#ffffff;border-radius:16px;overflow:hidden;box-shadow:0 8px 30px rgba(24,41,67,.08);">'
  .'<tr><td style="background:#182943;padding:26px 32px;"><img src="'.$logo.'" alt="Aldea Networking" height="30" style="height:30px;display:block;border:0;"></td></tr>'
  .'<tr><td style="height:4px;background:#2563eb;line-height:4px;font-size:0;">&nbsp;</td></tr>'
  .'<tr><td style="padding:30px 32px;">'
  .'<p style="margin:0 0 4px;font-size:12px;letter-spacing:.08em;text-transform:uppercase;color:#2563eb;font-weight:bold;">'.($formType==='visita'?'Visita agendada':($formType==='corporativo'?'Proyecto corporativo':'Nuevo contacto')).'</p>'
  .'<h1 style="margin:0 0 20px;font-size:22px;color:#0f1c30;">'.($formType==='visita'?'Solicitud de visita a la sede':($formType==='corporativo'?'Nuevo proyecto de Oficinas Corporativas':'Solicitud desde el sitio web')).'</h1>'
  .'<table width="100%" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">'.$rows.'</table>'.$msgbox
  .'<p style="margin:24px 0 0;"><a href="mailto:'.h($email).'" style="background:#2563eb;color:#ffffff;text-decoration:none;padding:12px 24px;border-radius:999px;font-weight:bold;display:inline-block;font-size:14px;">Responder a '.h($name).'</a></p>'
  .'</td></tr>'
  .'<tr><td style="padding:18px 32px;background:#0f1c30;color:#aebbcf;font-size:12px;line-height:1.5;">Aldea Networking &mdash; Oficinas en renta y coworking.<br>Mensaje generado automaticamente desde el formulario de contacto.</td></tr>'
  .'</table></td></tr></table></body></html>';
$headers  = "MIME-Version: 1.0\r\n";
$headers .= "Content-Type: text/html; charset=UTF-8\r\n";
$headers .= "From: Aldea Web <no-reply@".$domain.">\r\n";
$headers .= "Reply-To: ".preg_replace('/[\r\n]/','',$name)." <".$email.">\r\n";
$subjEnc = '=?UTF-8?B?'.base64_encode($subject).'?=';
$ok = @mail($to, $subjEnc, $html, $headers, '-fno-reply@'.$domain);
if(!$ok){ http_response_code(500); echo json_encode(['ok'=>false,'error'=>'No se pudo enviar']); exit; }
echo json_encode(['ok'=>true]);
