FROM centos

MAINTAINER sunnywalden@gmail.com

USER root

RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum clean all && \
    yum makecache && \
    yum -y update && \
    yum install -y wget && \
    cd /tmp && wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tar.xz && \
    tar -Jxf Python-3.7.3.tar.xz && \
    cd /usr/bin && mv python python2_backup && \
    yum -y install gcc automake autoconf libtool make zlib zlib-devel && \
    cd Python-3.7.3 && \
    /configure --prefix=/usr/local/python/python3 && \
    make && make install && \
    ln -s /usr/local/python/python3/bin/python3 /usr/bin/python && \
    ln -s /usr/local/python/python3/bin/pip3 /usr/bin/pip && \
    sed -i '/\/usr\/bin\/python/\/usr\/bin\/python2.7/' /usr/bin/yum && \
    cd /root && rm -rf /tmp/Python-3.7.3* && \
    pip3 install --upgrade pip && \
    pip install --upgrade pip && \
    python -v