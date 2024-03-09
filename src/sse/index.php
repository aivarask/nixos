<?php
header('Content-Type: text/event-stream');
header('Cache-Control: no-cache');
function sendMsg($msg)
{
  echo "event: event1" . PHP_EOL;
  // echo "retry: 1000" . PHP_EOL;
  echo "data: $msg " . date('h:m:s') . PHP_EOL;
  echo PHP_EOL;
  flush();
}

sendMsg('foo');
