<?php
$COMPANY = 'gettransfer';
$server_name = $_SERVER['SERVER_NAME'];
$document_root = $_SERVER['DOCUMENT_ROOT'];
if ($_SERVER['QUERY_STRING'] == '') {
	$query = '';
} else {
	$query = '?' . $_SERVER['QUERY_STRING'];
};

?>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="icon" type="image/x-icon" href="about:blank" />
	<link rel="stylesheet" href="style.css" />
	<title><?= $COMPANY ?></title>
	<style>
		p {
			white-space: pre-line;
		}

		pre {
			background-color: white;
		}
	</style>
</head>

<body>
	<nav>
		<?php include('lang.php'); ?>
		<div id="menu">
			<a href="/<?= $query ?>"><img src="/img/logo_white.svg" /></a>
			<a href="/about<?= $query ?>">About</a>
			<a href="/services<?= $query ?>">Services</a>
			<a href="/contact<?= $query ?>">Contact</a>
		</div>
	</nav>
	<pre hidden>
			<?php
			var_dump($_SERVER);
			?>
		</pre>

	<?php
	$page = $_SERVER['REDIRECT_URL'] ?? '/about';
	$content = file("{$document_root}/content{$page}_{$lang}.txt");
	$title = array_slice($content, 0, 2);
	$text = array_slice($content, 2, count($content) - 2);
	?>
	<section>
		<h1><?= implode('', $title); ?></h1>
		<p> <?= implode('', $text); ?> </p>
	</section>
</body>

<script>
	if (location.hostname === 'localhost') {

		const verbose = true

		var socket = new WebSocket('ws://localhost:4000/');
		socket.addEventListener("open", (event) => {
			verbose && console.log('ws open')
		});
		socket.onclose = function() {
			setTimeout(function() {
				verbose && console.log("ws closed");
				return location.reload()
			}, 2000)
		}
		socket.addEventListener("message", (event) => {
			verbose && console.log(event.data);
			if (event.data === 'save\n') {
				return location.reload()
			}
		});

		function test() {
			socket.send('test')
		}
	}
</script>

</html>
