<?php

require_once __DIR__ . './../vendor/autoload.php';

$cr = new Crawl();
$twig = load();

switch ($_SERVER['PATH_INFO'] ?? null) {
  case null:
    $t = $twig->load('index.twig');
    echo $t->render();
    break;

  case '/search':
    $sname = $_GET['sname'] ?? null;
    $items = $cr->search($sname);
    $t = $twig->load('search.twig');
    echo $t->render(['items' => $items]);
    break;

  case '/edit':
    $t = $twig->load('edit.twig');
    if ($_REQUEST['id'] ?? null) {
      $multipart = $cr->edit($_REQUEST['id']);
      echo $t->render(['multipart' => $multipart]);
    }
    break;

  case '/save':
    $cr->save($_POST);
    break;

  case '/all':
    $ids = $cr->all($_REQUEST['ids'] ?? []);
    // $items = array_slice($items, 2, 3);
    $t = $twig->load('edit.twig');
    foreach ($ids as $id) {
      $fields = $cr->edit($id);
      echo $t->render(['id' => $id, 'items' => $fields]);
    }
    break;


  default:
    echo 'default switch case';
    break;
}
