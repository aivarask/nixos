<?php
header('Content-Type: text/event-stream');
header('Cache-Control: no-cache');
header("Access-Control-Allow-Origin: *");

function send()
{
  echo "event: time" . PHP_EOL;
  echo "retry: 1000" . PHP_EOL;
  echo "data: " . date('h:m:s') . PHP_EOL;
  echo PHP_EOL;
  flush();
}
send();
