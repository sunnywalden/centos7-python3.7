FROM centos

MAINTAINER sunnywalden@gmail.com

USER root

#ADD Python-3.7.3.tar.xz ./
#
#ADD OpenSSL_1_1_1b.tar.gz ./

RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum clean all && \
    yum makecache && \
    yum -y update && \
    yum install -y wget && \
    wget https://github.com/openssl/openssl/archive/OpenSSL_1_1_1b.tar.gz && \
    tar -zxf OpenSSL_1_1_1b.tar.gz && \
    yum -y install gcc automake autoconf libtool make zlib zlib-devel  libffi-devel && \
    #yum -y install perl-core && \
    cd openssl-OpenSSL_1_1_1b && \
    ./config --prefix=/usr/local/openssl --openssldir=/usr/local/openssl shared zlib && \
    make && make install && \
    if [ -f '/usr/bin/openssl' ];then mv /usr/bin/openssl /usr/bin/openssl.bak;fi && \
    if [-d '/usr/include/openssl' ];then mv /usr/include/openssl/ /usr/include/openssl.bak;fi && \
    ln -s /usr/local/openssl/include/openssl /usr/include/openssl && \
    ln -s /usr/local/openssl/lib/libssl.so.1.1 /usr/local/lib64/libssl.so && \
    ln -s /usr/local/openssl/bin/openssl /usr/bin/openssl && \
    echo 'pathmunge /usr/local/openssl/bin' > /etc/profile.d/openssl.sh && \
    echo '/usr/local/openssl/lib' > /etc/ld.so.conf.d/openssl-1.1.1b.conf && \
    ldconfig -v && \
    cd .. && rm -rf *OpenSSL_1_1_1b* && \
    wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tar.xz && \
    tar -Jxf Python-3.7.3.tar.xz && \
    cd Python-3.7.3 && \
    ./configure --prefix=/usr/local/python3 --with-openssl=/usr/local/openssl && \
    make && make install && \
    rm -rf /usr/bin/python && rm -rf /usr/bin/pip && \
    ln -s /usr/local/python3/bin/python3 /usr/bin/python && \
    ln -s /usr/local/python3/bin/pip3 /usr/bin/pip && \
    sed -i 's/\/usr\/bin\/python/\/usr\/bin\/python2.7/g' /usr/bin/yum-config-manager && \
    sed -i 's/\/usr\/bin\/python/\/usr\/bin\/python2.7/g' /usr/libexec/urlgrabber-ext-down && \
    sed -i 's/\/usr\/bin\/python/\/usr\/bin\/python2.7/g' /usr/bin/yum && \
    cd .. && rm -rf Python-3.7.3* && \
#    pip3 install --upgrade pip && \
    pip install --upgrade pip && \
    python -v
