<?php

$langs = array('LT', 'EN', 'RU');

foreach ($langs as $lang): ?>
    <a href="index.php?lang=<?=$lang;?>"> <?=$lang;?> </a>
<?php endforeach; ?>

<?php 
if(in_array($_GET['lang'], $langs)) {
    $_SESSION['lang'] = $_GET['lang']; // to prevent user to change its session to something you don't want to
}
?>

