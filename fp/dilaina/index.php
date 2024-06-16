<?php
require_once __DIR__ . '/../vendor/autoload.php';

$dl = new Dilaina();
$dl->paieska($_REQUEST['fraze'] ?? null)->render();
