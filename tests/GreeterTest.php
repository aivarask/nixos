<?php

declare(strict_types=1);

namespace App\Tests;

require_once __DIR__ . '/../vendor/autoload.php';

use PHPUnit\Framework\TestCase;
use App\Greeter;

final class GreeterTest extends TestCase
{
  public function testGreetsWithName(): void
  {
    $greeter = new Greeter;

    $greeting = $greeter->greet('Alice');

    $this->assertSame('Hello, Alice!', $greeting);
  }

  public function testSimple()
  {
    $a = 1;
    $this->assertSame($a, 1);
  }
}
