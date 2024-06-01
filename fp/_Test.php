<?php
require_once __DIR__ . "/vendor/autoload.php";

use PHPUnit\Framework\TestCase;

final class _Test extends TestCase
{
  function extractWord($text, $position)
  {
    $words = explode(' ', $text);
    $characters = 0;
    foreach ($words as $word) {
      $characters += (strlen($word) + 1);
      if ($characters >= $position) {
        return $word;
      }
    }
    return '';
  }
  function testSentence()
  {
    $this->assertEquals(1, 1);
    $s = 'foo bar baz';
    $this->assertEquals('foo', $this->extractWord($s, 1));
    $this->assertEquals('foo', $this->extractWord($s, 2));
    $this->assertEquals('foo', $this->extractWord($s, 3));
    $this->assertEquals('foo', $this->extractWord($s, 4));
    $this->assertEquals('bar', $this->extractWord($s, 5));
    $this->assertEquals('bar', $this->extractWord($s, 6));
    $this->assertEquals('bar', $this->extractWord($s, 7));
    $this->assertEquals('bar', $this->extractWord($s, 8));
    $this->assertEquals('baz', $this->extractWord($s, 9));
    $this->assertEquals('baz', $this->extractWord($s, 10));
    $this->assertEquals('baz', $this->extractWord($s, 11));
    $this->assertEquals('baz', $this->extractWord($s, 12));
  }
}
