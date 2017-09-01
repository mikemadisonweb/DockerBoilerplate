FROM ubuntu:16.04

RUN apt-get update \
   && apt-get install -yq nginx

COPY files /

EXPOSE 80
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]