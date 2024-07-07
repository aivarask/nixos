<?php

use Twig\Environment;
use Twig\Loader\FilesystemLoader;

function load()
{
  $loader = new FilesystemLoader(['.'], __DIR__);
  $twig = new Environment($loader, ['debug' => true]);
  return $twig;
}
