<?php

use Twig\TwigFilter;

require_once __DIR__ . '/../vendor/autoload.php';

$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();
// echo $_ENV["DB"];


$loader = new \Twig\Loader\FilesystemLoader('.');
$twig = new \Twig\Environment($loader, [
  // 'cache' => 'cache',
]);
$twig->getExtension(\Twig\Extension\CoreExtension::class)->setTimezone('Europe/Vilnius');
$twig->addFilter(new TwigFilter(
  'price',
  function ($number, $decimals = 0, $decPoint = '.', $thousandsSep = ',') {
    $price = number_format($number, $decimals, $decPoint, $thousandsSep);
    $price = '$' . $price;

    return $price;
  }
));

$template = $twig->load('_.twig');
echo $template->render();
