<?php
require_once __DIR__ . '/../vendor/autoload.php';

header("Content-Type: text/event-stream");
header("Cache-Control: no-cache");


$i = 0;
while (true) {
  if ($i < 3) {
    echo "event: ping\n";
  } else {
    echo "event: time\n";
  }
  echo "data: " . time();
  echo "\n\n";
  if (ob_get_contents()) {
    ob_end_flush();
  }
  flush();
  if (connection_aborted()) break;
  sleep(2);
  $i++;
}
