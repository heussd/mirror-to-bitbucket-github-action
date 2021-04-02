FROM alpine

RUN   apk add --no-cache --update bash git less openssh curl

WORKDIR /

COPY fillbucket.sh /

ENTRYPOINT [ "/fillbucket.sh" ]