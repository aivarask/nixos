<?php
header("Content-Type: text/event-stream");
header("Cache-Control: no-cache");

echo "event: single\n";
echo "data: " . time() . "|\n";
echo PHP_EOL;
flush();

// while (true) {
//   if (connection_aborted()) break;
//   sleep(1);
// }
