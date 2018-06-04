FROM ubuntu:16.04

COPY root /

RUN apt-get -y update \
    && apt-get install -y apt-transport-https \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5 \
    && echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list \
    && apt-get -y update \
    && apt-get install -y ftp nmap bash tar mongodb-org-tools \
    && chmod +x /dump.sh

CMD ["/dump.sh"]