<?php

require_once __DIR__ . "./../vendor/autoload.php";

use GuzzleHttp\Client;
use GuzzleHttp\Cookie\FileCookieJar;
use GuzzleHttp\Psr7\Request;

class Crawl
{
  private $jar;
  private $client;

  public function __construct()
  {
    $this->jar = new FileCookieJar(__DIR__ . "/jar.json");
    $this->client  = new Client(['base_uri' => 'https://www.fixasparts.com', 'cookies' => $this->jar]);
    $this->loginIfExpired();
  }

  function cookieExpired()
  {
    return ($this->jar->getCookieByName('admin_session')->getExpires() < time());
  }

  function login()
  {
    $authRequest = new Request('POST', "/en/admin/admin", ['Content-Type' => 'application/x-www-form-urlencoded']);
    $this->client->send($authRequest, [
      'form_params' => [
        'email' => 'aurimas.butkuss@gmail.com',
        'pass' => 'Fihas222',
      ]
    ]);
    echo 'Crawl::login() invoked';
  }

  function loginIfExpired()
  {
    $this->cookieExpired() && $this->login();
  }

  function search($sname)
  {
    $this->loginIfExpired();
    libxml_use_internal_errors(true);
    $doc = new DOMDocument();
    // $doc->loadHTMLFile(__DIR__ . '/snap/search.html');
    $res = $this->client->get("/en/admin/goods/search?sname=$sname");
    $body = $res->getBody();
    $doc->loadHTML($body);
    $xpath = new DOMXPath($doc);

    $s = "//div[contains(@class, 'product_container')]";
    $items = $xpath->query($s);

    $result = [];
    foreach ($items as $node) {
      $id = $xpath->query('.//input[@name="good_id[]"]/@value', $node)->item(0)->textContent ?? null;
      $code = $xpath->query('.//span[@class="fwb"]/text()', $node)->item(0)->textContent ?? null;
      $quantity = $xpath->query('.//span[@data-document-id="product"]/text()', $node)->item(0)->textContent ?? null;
      $price = $xpath->query('.//strong/text()', $node)->item(0)->textContent ?? null;
      $name = $xpath->query('.//h2/a/@title', $node)->item(0)->textContent ?? null;
      $url = $xpath->query('.//h2/a/following-sibling::a/@href', $node)->item(0)->textContent ?? null;
      $url_edit = $xpath->query('.//h2/a/@href', $node)->item(0)->textContent ?? null;
      $product = compact('id', 'code', 'quantity', 'price', 'name', 'url', 'url_edit');
      array_push($result, $product);
    }
    return $result;
  }

  function edit(string|null $id)
  {
    !isset($id) && exit;
    $this->loginIfExpired();
    libxml_use_internal_errors(true);
    $doc = new DOMDocument();
    $res = $this->client->get("/en/admin/goods/edit/$id");
    $body = $res->getBody();
    $doc->loadHTML($body);
    // $doc->loadHTMLFile(__DIR__ . '/snap/50353.html');
    $xpath = new DOMXPath($doc);
    $multipart = [
      ['name' => 'id', 'contents' => $xpath->query('//input[@id="good_id"]/@value')->item(0)->textContent, 'attributes' => ['hidden' => 'hidden']],
      ['name' => 'code', 'contents' => $xpath->query('//input[@name="code"]/@value')->item(0)->textContent, 'attributes' => ['hidden' => 'hidden']],
      ['name' => 'Translation[EN][name]', 'contents' => $xpath->query('//input[@name="Translation[EN][name]"]/@value')->item(0)->textContent],
      ['name' => 'Translation[LT][name]', 'contents' => $xpath->query('//input[@name="Translation[LT][name]"]/@value')->item(0)->textContent],
      ['name' => 'Translation[EN][description]', 'contents' => $xpath->query('//textarea[@id="description_EN"]/text()')->item(0)->textContent ?? null, 'el' => 'textarea'],
      ['name' => 'Translation[LT][description]', 'contents' => $xpath->query('//textarea[@id="description_LT"]/text()')->item(0)->textContent ?? null, 'el' => 'textarea'],
      ['name' => 'base_price', 'contents' => $xpath->query('//input[@name="base_price"]/@value')->item(0)->textContent, 'attributes' => ['type' => 'number']],
      ['name' => 'tax_id', 'contents' => $xpath->query('//input[@name="tax_id"]/@value')->item(0)->textContent, 'attributes' => ['hidden' => 'hidden']],
      ['name' => 'A[price]', 'contents' => $xpath->query('//input[@name="A[price]"]/@value')->item(0)->textContent, 'attributes' => ['type' => 'number']],
      ['name' => 'A[price_type]', 'contents' => $xpath->query('//select[@id="price_type_A"]/option[@selected="selected"]/@value')->item(0)->textContent, 'attributes' => ['hidden' => 'hidden']],
      ['name' => 'B[price]', 'contents' => $xpath->query('//input[@name="B[price]"]/@value')->item(0)->textContent, 'attributes' => ['type' => 'number']],
      ['name' => 'B[price_type]', 'contents' => $xpath->query('//select[@id="price_type_B"]/option[@selected="selected"]/@value')->item(0)->textContent, 'attributes' => ['hidden' => 'hidden']],
      ['name' => 'C[price]', 'contents' => $xpath->query('//input[@name="C[price]"]/@value')->item(0)->textContent, 'attributes' => ['type' => 'number']],
      ['name' => 'C[price_type]', 'contents' => $xpath->query('//select[@id="price_type_C"]/option[@selected="selected"]/@value')->item(0)->textContent, 'attributes' => ['hidden' => 'hidden']],
      ['name' => 'quantity', 'contents' => $xpath->query('//input[@id="good_quantity"]/@value')->item(0)->textContent, 'attributes' => ['type' => 'number']],
      ['name' => 'Translation[EN][visible]', 'contents' => $xpath->query('//input[@id="good_visibility_EN"]/@checked')->item(0) ? 1 : 0, 'attributes' => ['type' => 'checkbox']],
      ['name' => 'Translation[LT][visible]', 'contents' => $xpath->query('//input[@id="good_visibility_LT"]/@checked')->item(0) ? 1 : 0, 'attributes' => ['type' => 'checkbox']],
    ];
    return $multipart;
  }

  function save($p)
  {
    $this->loginIfExpired();
    $id = $p['id'];
    $multipart = $this->pm($p);

    $res = $this->client->post("/en/admin/goods/save/$id", ['multipart' => $multipart]);
    return $res;
  }

  /**
   * $_POST to Guzzle multipart
   * Traverses PHP $_POST array to Guzzle multipart one-dimmensional array
   */
  function pm(array $a, array &$m = [], &$r = '')
  {
    foreach ($a as $k => $v) {
      if (!is_array($v)) {
        $n = strlen($r) == 0 ? $r . $k : $r . "[$k]";
        $m[] = ['name' => $n, 'contents' => $v];
      } else {
        $r = strlen($r) == 0 ? $r . $k : $r . "[$k]";
        $this->pm($v, $m, $r);
        preg_match_all('/\b\w+\b/', $r, $w);
        $l = end($w[0]);
        $r  = substr($r, 0, strlen($r) - (strlen($l) + (str_contains($r, '[') ? 2 : 0)));
      }
    }
    return $m;
  }

  function all($ids)
  {
    $ids_array = explode(',', $ids);
    return $ids_array;
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
