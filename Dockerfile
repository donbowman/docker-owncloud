FROM phusion/baseimage:latest
MAINTAINER Don Bowman "don.waterloo@gmail.com"
#RUN adduser --system --uid=33 --gid=33 --shell /usr/sbin/nologin --home /var/www www-data
RUN apt-get -y update
RUN apt-get install -y apache2 php5 php5-gd php-xml-parser php5-intl php5-mysqlnd php5-json php5-mcrypt smbclient curl libcurl3 php5-curl bzip2 wget git
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN curl -k https://download.owncloud.org/community/owncloud-8.1.0.tar.bz2 | tar jx -C /var/www/
RUN mkdir /var/www/owncloud/data
RUN chown -R www-data:www-data /var/www/owncloud

#ADD logo.svg /var/www/owncloud/core/img/logo.svg
ADD sandvine /var/www/owncloud/themes/sandvine
ADD ./001-owncloud.conf /etc/apache2/sites-available/
RUN rm -f /etc/apache2/sites-enabled/000*
RUN ln -s /etc/apache2/sites-available/001-owncloud.conf /etc/apache2/sites-enabled/
RUN a2enmod rewrite

RUN mkdir -p /var/www/owncloud/3rdparty/rackspace
RUN (cd /var/www/owncloud/3rdparty/rackspace; curl -sS https://getcomposer.org/installer | php; php composer.phar require rackspace/php-opencloud:dev-master)

RUN mkdir -p /var/log/owncloud/
RUN chown www-data:www-data /var/log/owncloud
ADD https://raw.githubusercontent.com/donbowman/user_keystone/master/lib/keystone.php /var/www/owncloud/apps/user_external/lib/keystone.php
RUN chmod 444 /var/www/owncloud/apps/user_external/lib/keystone.php
RUN echo OC::\$CLASSPATH[\'OC_User_Keystone\']=\'user_external/lib/keystone.php\'\; >> /var/www/owncloud/apps/user_external/appinfo/app.php

ADD rc.local /etc/rc.local
RUN chown root:root /etc/rc.local

RUN sed -i -e "s?^;include_path.*?include_path='/var/www/owncloud/lib:.:/usr/share/php:/usr/share/pear:/var/www/owncloud/3rdparty'?" /etc/php5/apache2/php.ini

VOLUME ["/var/www/owncloud/data", "/var/www/owncloud/config"]
EXPOSE 80
CMD ["/sbin/my_init"]
