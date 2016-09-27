#!/bin/bash

sudo apt-get update
sudo apt-get install unzip build-essential curl libpcre3 libpcre3-dev zlib1g-dev libssl-dev build-essential git libxslt-dev libgd2-xpm-dev libgeoip-dev libpam-dev libperl-dev libxml2 libxml2-dev libxml2-utils libaprutil1 libaprutil1-dev libtool automake -y
wget https://nginx.org/download/nginx-1.11.4.tar.gz && tar zxvf nginx-1.11.4.tar.gz
#PageSpeed
wget https://github.com/pagespeed/ngx_pagespeed/archive/release-1.11.33.4-beta.zip -O pagespeed.zip
unzip pagespeed.zip
cd ngx_pagespeed-*
wget https://dl.google.com/dl/page-speed/psol/1.11.33.4.tar.gz
tar -xzvf 1.11.33.4.tar.gz
cd ..
#openSSL 1.0.2 stable
git clone https://github.com/travislee8964/sslconfig
wget -O openssl.zip -c https://github.com/openssl/openssl/archive/OpenSSL_1_0_2i.zip
unzip openssl.zip
mv openssl-OpenSSL_1_0_2i/ openssl
cd openssl && patch -p1 < ../sslconfig/patches/openssl__chacha20_poly1305_draft_and_rfc_ossl102i.patch
cd ../
wget -O nginx-ct.zip -c https://github.com/grahamedgecombe/nginx-ct/archive/v1.3.0.zip
unzip nginx-ct.zip
cd nginx-1.11.4
./configure --with-cc-opt='-g -O2 -fPIE -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2' --add-module=../nginx-ct-1.3.0 --with-openssl=../openssl --add-module=../ngx_pagespeed-release-1.11.33.4-beta --prefix=/usr/share/nginx --conf-path=/etc/nginx/nginx.conf --pid-path=/run/nginx.pid --lock-path=/var/lock/nginx.lock --http-log-path=/var/log/nginx/access.log --error-log-path=stderr --http-client-body-temp-path=/var/lib/nginx/body --http-proxy-temp-path=/var/lib/nginx/proxy --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-ipv6 --with-pcre-jit --with-file-aio --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_degradation_module --with-http_flv_module --with-http_geoip_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_realip_module --with-http_secure_link_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-stream --with-stream_ssl_module --with-threads 
make
