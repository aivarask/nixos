<?php

require_once __DIR__ . '/../vendor/autoload.php';


header('HX-Trigger: {"alert":{"level":"info", "message":"Foo"}}');
echo '';
