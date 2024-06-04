<?php

require_once __DIR__ . '/vendor/autoload.php';

use Twig\Loader\FilesystemLoader;
use Twig\Environment;

$loader = new FilesystemLoader(__DIR__);
$twig = new Environment($loader, [
  'debug' => true,
]);

switch ($_SERVER['REQUEST_URI'] ?? null) {
  case '/':
    echo $twig->render('index.twig');
    ob_start();
    print_r($_SERVER);
    $buffer = ob_get_clean();
    echo "<pre>" . htmlentities($buffer) . "</pre>";
    break;

  case '/info':
    break;
}
