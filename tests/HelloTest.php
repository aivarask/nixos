<?php

declare(strict_types=1);

namespace App\Tests;

require_once __DIR__ . '/../vendor/autoload.php';

use PHPUnit\Framework\TestCase;

final class HelloTest extends TestCase
{

  public function testSimple()
  {
    $a = 1;
    $this->assertSame($a, 1);
  }
}
