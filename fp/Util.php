<?php

class Util
{

  public function __construct()
  {
  }
  // Tested
  protected function arrayToName(array $a): string
  {
    $s = $a[0];
    foreach (array_slice($a, 1) as $v) {
      $s .= "[$v]";
    }
    return $s;
  }

  protected function nameToArray(string $s): array
  {
    preg_match_all('/\b\w+\b/', $s, $w);
    // preg_match_all("/[a-zA-Z]+/", $s, $first); // snake_case splitted
    // preg_match_all("/\[(.*?)\]/", $s, $matches); // matches only inside brackets
    return $w[0];
  }

  protected function valueByName(string $n, array $a)
  {
    $r = null;
    foreach ($this->nameToArray($n) as $v) {
      $r == null ? $r = $a[$v] : $r = $r[$v];
    }
    return $r;
  }
}
