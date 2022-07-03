# KUIS E-voting System

## Project Description

This is my Diploma FYP, I put it here so that I can keep maintain it and fix bug that i found.

This System design is entirely based on voting flow in my collage which is Kolej Universiti Islam Antarabangsa Selangor (KUIS)


## Installation

1. Clone this repo
```
git clone  https://github.com/luqman1412/voting-system.git
```
2. move inside the project folder
```
cd voting-system
```

3. Import SQL file into your DB `evotingdump.sql`

4. Copy system_credential_example.php and rename it to system_credential.php
```
cp system_credential_example.php system_credential.php
```

5. change the credential in system_credential.php to match your system
```php
# This for sending email porpose
define('SYSTEM_EMAIL','YOUR_EMAIL');
define('SYSTEM_EMAIL_PASSWORD','YOUR_EMAIL_PASSWORD');

# keep it as it is, if your are using your local machine
define('MYSQL_HOST','localhost');
define('MYSQL_USER','root');
define('MYSQL_PASSWORD','root');
define('MYSQL_DB','voting');
```

6. run in your local machine :)


## Demo Site
Both are the same, i just using different deploy method

* ~~[New Demo Site](https://kuisevotingsystem.herokuapp.com/index.php)~~


* [Old Demo Site](http://e-votingsystem.epizy.com/)
