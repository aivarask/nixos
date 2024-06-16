<?php

ini_set('display_errors', '1');
require_once __DIR__ . "/../vendor/autoload.php";

$cr = new Admin();

// $cr->save($_POST)->editRender();
// dump_request();
if ($_REQUEST['per_page'] ?? null) {
  header('HX-Refresh: true');
  $cr->change_per_page($_REQUEST['per_page']);
} elseif ($_REQUEST['edit_id'] ?? null) {
  $cr->edit($_REQUEST['edit_id'])->editRender();
} elseif ($_POST['edit_ids'] ?? null) {
  $cr->editPool($_POST['edit_ids']);
} else {
  $cr->search($_GET['sname'] ?? null)->searchRender();
}
