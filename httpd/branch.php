<?php
$BRANCH = array('www', 'demo', 'live');
foreach ($BRANCH as $val): ?>
	<a href="?<?= http_build_query(array_merge($_GET, array('b' => $val))) ?>"><?= $val ?></a>
<?php endforeach;
