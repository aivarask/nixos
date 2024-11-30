<?php if ($host == "a.local"): ?>
	<form method="post" action="/upload.php" enctype="multipart/form-data">
		<input type="file" name="upfile">
		<input type="submit">
	</form>
<?php endif ?>
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
