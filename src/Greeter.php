<?php

declare(strict_types=1);
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
