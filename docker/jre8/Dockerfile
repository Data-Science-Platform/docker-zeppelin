FROM openjdk:8-jre

RUN echo "Acquire::http::Proxy \"http://proxy02.gda.allianz:3128\";" >> /etc/apt/apt.conf.d/proxy.conf
RUN echo "Acquire::https::Proxy \"http://proxy02.gda.allianz:3128\";" >> /etc/apt/apt.conf.d/proxy.conf
RUN echo 'Acquire::https::Verify-Peer false;' >> /etc/apt/apt.conf.d/proxy.conf
ENV HTTP_PROXY="http://proxy02.gda.allianz:3128"
ENV HTTPS_PROXY="http://proxy02.gda.allianz:3128"

RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y \
    curl \
    grep \
    sed \
    git \
    wget \
    bzip2 \
    gettext \
    sudo \
    ca-certificates \
    libglib2.0-0 \
    libxext6 \
    libsm6 \
    libxrender1 \
    libaio1 \
    build-essential \
    p7zip-full \
    unzip && \
  apt-get clean all

RUN mkdir -p opt/oracle
COPY ./oracle/linux/ .
RUN unzip instantclient-basic-linux.x64.zip -d /opt/oracle \
 && unzip instantclient-sdk-linux.x64.zip -d /opt/oracle  \
 && unzip instantclient-sqlplus-linux.x64.zip -d /opt/oracle \
 && mv /opt/oracle/instantclient_* /opt/oracle/instantclient \
 && ln -s /opt/oracle/instantclient/libclntsh.so.* /opt/oracle/instantclient/libclntsh.so \
 && ln -s /opt/oracle/instantclient/libocci.so.* /opt/oracle/instantclient/libocci.so
RUN mkdir -p opt/oracle/instantclient/network/admin

ENV OCI_HOME="/opt/oracle/instantclient"
ENV OCI_LIB_DIR="/opt/oracle/instantclient"
ENV OCI_INCLUDE_DIR="/opt/oracle/instantclient/sdk/include"
ENV OCI_VERSION=12
ENV LD_LIBRARY_PATH="/opt/oracle/instantclient"
ENV TNS_ADMIN="/opt/oracle/instantclient"
ENV ORACLE_BASE="/opt/oracle/instantclient"
ENV ORACLE_HOME="/opt/oracle/instantclient"
ENV PATH="/opt/oracle/instantclient:$PATH"
RUN echo '/opt/oracle/instantclient/' | tee -a /etc/ld.so.conf.d/oracle_instant_client.conf && ldconfig


RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
  wget --quiet -e use_proxy=yes -e https_proxy=proxy02.gda.allianz:3128 https://repo.continuum.io/archive/Anaconda2-4.2.0-Linux-x86_64.sh -O ~/anaconda.sh && \
  /bin/bash ~/anaconda.sh -b -p /opt/conda && \
  rm ~/anaconda.sh

RUN /opt/conda/bin/conda install SQLAlchemy psycopg2 pymssql cx_Oracle
RUN ln -s /opt/conda/bin/python /usr/bin/python

