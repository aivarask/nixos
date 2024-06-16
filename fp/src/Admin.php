<?php
require_once __DIR__ . "/../vendor/autoload.php";

use GuzzleHttp\Client;
use GuzzleHttp\Cookie\FileCookieJar;
use GuzzleHttp\Exception\RequestException;
use GuzzleHttp\Pool;
use GuzzleHttp\Psr7\Request;
use GuzzleHttp\Psr7\Response;
use Psr\Http\Message\ResponseInterface;

class Admin
{
  const URI_LOGIN = 'admin/admin';
  const URI_SEARCH = 'admin/goods/search';
  const URI_EDIT = 'admin/goods/edit/';
  const URI_SAVE = 'admin/goods/save/';
  const URI_PAGE = 'admin/admin/change_per_page/';

  private $jar;
  private $lang;
  private $client;
  private $twig;
  private static $search_items;
  private static $edit_items;
  private static $save_items;
  private $total;
  private $perPage;

  public function __construct()
  {
    $this->jar = new FileCookieJar(__DIR__ . "/jar.json");
    $this->lang = 'lt';
    $this->perPage = ($this->jar->getCookieByName('admin_per_page')->getValue() ?? '50');
    $this->client  = new Client(['base_uri' => "https://www.fixasparts.com/$this->lang/", 'cookies' => $this->jar, 'timeout' => 5.0]);
    $this->loginIfExpired();
    $this->twig = load();
  }

  private function login()
  {
    $this->client->post(self::URI_LOGIN, [
      'headers' => [
        'Content-Type' => 'application/x-www-form-urlencoded'
      ],
      'form_params' => [
        'email' => 'aurimas.butkuss@gmail.com',
        'pass' => 'Fihas222',
      ]
    ]);
  }
  private function loginIfExpired()
  {
    $as = $this->jar->getCookieByName('admin_session');
    $user_id = $this->jar->getCookieByName('user_id');
    if ($as->getExpires() < time()) {
      $this->login();
    } else if (isset($user_id) && ($user_id->getValue() == 'deleted')) {
      $user_id->setDiscard(true);
      $this->login();
    }
  }

  function home()
  {
    $this->loginIfExpired();
    echo $this->twig->render('index.twig');
  }

  function search($sname)
  {
    $this->loginIfExpired();
    $res = $this->client->get(self::URI_SEARCH . "?sname=$sname");
    self::$search_items = $this->searchExtract($res);
    return $this;
  }

  function change_per_page($n)
  {
    $res = $this->client->post(self::URI_PAGE . $n);
    self::$search_items = $this->searchExtract($res);
    return $this;
  }

  function searchRender()
  {
    echo $this->twig->render('search.twig', ['sname' => $_REQUEST['sname'] ?? null, 'items' => self::$search_items, 'total' => $this->total, 'perPage' => $this->perPage]);
  }

  private function searchExtract(ResponseInterface $res)
  {
    $body = $res->getBody();
    libxml_use_internal_errors(true);
    $doc = new DOMDocument();
    $doc->loadHTML($body);
    $xpath = new DOMXPath($doc);

    $items = $xpath->query("//div[contains(@class, 'product_container')]");
    $this->total = str_replace(['Viso rasta prekių: '], '', $xpath->query('//div[@id="product_category_filter_container"]//span[@class="mr15"]')->item(0)->textContent ?? '');

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
    $res = $this->client->get(self::URI_EDIT . $id);
    self::$edit_items = $this->editExtract($res);
    return $this;
  }

  function editAll(string $ids)
  {
    foreach (explode(',', $ids) as $id) {
      $this->edit($id)->editRender();
    }
  }

  // https://docs.guzzlephp.org/en/stable/quickstart.html#concurrent-requests
  function editPool(string $ids)
  {
    $requests = [];
    foreach (explode(',', $ids) as $id) {
      $requests[] = new Request('GET', self::URI_EDIT . $id);
    }

    $pool = new Pool($this->client, $requests, [
      'concurrency' => 15,
      'fulfilled' => function (Response $response) {
        $data =  $this->editExtract($response);
        echo $this->twig->render('edit.twig', ['multipart' => $data]);
      },
      'rejected' => function (RequestException $reason) {
        echo $reason;
      },
    ]);

    $promise = $pool->promise();
    $promise->wait();
  }

  function editRender()
  {
    echo $this->twig->render('edit.twig', ['multipart' => self::$edit_items]);
  }

  function editExtract(ResponseInterface $res)
  {
    $body = $res->getBody();
    libxml_use_internal_errors(true);
    $doc = new DOMDocument();
    $doc->loadHTML($body);
    $xpath = new DOMXPath($doc);
    $multipart = [
      ['name' => 'id', 'contents' => $xpath->query('//input[@id="good_id"]/@value')->item(0)->textContent, 'attributes' => ['hidden' => 'hidden']],
      ['name' => 'code', 'contents' => $xpath->query('//input[@name="code"]/@value')->item(0)->textContent, 'attributes' => ['hidden' => 'hidden']],
      ['name' => 'Translation[EN][name]', 'contents' => $xpath->query('//input[@name="Translation[EN][name]"]/@value')->item(0)->textContent],
      ['name' => 'Translation[LT][name]', 'contents' => $xpath->query('//input[@name="Translation[LT][name]"]/@value')->item(0)->textContent],
      ['name' => 'Translation[EN][description]', 'contents' => $xpath->query('//textarea[@id="description_EN"]/text()')->item(0)->textContent ?? null, 'el' => 'textarea', 'attributes' => ['lang' => 'en']],
      ['name' => 'Translation[LT][description]', 'contents' => $xpath->query('//textarea[@id="description_LT"]/text()')->item(0)->textContent ?? null, 'el' => 'textarea', 'attributes' => ['lang' => 'lt']],
      ['name' => 'base_price', 'contents' => $xpath->query('//input[@name="base_price"]/@value')->item(0)->textContent, 'attributes' => ['type' => 'number', 'step' => '.1']],
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

  function save(array $_post)
  {
    $this->loginIfExpired();
    [$id, self::$save_items] = $this->saveExtract($_post);
    $res = $this->client->post(self::URI_SAVE . $id, ['multipart' => self::$save_items]);
    self::$edit_items = $this->editExtract($res);
    return $this;
  }

  private function saveExtract(array $a, array &$m = [], &$r = '')
  {
    $id = '';
    foreach ($a as $k => $v) {
      if (!is_array($v)) {
        $n = strlen($r) == 0 ? $r . $k : $r . "[$k]";
        ($n == 'id') && $id = $v;
        $m[] = ['name' => $n, 'contents' => $v];
      } else {
        $r = strlen($r) == 0 ? $r . $k : $r . "[$k]";
        $this->saveExtract($v, $m, $r);
        preg_match_all('/\b\w+\b/', $r, $w);
        $l = end($w[0]);
        $r  = substr($r, 0, strlen($r) - (strlen($l) + (str_contains($r, '[') ? 2 : 0)));
      }
    }
    return [$id, $m];
  }
}
