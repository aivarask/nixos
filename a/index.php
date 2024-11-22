<?php
session_start();
$req_uri = $_SERVER['REQUEST_URI'];
$hostname = gethostname();
$remote = $_SERVER['REMOTE_ADDR'];
$is_local = $remote == '127.0.0.1';
$host = $_SERVER['HTTP_HOST'];
// $lang_accept = substr($_SERVER['HTTP_ACCEPT_LANGUAGE'], 0, 2);
$langs = ['en', 'lt', 'ru'];
$langurl = strtok($req_uri, '/');
$lang_index = array_search($langurl, $langs);

// if ($lang_index == false && !$langurl) {
// 	header('Location: ' . "/en/");
// 	exit;
// }

include 'lib/Parsedown.php'; // https://github.com/erusev/parsedown
include 'lib/ParsedownExtra.php'; // https://github.com/erusev/parsedown-extra
$Pd = new ParsedownExtra();
$file = file_get_contents("./i18n/en.md");
$html = $Pd->text($file);
libxml_use_internal_errors(true);
$doc = new DOMDocument();
$doc->loadHTML($html);

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
			<a href="/<?= $langurl ?>/"><?= "Home_$langurl" ?></a>
			<a href="/<?= $langurl ?>/about"><?= "About_$langurl" ?></a>
			<a href="/<?= $langurl ?>/contact"><?= "Contact_$langurl" ?></a>
			<?php foreach ($langs as $l) { ?>
				<a href="/<?= $l ?>/"><?= $l; ?></a>
			<?php } ?>
		</nav>
		<div id="content">
		</div>
	</div>
</body>

</html>
