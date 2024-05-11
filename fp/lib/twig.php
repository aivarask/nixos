<?php

use Fp\Twig\ListExtension;
use Twig\Environment;
use Twig\Loader\FilesystemLoader;

function load()
{
  $loader = new FilesystemLoader('.');
  $twig = new Environment($loader, [
    'debug' => true,
  ]);
  // https://twig.symfony.com/doc/3.x/api.html#built-in-extensions
  $twig->addExtension(new \Twig\Extension\DebugExtension);
  $twig->addExtension(new ListExtension);
  return $twig;
}
