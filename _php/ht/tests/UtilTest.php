<?php
require_once __DIR__ . "/vendor/autoload.php";

use PHPUnit\Framework\TestCase;

final class UtilTest extends TestCase
{
  private static $cr;

  public static function setUpBeforeClass(): void
  {
    self::$cr = new class extends Util
    {
      public function arrayToNameProtected($a)
      {
        return $this->arrayToName($a);
      }
      public function nameToArrayProtected(string $s): array
      {
        return $this->nameToArray($s);
      }
      public function valueByNameProtected(string $n, array $a): mixed
      {
        return $this->valueByName($n, $a);
      }
    };
  }


  function testArrayToName()
  {
    $r = self::$cr->arrayToNameProtected(array('a', 'b', 'c'));
    $this->assertEquals('a[b][c]', $r);
  }

  function testNameToArray()
  {
    $r = self::$cr->nameToArrayProtected('a[b][c]');
    $this->assertEquals(array('a', 'b', 'c'), $r);
  }

  function testValueByName()
  {
    $a = ['a' => ['b' => ['c' => 1]]];
    $n = 'a[b][c]';
    $r = self::$cr->valueByNameProtected($n, $a);
    $this->assertEquals(1, $r);
  }

  // function testReducePost()
  // {
  //   $a =  ['aa' => 1, 'b' => ['c' => 1, 'd' => ['e' => 1, 'f' => ['gg' => 1]], 'x' => 1], 'z' => 1];
  //   $r = self::$cr->pm($a);
  //   $e =
  //     array(
  //       0 => array('name' => 'aa', 'contents' => 1,),
  //       1 => array('name' => 'b[c]', 'contents' => 1,),
  //       2 => array('name' => 'b[d][e]', 'contents' => 1,),
  //       3 => array('name' => 'b[d][f][gg]', 'contents' => 1,),
  //       4 => array('name' => 'b[x]', 'contents' => 1,),
  //       5 => array('name' => 'z', 'contents' => 1,),
  //     );
  //   $this->assertEquals($e, $r);
  // }

  // function testPm()
  // {
  //   $a =
  //     array(
  //       'id' => '50688',
  //       'code' => 'SKU#171531248074046571',
  //       'Translation' => array('EN' => array('name' => 'Battery test', 'description' => '', 'visible' => '0',), 'LT' => array('name' => 'Battery test', 'description' => '', 'visible' => '0',),),
  //       'base_price' => '0',
  //       'tax_id' => '1',
  //       'A' => array('price' => '10', 'price_type' => 'absolute_manual',),
  //       'B' => array('price' => '7', 'price_type' => 'absolute_manual',),
  //       'C' => array('price' => '5', 'price_type' => 'absolute_manual',),
  //       'quantity' => '0',
  //     );
  //   $r = self::$cr->pm($a);
  //   // $r = $this->pm($a);
  //   $e = [];
  //   $this->assertEquals($e, $r);
  // }
}
