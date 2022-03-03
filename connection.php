<?php
error_reporting(E_ALL & ~E_NOTICE);

require 'system_credential.php';

$db=mysqli_connect(MYSQL_HOST,MYSQL_USER,MYSQL_PASSWORD,MYSQL_DB);

if (!$db) {
	die("Connection Failed: ".mysqli_connect_error());
}
?>