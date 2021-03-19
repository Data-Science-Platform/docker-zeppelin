FROM ubuntu:bionic-20210222

RUN apt-get clean && apt-get update

RUN apt-get install --reinstall ca-certificates -y

RUN apt-get install sudo apt-transport-https \
ca-certificates curl gnupg lsb-release -y
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
| gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
| tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update && apt-get install docker-ce docker-ce-cli containerd.io -y

RUN useradd -m -u 5000 app || :
RUN echo 'app ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN apt-get clean

USER app
