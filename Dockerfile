FROM perl:latest

RUN apt-get update && apt-get install -y apache2

RUN cpan install CGI DBI DBD::Pg Template

RUN a2enmod cgi

WORKDIR /var/www/html

COPY cgi-bin/ /var/www/html/cgi-bin/
COPY lib/ /var/www/html/lib/
COPY .htaccess /var/www/html/
COPY apache-config.conf /etc/apache2/sites-available/000-default.conf

RUN chmod +x /var/www/html/cgi-bin/main.pl

EXPOSE 80

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]