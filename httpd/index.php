<?php
$COMPANY = 'gettransfer';
$CONTENT_PATH = '/etc/nixos/httpd/content';
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
	</style>
</head>

<body>
	<?php include('lang.php'); ?>
	<?php include('branch.php'); ?>

	<p> <?php $about = file("{$CONTENT_PATH}/about_{$lang}.txt") ?> <?= implode('', $about); ?> </p>
	<p> <?php $services = file("{$CONTENT_PATH}/services_{$lang}.txt") ?> <?= implode('', $services) ?> </p>
	<p> <?php $contact = file("{$CONTENT_PATH}/contact_{$lang}.txt") ?> <?= implode('', $contact) ?> </p>
	<pre> <?= var_dump($_SESSION) ?>
	</pre>
</body>

<script>
	const verbose = false
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
</script>

</html>
