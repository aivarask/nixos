<?php

declare(strict_types=1);

use Dotenv\Dotenv;
use PHPUnit\Framework\TestCase;

function loadEnv()
{
  $d = Dotenv::createImmutable(__DIR__, '.env');
  $d->safeLoad();
}

final class indexTest extends TestCase
{

  public function testEnv(): void
  {
    loadEnv();
    $db_path = $_ENV["DB_PATH"];
    $this->assertNotEmpty($db_path);
    $this->assertNotEmpty($_ENV["SQL_INIT"]);
  }
}
