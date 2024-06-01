<?php

use GuzzleHttp\Client;
use GuzzleHttp\Cookie\FileCookieJar;
use Psr\Http\Message\ResponseInterface;

class Dilaina
{
  private $jar;
  private $client;
  private $twig;
  private static $search_items;
  public function __construct()
  {
    $this->jar = new FileCookieJar(__DIR__ . "/jarDilaina.json", true);
    $this->client  = new Client(['base_uri' => 'https://www.dilaina.lt', 'cookies' => $this->jar]);
    $this->twig = load();
  }

  function login()
  {
    $res = $this->client->post("/login.php", [
      'headers' => ['Content-Type' => 'application/x-www-form-urlencoded'],
      'form_params' => ['email' => 'info@fixas.lt', 'password' => 'Fihas222',],
    ]);
    return $res;
  }

  function paieska($fraze)
  {
    $res = $this->client->post("/paieska.php", [
      'headers' => ['Content-Type' => 'application/x-www-form-urlencoded'],
      'form_params' => ['fraze' => "$fraze"]
    ]);
    self::$search_items = $this->extract($res, $fraze);
    return $this;
  }

  function extract(ResponseInterface $res, string $fraze)
  {
    $body = $res->getBody();
    libxml_use_internal_errors(true);
    $doc = new DOMDocument();
    $doc->loadHTML($body);
    $xpath = new DOMXPath($doc);
    $loginForm = $xpath->query("//form[@action='login.php']");
    if ($loginForm->count()) {
      $this->login();
      $this->paieska($fraze);
      exit;
    } else {
      $items = $xpath->query("//div[contains(@class, 'product_in_list')]");
      $result = [];
      for ($i = 0; $i < sizeof($items); $i++) {
        $node = $items[$i];
        $name = $xpath->query('.//a[1]/@title', $node)->item(0)->textContent ?? null;
        $href = $xpath->query('.//a[1]/@href', $node)->item(0)->textContent ?? null;
        $price = $xpath->query(".//div[contains(@class, 'price')]//span", $node)->item(0)->textContent ?? null;
        $product = compact(
          'name',
          'href',
          'price'
        );
        array_push($result, $product);
      }
      return $result;
    }
  }



  function render()
  {
    echo $this->twig->render('dilaina.twig', ['fraze' => $_REQUEST['fraze'], 'ditems' => self::$search_items]);
  }


  function change_speech(string $lang = 'en')
  {
    $this->client->get("/change_speech.php?speech=$lang");
  }
}
