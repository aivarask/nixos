<?php

require_once __DIR__ . '/vendor/autoload.php';

$twig = twigEnv();

echo $twig->render('index.twig');
