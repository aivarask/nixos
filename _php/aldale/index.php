<?php
require_once __DIR__ . '/vendor/autoload.php';

$t = load();
echo $t->render('base.twig');
