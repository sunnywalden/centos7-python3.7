FROM centos

MAINTAINER sunnywalden@gmail.com

USER root

RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum clean all && \
    yum makecache && \
    yum -y update && \
    pip install --upgrade pip && \
    wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz -o /tmp/Python-3.7.3.tgz && \
    tar -zxvf /tmp/Python-3.7.3.tgz -C /tmp && \
    cd /usr/bin && mv python python2_backup && \
    yum -y install gcc automake autoconf libtool make zlib zlib-devel && \
    cd /tmp/Python-3.7.3 && \
    /configure --prefix=/usr/local/python/python3 && \
    make && make install && \
    ln -s /usr/local/python/python3/bin/python3 /usr/bin/python && \
    sed -i '/\/usr\/bin\/python/\/usr\/bin\/python2.7/' /usr/bin/yum && \
    python -v