<?php

use Twig\Loader\FilesystemLoader;
use Twig\Environment;
use Twig\Extension\DebugExtension;
use Twig\Extension\StringLoaderExtension;
use Twig\TwigFunction;

ini_set('display_errors', '1');
ini_set('display_startup_errors', '1');
function load()
{
  $loader = new FilesystemLoader([
    '.',
  ], __DIR__);
  $twig = new Environment($loader, [
    'debug' => true,
  ]);
  $twig->addGlobal('S', $_SERVER);
  // https://twig.symfony.com/doc/3.x/api.html#built-in-extensions
  $twig->addExtension(new DebugExtension);
  // $twig->addExtension(new Extension);
  $twig->addExtension(new StringLoaderExtension);

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
      if ($f['attributes']['type'] == 'checkbox' && $f['contents']) {
        // $v = $f['contents'];
        return "checked";
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

function dump_request()
{
  ob_start();
  print_r($_REQUEST);
  print_r($_POST);
  print_r($_SERVER);
  $data = ob_get_clean();
  $twig = load();
  $template = $twig->createTemplate(' {{ data|raw }} ');
  echo $template->render(['data' => "<pre>" . htmlentities($data) . "</pre>"]);
}
