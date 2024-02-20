<?php

echo 'LONG';
for ($i = 0; $i < 10; $i++) {
  sleep(1);
  echo 'TICK' . $i;
}
echo 'LONG_FINISH';
