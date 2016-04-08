#!/bin/bash

sudo apt-get update
sudo apt-get install curl libpcre3 libpcre3-dev zlib1g-dev libssl-dev build-essential git libxslt-dev libgd2-xpm-dev libgeoip-dev libpam-dev libperl-dev libxml2 libxml2-dev libxml2-utils libaprutil1 libaprutil1-dev apache2-prefork-dev libtool automake -y
wget http://nginx.org/download/nginx-1.9.14.tar.gz && tar zxvf nginx-1.9.14.tar.gz
#PageSpeed
wget https://github.com/pagespeed/ngx_pagespeed/archive/release-1.11.33.0-beta.zip -O pagespeed.zip
unzip pagespeed.zip
cd ngx_pagespeed-*
wget https://dl.google.com/dl/page-speed/psol/1.11.33.0.tar.gz
tar -xzvf 1.11.33.0.tar.gz
cd ..
#ModSecurity
#wget https://www.modsecurity.org/tarball/2.9.1-rc1/modsecurity-2.9.1-RC1.tar.gz
#tar zxvf modsecurity-2.9.1-RC1.tar.gz 
#cd modsecurity-2.9.1-RC1
#./autogen.sh
#./configure --enable-standalone-module
#make -j4
#cd ..
#openSSL 1.0.2 stable
git clone https://github.com/cloudflare/sslconfig
wget -O openssl.zip -c https://github.com/openssl/openssl/archive/OpenSSL_1_0_2g.zip
unzip openssl.zip
mv openssl-OpenSSL_1_0_2g/ openssl
cd openssl && patch -p1 < ../sslconfig/patches/openssl__chacha20_poly1305_draft_and_rfc_ossl102g.patch
cd ../
wget -O nginx-ct.zip -c https://github.com/grahamedgecombe/nginx-ct/archive/v1.0.0.zip
unzip nginx-ct.zip
cd nginx-1.9.14
./configure --add-module=../nginx-ct-1.0.0 --with-openssl=../openssl --user=www-data --group=www-data --with-http_ssl_module --with-http_v2_module --with-ipv6 --add-module=../ngx_pagespeed-release-1.11.33.0-beta --with-stream 
make
