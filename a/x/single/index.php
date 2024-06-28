<?php
session_start();
header('Content-Type: text/event-stream');
header('Cache-Control: no-cache'); // recommended to prevent caching of event data
require __DIR__ . '/../sse.php';
$_SESSION['serverTime'] = time();
$_SESSION['message'] = 'hello ' . time();

ob_start();
sendMsg($_SESSION['serverTime'], $_SESSION['message']);
