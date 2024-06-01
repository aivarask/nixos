<?php

require_once __DIR__ . '/vendor/autoload.php';

$cr = new Crawl();
$dl = new Dilaina();

switch ($_SERVER['PATH_INFO'] ?? null) {
  case null:
    $cr->home();
    break;

  case '/search':
    $cr->search($_GET['sname'])->searchRender();
    break;

  case '/edit':
    $cr->edit($_REQUEST['id'])->editRender();
    break;

  case '/editPool':
    $cr->editPool($_REQUEST['ids']);
    break;

  case '/save':
    $cr->save($_POST)->editRender();
    break;

  case '/change_per_page':

    header('HX-Refresh: true');
    $cr->change_per_page($_POST['per_page']);
    break;

  case '/dilaina':
    $dl->paieska($_REQUEST['fraze'] ?? null)->render();
    break;

  default:
    echo 'default switch case';
    break;
}
