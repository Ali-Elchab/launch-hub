Update Amazon Linux:
`sudo dnf update`

Install LAMP Stack:
`sudo dnf install httpd mariadb*-server php php-mysqlnd`

Start and enable the Apache and MariaDB services:

```
sudo systemctl enable --now httpd
sudo systemctl enable --now mariadb
```

Create Database:

```
sudo mysql
CREATE DATABASE launchhub;
CREATE USER username'@'localhost' IDENTIFIED BY 'password'
GRANT ALL ON yourdb.* to 'user'@'localhost';
FLUSH PRIVILEGES;
quit;
```

Install PHP Composer for Laravel:

```
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
sudo chmod +x /usr/local/bin/composer
```

Clone the Laravel project:

```
cd /var/www
sudo dnf install git -y
sudo git clone https://github.com/launchhub/server/alielchab.git
cd /var/www/launchhub/server
sudo chown -R $USER /var/www/launchhub/server
composer install
sudo chown -R apache.apache /var/www/launchhub/server
sudo chmod -R 755 /var/www/launchhub/server
sudo chmod -R 777 /var/www/launchhub/server/storage
```

Create the Laravel environment configuration file:

```
sudo cp .env.example .env
sudo php artisan key:generate
sudo nano .env
"Edit env file"
```

Apache Configuration for PHP Laravel:

```
sudo nano /etc/httpd/conf.d/laravel.conf
inside the file:
<VirtualHost *:80>
       ServerName launchhub.example.com
       DocumentRoot /var/www/launchhub/server/public

       <Directory /var/www/launchhub/server>
              AllowOverride All
       </Directory>
</VirtualHost>
```
