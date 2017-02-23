FROM alpine:3.5
MAINTAINER Dmitry Prazdnichnov <dp@bambucha.org>

ARG BUILD_DATE
ARG VERSION
ARG VCS_REF

ADD dokuwiki.sh /usr/local/bin/dokuwiki
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url=https://github.com/bambocher/docker-dokuwiki \
      org.label-schema.license=MIT \
      org.label-schema.schema-version=1.0

RUN apk --no-cache add lighttpd php5-cgi php5-curl php5-gd php5-json php5-openssl php5-xml php5-zlib \
    && wget http://download.dokuwiki.org/src/dokuwiki/dokuwiki-$VERSION.tgz \
    && tar zxf dokuwiki*.tgz \
    && rm dokuwiki*.tgz \
    && mv dokuwiki* dokuwiki \
    && chmod 755 dokuwiki \
    && chmod +x /usr/local/bin/dokuwiki \
    && sed -ie "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/php.ini

COPY lighttpd.conf /etc/lighttpd

VOLUME ["/dokuwiki/data", "/dokuwiki/lib/plugins", \
        "/dokuwiki/conf", "/dokuwiki/lib/tpl"]

EXPOSE 80

ENTRYPOINT ["dokuwiki"]
