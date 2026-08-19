<?php require __DIR__.'/../cms/lib.php'; cms_require_login(); require_once __DIR__.'/_crud.php';
header('Content-Type: application/json');
$u=crud_upload('file');
echo json_encode($u?['url'=>$u]:['error'=>'upload failed']);
