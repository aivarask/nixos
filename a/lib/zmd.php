<?php

include 'lib/Parsedown.php'; // https://github.com/erusev/parsedown
include 'lib/ParsedownExtra.php'; // https://github.com/erusev/parsedown-extra
$Pd = new ParsedownExtra();
$file = file_get_contents("./i18n/en.md");
$html = $Pd->text($file);
libxml_use_internal_errors(true);
$doc = new DOMDocument();
$doc->loadHTML($html);
