<?php
session_start();
$uri = $_SERVER['REQUEST_URI'];
$host = $_SERVER['HTTP_HOST'];
// $lang = substr($_SERVER['HTTP_ACCEPT_LANGUAGE'], 0, 2);
$langurl = strtok($uri, '/');

if (empty($langurl)) {
	header('Location: ' . "/en");
}

function t($key)
{
	global $langurl;
	$all = array(
		"home" => array('Pagrindinis', 'Home'),
		"about" => array('Apie mus', 'About Us'),
		"contact" => array('Kontaktai', 'Contact Us')
	);
	echo $all[$key][0];
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>gettransfer</title>
	<link rel="icon" type="image/x-icon" href="about:blank" />
	<link rel="stylesheet" href="/style.css">
</head>

<body>
	<div class="wrap">
		<nav>
			<a href="/<?php echo $langurl ?>/"><?php t('home') ?></a>
			<a href="/<?php echo $langurl ?>/about"><?php t('about') ?></a>
			<a href="/<?php echo $langurl ?>/contact"><?php t('contact') ?></a>
		</nav>
		<div id="content">

			<!-- <img src="bgl.png"> -->
			<?php if (false): ?>
			<?php elseif ($uri == '/phpinfo'): phpinfo() ?>
			<?php elseif ($uri == '/ini'): ?>
				<pre>
			<?php var_dump(ini_get_all()); ?>
		</pre>
			<?php elseif ($uri == '/server'): ?>
				<pre><?php var_dump($_SERVER) ?></pre>
			<?php elseif ($uri == '/session'): ?>
				<pre><?php var_dump($_SESSION) ?></pre>
			<?php elseif ($uri == '/env'): ?>
				<pre><?php var_dump($_ENV) ?></pre>
			<?php elseif (false): ?>
			<?php else: ?>
			<?php endif; ?>
		</div>
		<footer>
			<?php if ($host == "a.local"): ?>
				<nav>
					<a href="/ini">ini</a>
					<a href="/server">server</a>
					<a href="/session">session</a>
					<a href="/env">env</a>
					<form method="post" action="/upload.php" enctype="multipart/form-data">
						<input type="file" name="upfile">
						<input type="submit">
					</form>
				</nav>
			<?php endif ?>
		</footer>
	</div>
	<script>
		var es = new EventSource("/sse.php");
		var listener = function(event) {
			if (typeof event.data !== 'undefined') {
				console.log(event.data);
				setTimeout(function() {
					return window.location.reload()
				}, <?php echo getenv('INTERVAL') ?>)
			}
		};
		// es.addEventListener("open", listener);
		es.addEventListener("message", listener);
		// es.addEventListener("error", listener);
	</script>
</body>

</html>
