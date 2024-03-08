<?php

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
