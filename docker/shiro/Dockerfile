
FROM internal.docker.gda.allianz/bionic-20210222-non-root:maven

USER app

ENV HTTP_PROXY="http://proxy02.gda.allianz:3128"
ENV HTTPS_PROXY="http://proxy02.gda.allianz:3128"

RUN sudo npm config set strict-ssl false
RUN sudo npm install --proxy http://proxy02.gda.allianz:3128 -g bower grunt
RUN sudo npm config set proxy  http://proxy02.gda.allianz:3128
RUN sudo npm config set https-proxy http://proxy02.gda.allianz:3128
ADD build /build/build
RUN sudo chown app:app /build 
RUN ./build/build shiro

