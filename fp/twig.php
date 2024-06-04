<?php

use Ext\ListExtension;
use Twig\Loader\FilesystemLoader;
use Twig\Environment;
use Twig\TwigFunction;

function load()
{
  $loader = new FilesystemLoader(__DIR__);
  $twig = new Environment($loader, [
    'debug' => true,
  ]);
  // https://twig.symfony.com/doc/3.x/api.html#built-in-extensions
  $twig->addExtension(new \Twig\Extension\DebugExtension);
  $twig->addExtension(new ListExtension);

  $twig->addFunction(new \Twig\TwigFunction('attributes', function (array $f) {
    if (!isset($f['attributes'])) {
      return "";
    } else {
      $a = $f['attributes'];
      return array_reduce(array_keys($a), function ($c, $k) use ($a) {
        $v = $a[$k];
        $c .= "$k=$v ";
        return $c;
      }, "");
    }
  }));
  $twig->addFunction(new \Twig\TwigFunction('isCheckbox', function (array $f) {
    if (!isset($f['attributes']['type'])) {
      return "";
    } else {
      if ($f['attributes']['type'] == 'checkbox') {
        $v = $f['contents'];
        return "checked=$v";
      } else {
        return "";
      }
    }
  }));
  $twig->addFunction(new TwigFunction('isRadioChecked', function ($radioVal, $stateVal) {
    return ($radioVal == $stateVal) ? 'checked' : '';
  }));
  $twig->addFunction(new TwigFunction('isSelected', function ($optionVal, $stateVal) {
    return ($optionVal == $stateVal) ? 'selected="1"' : '';
  }));
  return $twig;
}
