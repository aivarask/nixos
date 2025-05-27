<?php

$db = new SQLite3('test.db');
$db->exec("CREATE TABLE IF NOT EXISTS cars (id INTEGER PRIMARY KEY, name TEXT, price INT)");
$db->exec("INSERT INTO cars (name, price) VALUES ('Audi', 52642)");
$result = $db->query("SELECT * FROM cars");
while ($row = $result->fetchArray()) {
	echo "Car: " . $row['name'] . ", Price: " . $row['price'] . "\n";
}
