<?php require __DIR__.'/../cms/lib.php'; cms_session(); $_SESSION=[]; @session_destroy(); header('Location: /admin/login.php'); exit;
