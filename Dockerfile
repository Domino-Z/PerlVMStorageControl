FROM perl:latest

RUN apt-get update && apt-get install -y apache2

RUN cpan install CGI DBI DBD::Pg Template

RUN a2enmod cgi

WORKDIR /var/www/html

COPY . /var/www/html

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
COPY apache-config.conf /etc/apache2/sites-available/000-default.conf

EXPOSE 80

CMD ["apache2ctl", "-D", "FOREGROUND"]