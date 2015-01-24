#!/bin/sh
apt-get -qq -y install devscripts build-essential openssl libssl-dev fakeroot libcppunit-dev libsasl2-dev cdbs ebtables bridge-utils \
libcap2 libcap-dev libcap2-dev sysv-rc-conf iproute kernel-package libncurses5-dev fakeroot wget bzip2 debhelper linuxdoc-tools \
libselinux1-dev htop iftop dnstop
cd /tmp
wget https://kosasih2885.googlecode.com/svn/ssl.patch
wget https://kosasih2885.googlecode.com/svn/anti-forgery.patch
wget https://kosasih2885.googlecode.com/svn/squid-3.4.7.tar.gz
tar xzvf squid-3.4.7.tar.gz
apt-get -qq -y install unbound 
killall unbound
dig +bufsize=1200 +norec NS . @a.root-servers.net > /etc/unbound/named.cache
wget https://kosasih2885.googlecode.com/svn/unbound.conf -O /etc/unbound/unbound.conf
unbound-control-setup
unbound-control start
cd squid-3.4.7
patch -p0 < ../anti-forgery.patch
patch -p0 < ../ssl.patch
./configure --prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin --libexecdir=/usr/lib/squid3 --sysconfdir=/etc/squid3 \
--localstatedir=/var --libdir=/usr/lib --includedir=/usr/include --datadir=/usr/share/squid3 --infodir=/usr/share/info \
--mandir=/usr/share/man --disable-dependency-tracking --disable-strict-error-checking --enable-async-io=32 --with-aufs-threads=32 \
--with-pthreads --enable-storeio=ufs,aufs,diskd --enable-removal-policies=lru,heap --with-aio --with-dl --enable-icmp --enable-esi \
--enable-icap-client --disable-wccp --disable-wccpv2 --enable-kill-parent-hack --enable-cache-digests --disable-select \
--enable-http-violations --enable-linux-netfilter --enable-follow-x-forwarded-for --disable-ident-lookups --enable-x-accelerator-vary \
--enable-zph-qos --with-default-user=proxy --with-logdir=/var/log/squid3 --with-pidfile=/var/run/squid3.pid --with-swapdir=/var/spool/squid3 \
--with-large-files --enable-ltdl-convenience --with-filedescriptors=65536 --enable-ssl --enable-ssl-crtd --disable-auth --disable-ipv6  --with-dl
make && make install && make install-piger
cd /tmp
openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj \
"/C=ID/ST=Jakarta/L=Jakarta/O=Kosasih850/OU=Proxy Server/CN=Proxy Server For Free/emailAddress=kosasih850@gmail.com" \
-keyout myCA.pem  -out myCA.pem
openssl x509 -in myCA.pem -outform DER -out myCA.der
cp myCA.* /etc/squid3/
wget https://kosasih2885.googlecode.com/svn/squid.conf -O /etc/squid3/squid.conf
sed -i 's/\r//' /etc/squid3/squid.conf
wget https://kosasih2885.googlecode.com/svn/store-id.pl -O /etc/squid3/store-id.pl
sed -i 's/\r//' /etc/squid3/store-id.pl
wget https://kosasih2885.googlecode.com/svn/squid.init -O /etc/init.d/squid
sed -i 's/\r//' /etc/init.d/squid
wget https://kosasih2885.googlecode.com/svn/sysctl.conf -O /etc/sysctl.conf
sed -i 's/\r//' /etc/sysctl.conf
wget https://kosasih2885.googlecode.com/svn/rc.local -O /etc/rc.local
sed -i 's/\r//' /etc/rc.local
wget https://kosasih2885.googlecode.com/svn/limits.conf -O /etc/security/limits.conf
sed -i 's/\r//' /etc/security/limits.conf
wget https://kosasih2885.googlecode.com/svn/resolv.conf -O /etc/resolv.conf
sed -i 's/\r//' /etc/resolv.conf
wget https://kosasih2885.googlecode.com/svn/interfaces /etc/network/interfaces
sed -i 's/\r//' /etc/network/interfaces
wget 'http://pgl.yoyo.org/adservers/serverlist.php?hostformat=nohtml' -O /etc/squid3/ad_block.txt 
sed -i 's/\r//' /etc/squid3/ad_block.txt
/usr/lib/squid3/ssl_crtd -c -s /etc/squid3/ssl_db
chmod +x /etc/init.d/squid
mkdir -p /var/spool/squid3/cache
chmod -R 777 /etc/squid3
chown -R proxy:proxy /etc/squid3
chmod -R 777 /var/log/squid3
chown -R proxy:proxy /var/log/squid3
chmod -R 777 /var/spool/squid3
chown -R proxy:proxy /var/spool/squid3
squid -z
echo -e "Instalasi Unbound dan Squid telah selesai. Agar dapat berjalan, \nsebaiknya restart server anda."
while true; do
    read -p "Apakah anda ingin merestart komputer anda?" yn
    case $yn in
        [Yy]* ) init 6; break;;
        [Nn]* ) exit;;
        * ) echo "Tolong jawab yes atau no";;
    esac
done
