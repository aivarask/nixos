<?php
require_once __DIR__ . './../vendor/autoload.php';

$loader = new \Twig\Loader\FilesystemLoader('.');
$twig = new \Twig\Environment($loader, [
  // 'cache' => 'cache',
]);

$template = $twig->load('foo.twig');
echo $template->render();
