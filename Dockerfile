FROM internal.docker.gda.allianz/jre8:Anaconda2-2020.11

RUN apt install sssd-tools -y

ADD spark /usr/local/spark

ADD zeppelin /usr/local/zeppelin
WORKDIR /usr/local/zeppelin

RUN rm -rf conf

COPY conf.templates conf.templates

VOLUME ["/usr/local/zeppelin/notebooks"]
VOLUME ["/usr/local/zeppelin/conf"]
VOLUME ["/hive"]

RUN apt install libsss-sudo -y
RUN echo 'sudoers:        files sss' >> /etc/nsswitch.conf

EXPOSE 8080

COPY sg.sh bin
COPY start-zeppelin.sh bin

ENTRYPOINT ["bin/start-zeppelin.sh"]
