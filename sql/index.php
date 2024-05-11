<?php
require __DIR__ . '/../vendor/autoload.php';
require_once 'indexTest.php';


loadEnv();
$db_path = $_ENV["DB_PATH"];

$db = new SQLite3($db_path);
$sql_init = $_ENV["SQL_INIT"];

$myfile = fopen($sql_init, "r") or die("Unable to open file!");
$script = fread($myfile, filesize($sql_init));
fclose($myfile);




$qrys = explode(';', $script);

foreach ($qrys as $key => $value) {
  $db->query($value);
}

echo 'hello index.php';
