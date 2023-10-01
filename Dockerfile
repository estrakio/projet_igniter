FROM php:apache



RUN apt update
RUN apt upgrade
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer
RUN apt install -y zip
RUN apt install -y unzip
RUN apt install -y zlib1g-dev libicu-dev g++
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl

# RUN composer create-project codeigniter4/appstarter test

RUN mkdir projet
COPY . /var/www/html/projet
COPY ./apache_config/000-default.conf /etc/apache2/sites-available 
# RUN chown -R www-data:www-data /var/www/html/projet/writable/
RUN a2enmod rewrite 