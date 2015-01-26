#!/bin/sh
apt-get -qq -y install apache2 php5 perl mysql-server phpmyadmin
cd /tmp
wget https://kosasih2885.googlecode.com/svn/squidanalyzer-6.1.tar.gz 
tar -xvf squidanalyzer-6.1.tar.gz 
cd squidanalyzer-6.1 
perl Makefile.PL 
make && make install
wget https://kosasih2885.googlecode.com/svn/squidanalyzer.conf -O /etc/squidanalyzer/squidanalyzer.conf
sed -i 's/\r//' /etc/squidanalyzer/squidanalyzer.conf
wget https://kosasih2885.googlecode.com/svn/httpd.conf -O /etc/apache2/httpd.conf
sed -i 's/\r//' /etc/apache2/httpd.conf
service apache2 restart
wget https://kosasih2885.googlecode.com/svn/root -O /var/spool/cron/crontabs/root
