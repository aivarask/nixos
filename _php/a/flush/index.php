<?php

require_once __DIR__ . '/../vendor/autoload.php';

ob_implicit_flush(true);

for ($i = 0; $i < 3; $i++) {
  ob_start();
  echo $i . '<br>';
  ob_flush();
  flush();
  sleep(1);
}
