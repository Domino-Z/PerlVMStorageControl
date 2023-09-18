FROM perl:latest

RUN apt-get update && apt-get install -y apache2

COPY . /var/www/html/

# 配置 Apache 以支持 CGI 脚本执行
RUN a2enmod cgi

# 启动 Apache 服务器
CMD ["apache2ctl", "-D", "FOREGROUND"]