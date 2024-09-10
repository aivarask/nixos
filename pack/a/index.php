<?php

require_once __DIR__ . '/vendor/autoload.php';

if (isset($_REQUEST['tick'])) {

  for ($i = 0; $i < 10; $i++) {
    echo $i . PHP_EOL;
    sleep(1);
  }
}

$twig = load();
echo $twig->render('base.twig');
// echo phpinfo();
