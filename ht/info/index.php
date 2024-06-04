<?php
require_once __DIR__ . '/../vendor/autoload.php';

$twig = twigEnv();

ob_start();
phpinfo();
$phpinfo = ob_get_clean();
ob_start();
print_r($_REQUEST);
print_r($_SERVER);
$env = ob_get_clean();
echo $twig->render('info/_.twig', [
  'phpinfo' => $phpinfo,
  'env' => "<pre>" . htmlentities($env) . "</pre>"
]);
