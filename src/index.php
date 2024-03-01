<?php
require __DIR__ . './../vendor/autoload.php';

echo 'LONG';
for ($i = 0; $i < 3; $i++) {
  sleep(1);
  echo 'TICK' . $i;
}
echo 'LONG_FINISH';
