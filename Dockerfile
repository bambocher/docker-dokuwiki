FROM alpine:3.4
MAINTAINER Dmitry Prazdnichnov <dp@bambucha.org>

ENV VERSION  2016-06-26a
ENV CHECKSUM dfdb243cc766482eeefd99e70215b289c9aa0bd8bee83068f438440d7b1a1ce6

ADD dokuwiki.sh /usr/local/bin/dokuwiki

RUN apk --no-cache add lighttpd php5-cgi php5-curl php5-gd php5-json php5-openssl php5-xml php5-zlib \
    && wget http://download.dokuwiki.org/src/dokuwiki/dokuwiki-$VERSION.tgz \
    && echo $CHECKSUM "" dokuwiki*.tgz | sha256sum -c - \
    && tar zxf dokuwiki*.tgz \
    && rm dokuwiki*.tgz \
    && mv dokuwiki* dokuwiki \
    && chmod 755 dokuwiki \
    && chmod +x /usr/local/bin/dokuwiki \
    && sed -ie "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/php.ini

ADD lighttpd.conf /etc/lighttpd/lighttpd.conf

VOLUME ["/dokuwiki/data", "/dokuwiki/lib/plugins", \
        "/dokuwiki/conf", "/dokuwiki/lib/tpl"]

EXPOSE 80

ENTRYPOINT ["dokuwiki"]
