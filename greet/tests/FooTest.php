<?php

declare(strict_types=1);

use PHPUnit\Framework\TestCase;

final class FooTest extends TestCase
{
  public function testGreetsWithName(): void
  {
    $greeter = new Foo;

    $greeting = $greeter->greet('Alice');

    $this->assertSame('Hello, Alice!', $greeting);
  }
}
