<?php

$db = new PDO('pgsql:host=localhost;dbname=dns', 'pdns', '12345');
if (!$db) die("no db");

$s = $db -> prepare('SELECT * FROM domains');
$a = $s -> execute();
var_dump($db -> errorInfo());
var_dump($a);
$r = $s -> fetchAll();
var_dump($r);

?>
