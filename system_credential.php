<?php


define('SYSTEM_EMAIL',getenv('HEROKU_EMAIL'));
define('SYSTEM_EMAIL_PASSWORD',getenv('HEROKU_EMAIL_PASSWORD'));

define('MYSQL_HOST',getenv('HEROKU_MYSQL_HOST'));
define('MYSQL_USER',getenv('HEROKU_MYSQL_USER'));
define('MYSQL_PASSWORD',getenv('HEROKU_MYSQL_PASSWORD'));
define('MYSQL_DB',getenv('HEROKU_MYSQL_DB'));


?>
