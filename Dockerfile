FROM debian:10

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid
ENV APACHE_SERVER_NAME localhost

RUN apt -yqq update 
RUN apt-get install -y apache2 php php-pdo-mysql php-mysqli php-pdo

# install extensions

RUN apt-get update -y && apt-get install -y sendmail libpng-dev

# bibioteca imagens GD 
RUN apt-get install -y php-gd

RUN a2enmod proxy_fcgi setenvif
RUN service apache2 restart
RUN a2enmod rewrite


 # Copy files
COPY .docker/config/apache-conf /etc/apache2/apache2.conf
# Expose Apache
EXPOSE 80


#configuração do php.ini
ADD ./.docker/config/php.ini /etc/php/7.3/apache2/
 
# Launch Apache
CMD ["/usr/sbin/apache2ctl", "-DFOREGROUND"]  
