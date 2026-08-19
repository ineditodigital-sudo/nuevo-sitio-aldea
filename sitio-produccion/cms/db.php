<?php
function cms_pdo(){
  static $pdo=null;
  if($pdo===null){
    $c=require __DIR__.'/config.php'; $d=$c['db'];
    $pdo=new PDO("mysql:host={$d['host']};dbname={$d['name']};charset={$d['charset']}",$d['user'],$d['pass'],[
      PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION,
      PDO::ATTR_DEFAULT_FETCH_MODE=>PDO::FETCH_ASSOC,
      PDO::ATTR_EMULATE_PREPARES=>false ]);
  }
  return $pdo;
}
