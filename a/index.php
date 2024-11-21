<?php

session_start();
$uri = $_SERVER['REQUEST_URI'];
$hostname = gethostname();
$remote = $_SERVER['REMOTE_ADDR'];
$is_local = $remote == '127.0.0.1';
$host = $_SERVER['HTTP_HOST'];
$lang_accept = substr($_SERVER['HTTP_ACCEPT_LANGUAGE'], 0, 2);
$langs = ['en', 'lt', 'ru'];
$langurl = strtok($uri, '/');
$lang_index = array_search($langurl, $langs);

if ($lang_index == false && !$langurl) {
	header('Location: ' . "/en/");
	exit;
}

function t($key)
{
	global $lang_index;
	$all = array(
		"home" => ['Home', 'Pagrindinis', 'home_ru'],
		"about" => ['About Us', 'Apie mus', 'about_ru'],
		"contact" => ['Contact Us', 'Kontaktai', 'contact_ru']
	);
	return $all[$key][$lang_index];
}

include 'Parsedown.php'; // https://github.com/erusev/parsedown
include 'ParsedownExtra.php'; // https://github.com/erusev/parsedown-extra
$Pd = new ParsedownExtra();
$file = file_get_contents("./i18n/en.md");
$html = $Pd->text($file);
libxml_use_internal_errors(true);
$doc = new DOMDocument();
$doc->loadHTML($html);
// $intro = $doc->getElementById('intro');
// $intro_html = $intro->ownerDocument->saveXML($intro);

?>

<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title></title>
	<link rel="icon" type="image/x-icon" href="about:blank" />
	<link rel="stylesheet" href="/style.css">
</head>

<body>
	<div class="wrap">
		<nav>
			<a href="/<?= $langurl ?>/"><?= t('home') ?></a>
			<a href="/<?= $langurl ?>/about"><?= t('about') ?></a>
			<a href="/<?= $langurl ?>/contact"><?= t('contact') ?></a>
			<?php foreach ($langs as $l) { ?>
				<a href="/<?= $l ?>/"><?= $l; ?></a>
			<?php } ?>
		</nav>
		<div id="content">
			<?= $html ?>
			<pre>
					<?php if (false): ?>
					<?php elseif (strpos($uri, '/phpinfo')): {
							phpinfo();
						} ?>
					<?php elseif ($uri == '/ini'): var_dump(ini_get_all()); ?>
					<?php elseif ($uri == '/server'): var_dump($_SERVER) ?>
					<?php elseif ($uri == '/session'): var_dump($_SESSION) ?>
					<?php elseif ($uri == '/env'): var_dump($_ENV) ?>
					<?php elseif (false): ?>
					<?php else: ?>
					<?php endif; ?>
				</pre>
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
	<?php if (false): ?>
		<script>
			console.log('sse enabled');
			var es = new EventSource("/sse.php");
			var listener = function(event) {
				if (typeof event.data !== 'undefined') {
					console.log(event.data);
					setTimeout(function() {
						return window.location.reload()
					}, <?= getenv('INTERVAL') ?>)
				}
			};
			// es.addEventListener("open", listener);
			es.addEventListener("message", listener);
			// es.addEventListener("error", listener);
		</script>
	<?php endif; ?>
</body>

</html>
