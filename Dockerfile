FROM perl:latest

RUN apt-get update && apt-get install -y apache2

COPY . /var/www/html/

RUN a2enmod cgi

CMD ["apache2ctl", "-D", "FOREGROUND"]