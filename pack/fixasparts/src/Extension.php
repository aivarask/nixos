<?php

use Twig\Extension\AbstractExtension;
use Twig\TwigFilter;

class Extension extends AbstractExtension
{
  public function getFilters(): array
  {
    return [
      new TwigFilter('ids', [$this, 'getIds']),
      new TwigFilter('swap', [$this, 'swap']),
      new TwigFilter('numbers', [$this, 'numbers']),
      new TwigFilter('notnumbers', function (array $a) {
        return array_filter($a, function ($item) {
          return ($item['attributes']['type'] ?? null) !== 'number';
        });
      }),
      new TwigFilter('vat', function (string $s) {
        return (float)$s * 1.21;
      })
    ];
  }

  public function getIds(array $items = null)
  {
    !isset($items) && exit;
    $ids = array_column($items, 'id');
    return implode(",", $ids);
  }

  public function swap(array $items = null)
  {
    !isset($items) && exit;
    $ids = array_column($items, 'id');
    $res = implode(',', array_map(function ($v) {
      return "#n$v,#t$v";
    }, $ids));
    return $res;
  }

  public function numbers(array $a)
  {
    return array_filter($a, function ($item) {
      return ($item['attributes']['type'] ?? null) == 'number';
    });
  }
}
