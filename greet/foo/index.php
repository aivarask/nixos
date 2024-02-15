<?php

require __DIR__ . '/../vendor/autoload.php';

$greeter = new Greeter;

$greeting = $greeter->greet('Alice');
echo $greeting;
