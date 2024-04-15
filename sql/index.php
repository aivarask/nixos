<?php

$db = new SQLite3("sql/_.db");

$myfile = fopen("/etc/nixos/sql/index.sql", "r") or die("Unable to open file!");
$script = fread($myfile, filesize("/etc/nixos/sql/index.sql"));
fclose($myfile);


$qrys = explode(';', $script);

foreach ($qrys as $key => $value) {
  $db->query($value);
}
