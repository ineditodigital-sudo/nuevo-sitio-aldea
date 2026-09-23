<?php
function cms_pdo(){
  static $pdo=null;
  if($pdo===null){
    $o=[PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE=>PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES=>false];
    // Copia local (ver local/README.md): el servidor nunca define esta variable.
    if($dsn=getenv('ALDEA_DB_DSN')){ return $pdo=new PDO($dsn,null,null,$o); }
    $c=require __DIR__.'/config.php'; $d=$c['db'];
    $pdo=new PDO("mysql:host={$d['host']};dbname={$d['name']};charset={$d['charset']}",$d['user'],$d['pass'],$o);
  }
  return $pdo;
}
