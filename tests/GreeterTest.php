<?php

declare(strict_types=1);

namespace App\Tests;

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
}
