FROM centos

MAINTAINER sunnywalden@gmail.com

USER root

#ADD Python-3.7.3.tar.xz ./
#
#ADD openssl-1.0.2r.tar.gz ./

RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum clean all && \
    yum makecache && \
    yum -y update && \
    yum install -y wget && \
    wget https://www.openssl.org/source/openssl-1.0.2r.tar.gz && \
    tar -zxf openssl-1.0.2r.tar.gz && \
    yum -y install gcc automake autoconf libtool make zlib zlib-devel libffi-devel && \
    cd openssl-1.0.2r && \
    ./config --prefix=/usr/local/openssl no-zlib && \
    make && make install && \
    cd .. && rm -rf openssl-1.0.2r* && \
    wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tar.xz && \
    tar -Jxf Python-3.7.3.tar.xz && \
    cd Python-3.7.3 && \
    ./configure --prefix=/usr/local/python3 && \
    make && make install && \
    rm -rf /usr/bin/python && rm -rf /usr/bin/pip && \
    ln -s /usr/local/python3/bin/python3 /usr/bin/python && \
    ln -s /usr/local/python3/bin/pip3 /usr/bin/pip && \
    sed -i 's/\/usr\/bin\/python/\/usr\/bin\/python2.7/g' /usr/bin/yum && \
    cd .. && rm -rf Python-3.7.3* && \
#    pip3 install --upgrade pip && \
    pip install --upgrade pip && \
    python -v
