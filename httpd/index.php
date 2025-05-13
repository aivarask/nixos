<?php
$COMPANY = 'gettransfer';
$LANGS = array('LT', 'EN', 'RU');
foreach ($LANGS as $lang):
endforeach;
$lang = $_GET['lang'] ?? 'LT';
if (in_array($lang, $LANGS)) {
	$_SESSION['lang'] = $lang;
}
$lang = strtolower($lang)
?>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="icon" type="image/x-icon" href="about:blank" />
	<link rel="stylesheet" href="style.css" />
	<title><?= $COMPANY ?></title>
</head>

<body>
	<p> <?php $about = file("/etc/nixos/httpd/txt/aboutus_{$lang}.txt") ?> <?= implode('<br>', $about) ?> </p>
	<p> <?php $services = file("/etc/nixos/httpd/txt/services_{$lang}.txt") ?> <?= implode('<br>', $services) ?> </p>
	<p> <?php $contact = file("/etc/nixos/httpd/txt/contactus_{$lang}.txt") ?> <?= implode('<br>', $contact) ?> </p>
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
