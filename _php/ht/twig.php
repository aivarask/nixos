<?php

use Twig\Environment;
use Twig\Loader\FilesystemLoader;

const FOO = "FOO";

function twigEnv()
{
  // https://twig.symfony.com/doc/3.x/api.html#built-in-extensions
  // $twig->addExtension(new \Twig\Extension\DebugExtension);
  // $twig->addExtension(new ListExtension);

  $loader = new FilesystemLoader(__DIR__);
  $twig = new Environment($loader, ['debug' => true,]);

  return $twig;
}
