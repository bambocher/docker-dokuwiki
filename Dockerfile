FROM alpine:3.4
MAINTAINER Dmitry Prazdnichnov <dp@bambucha.org>

ENV VERSION  2016-06-26
ENV CHECKSUM 4d0cb8dc8b256b54e9412a8c1b73af13b079960920934085a4528e52b63eaa26

ADD dokuwiki.sh /usr/local/bin/dokuwiki

RUN apk --no-cache add lighttpd php5-cgi php5-gd php5-xml php5-openssl \
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
