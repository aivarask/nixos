<?php
require_once __DIR__ . './../vendor/autoload.php';

$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();
// echo $_ENV["DB"];

$loader = new \Twig\Loader\FilesystemLoader('.');
$twig = new \Twig\Environment($loader, [
  // 'cache' => 'cache',
]);

$template = $twig->load('home.twig');
echo $template->render();
