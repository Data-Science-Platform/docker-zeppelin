FROM internal.docker.gda.allianz/bionic-20210222-non-root:docker

USER app

RUN echo "Acquire::http::Proxy \"http://proxy02.gda.allianz:3128\";" | sudo tee /etc/apt/apt.conf.d/proxy.conf
RUN echo "Acquire::https::Proxy \"http://proxy02.gda.allianz:3128\";"| sudo tee -a /etc/apt/apt.conf.d/proxy.conf
RUN echo 'Acquire::https::Verify-Peer false;'| sudo tee -a /etc/apt/apt.conf.d/proxy.conf

ENV HTTP_PROXY="http://proxy02.gda.allianz:3128"
ENV HTTPS_PROXY="http://proxy02.gda.allianz:3128"

RUN sudo apt-get clean
RUN sudo apt-get update
RUN sudo apt-get install software-properties-common openjdk-8-jdk wget git nodejs npm -y
RUN sudo apt-get install --reinstall ca-certificates -y
RUN echo 'JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' | sudo tee -a /etc/environment
RUN echo 'JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre' | sudo tee -a /etc/environment

ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"

RUN sudo wget -q -e use_proxy=yes -e https_proxy=proxy02.gda.allianz:3128 https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -P /tmp
RUN sudo tar xf /tmp/apache-maven-*.tar.gz -C /opt
RUN sudo ln -fs /opt/apache-maven-3.6.3 /opt/maven
RUN /opt/maven/bin/mvn --version

