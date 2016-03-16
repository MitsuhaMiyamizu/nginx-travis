#!/bin/bash
zypper install -t pattern devel_basis
wget http://nginx.org/download/nginx-1.9.12.tar.gz && tar zxvf nginx-1.9.12.tar.gz
#PageSpeed
wget https://github.com/pagespeed/ngx_pagespeed/archive/release-1.10.33.6-beta.zip -O pagespeed.zip
unzip pagespeed.zip
cd ngx_pagespeed-*
wget https://dl.google.com/dl/page-speed/psol/1.10.33.6.tar.gz
tar -xzvf 1.10.33.6.tar.gz
cd ..
#ModSecurity
#wget https://www.modsecurity.org/tarball/2.9.1/modsecurity-2.9.1.tar.gz
#tar zxvf modsecurity-2.9.1.tar.gz 
#cd modsecurity-2.9.1
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
cd nginx-1.9.12
./configure --add-module=../nginx-ct-1.0.0 --with-openssl=../openssl --user=www-data --group=www-data --with-http_ssl_module --with-http_v2_module --with-ipv6 --add-module=../ngx_pagespeed-release-1.10.33.6-beta --with-stream 
make
