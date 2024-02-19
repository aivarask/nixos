<?php
require_once 'vendor/autoload.php';

use Symfony\Component\Panther\Client;

// $client = Client::createChromeClient();
// alternatively, create a Firefox client
$client = Client::createFirefoxClient();

$client->request('GET', 'https://api-platform.com');
$client->clickLink('Getting started');

// wait for an element to be present in the DOM, even if hidden
$crawler = $client->waitFor('#installing-the-framework');
// you can also wait for an element to be visible
$crawler = $client->waitForVisibility('#installing-the-framework');

// get the text of an element thanks to the query selector syntax
echo $crawler->filter('#installing-the-framework')->text();
// take a screenshot of the current page
$client->takeScreenshot('screen.png');
