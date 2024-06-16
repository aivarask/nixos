<?php

require_once __DIR__ . '/../vendor/autoload.php';

isset($_REQUEST['greet']) && shell_exec(__DIR__ . "/../greet.sh");

if (isset($_REQUEST['mirror'])) {
  $out = shell_exec(__DIR__ . '/../mirror.sh');
  echo $out;
}

if (isset($_REQUEST['fuser'])) {
  shell_exec('fuser -k 8000/tcp');
}

// dump_request();
$twig = load();
echo $twig->render('base.twig');
