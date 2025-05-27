<?php
$COMPANY = 'gettransfer';
$server_name = $_SERVER['SERVER_NAME'];
$document_root = $_SERVER['DOCUMENT_ROOT']
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
	<pre>
			<?php
			# var_dump($_SERVER);
			# var_dump($_SESSION);
			?>
		</pre>
	<?php include('lang.php'); ?>
	<?php include('branch.php'); ?>

	<?php
	$about = file("{$document_root}/content/about_{$lang}.txt");
	$about_title = array_slice($about, 0, 2);
	$about_content = array_slice($about, 2, count($about) - 2);
	?>

	<h1><?= implode('', $about_title); ?></h1>
	<p> <?= implode('', $about_content); ?> </p>
	<p> <?php $services = file("{$document_root}/content/services_{$lang}.txt") ?> <?= implode('', $services) ?> </p>
	<p> <?php $contact = file("{$document_root}/content/contact_{$lang}.txt") ?> <?= implode('', $contact) ?> </p>
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
