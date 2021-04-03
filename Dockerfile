FROM alpine

LABEL org.opencontainers.image.source https://github.com/heussd/mirror-to-bitbucket-github-action

RUN   apk add --no-cache --update bash git less openssh curl

WORKDIR /

COPY fillbucket.sh /

ENTRYPOINT [ "/fillbucket.sh" ]