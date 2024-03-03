<?php

declare(strict_types=1);

use PHPUnit\Framework\TestCase;

/**
 * This is a Greeter class.
 */
final class Greeter
{
  public function greet(string $name): string
  {
    return 'Hello, ' . $name . '!';
  }
}

final class php_test extends TestCase
{
  public function testGreetsWithName(): void
  {
    $greeter = new Greeter;

    $greeting = $greeter->greet('Alice');

    $this->assertSame('Hello, Alice!', $greeting);
  }
}
