FROM centos

MAINTAINER sunnywalden@gmail.com

USER root

ADD Python-3.7.3.tar.xz ./

RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum clean all && \
    yum makecache && \
    yum -y update && \
    yum install -y wget && \
#    tar -Jxf Python-3.7.3.tar.xz && \
    yum -y install gcc automake autoconf libtool make zlib zlib-devel && \
    cd Python-3.7.3 && \
    ./configure --prefix=/usr/local/python3 && \
    make && make install && \
    ln -s /usr/local/python3/bin/python3 /usr/bin/python && \
    ln -s /usr/local/python3/bin/pip3 /usr/bin/pip && \
    sed -i '/\/usr\/bin\/python/\/usr\/bin\/python2.7/' /usr/bin/yum && \
    cd .. && rm -rf Python-3.7.3* && \
    pip3 install --upgrade pip && \
    pip install --upgrade pip && \
    python -v
