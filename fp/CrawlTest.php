<?php
require_once __DIR__ . "/vendor/autoload.php";

use PHPUnit\Framework\TestCase;

final class CrawlTest extends TestCase
{
  public function testEdit(): void
  {
    $cr = new Crawl;

    $r = $cr->edit('50209');

    var_dump($r);
  }
}
