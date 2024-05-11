<?php

// use Symfony\Component\CssSelector\CssSelectorConverter;

require_once __DIR__ . "/../vendor/autoload.php";

$p = __DIR__ . '/./50353.html';
$myfile = fopen($p, "r") or die("Unable to open file!");
$source = fread($myfile, filesize($p));
fclose($myfile);
libxml_use_internal_errors(true);
$sDoc = new DOMDocument();
$sDoc->loadHTML($source);

$dDoc = new DOMDocument();
$dDoc->formatOutput = TRUE;
$dDoc->preserveWhiteSpace = FALSE;

$f = new DOMElement('form');
$dDoc->appendChild($f);
$f->setAttribute('method', 'POST');
$f->setAttribute('action', '/up.php');



$f->appendChild($dDoc->importNode($sDoc->getElementById('good_id'), TRUE));
$f->appendChild($dDoc->importNode($sDoc->getElementById('name_EN'), TRUE));
$f->appendChild($dDoc->importNode($sDoc->getElementById('name_LT'), TRUE));
$f->appendChild($dDoc->importNode($sDoc->getElementById('base_price'), TRUE));
$f->appendChild($dDoc->importNode($sDoc->getElementById('absolute_manual_price_A'), TRUE));
$f->appendChild($dDoc->importNode($sDoc->getElementById('absolute_manual_price_B'), TRUE));
$f->appendChild($dDoc->importNode($sDoc->getElementById('absolute_manual_price_C'), TRUE));
$f->appendChild($dDoc->importNode($sDoc->getElementById('good_quantity'), TRUE));
$f->appendChild($dDoc->importNode($sDoc->getElementById('description_EN'), TRUE));
$f->appendChild($dDoc->importNode($sDoc->getElementById('description_LT'), TRUE));
// pub
$f->appendChild($dDoc->importNode($sDoc->getElementById('good_visibility_EN'), TRUE));
$f->appendChild($dDoc->importNode($sDoc->getElementById('good_visibility_LT'), TRUE));

$s = new DOMElement('button', 'Submit');
$f->appendChild($s);


echo $dDoc->saveHTML();
// $dDoc->saveHTMLFile(__DIR__ . '/./2.html');

// exit;
