<?php
require_once 'vendor/autoload.php';

$loader = new \Twig\Loader\FilesystemLoader('.');
$twig = new \Twig\Environment($loader, [
  // 'cache' => 'cache',
]);

$template = $twig->load('lay.html');
echo $template->render(['the' => 'variables']);

$db = new SQLite3('db.sqlite');

$drop = $db->query('DROP TABLE IF EXISTS users');

$result = $db->query("
  CREATE TABLE IF NOT EXISTS users (
    id    INTEGER PRIMARY KEY,
    name  TEXT    NOT NULL
  );
");

while ($data = $result->fetchArray()) {
  echo $data['column'] . "<hr>";
}
