<div id="lang">
	<?php

	$LANG = array('lt', 'en', 'ru');
	foreach ($LANG as $lang): ?>
		<a href="?<?= http_build_query(array_merge($_GET, array('lang' => $lang))) ?>"><?= strtoupper($lang) ?></a>
	<?php endforeach;
	$lang = $_GET['lang'] ?? 'lt';
	if (in_array($lang, $LANG)) {
		$_SESSION['lang'] = $lang;
	} else {
		$_SESSION['lang'] = 'lt';
	}
	$lang = $_SESSION['lang']; ?>
</div>
