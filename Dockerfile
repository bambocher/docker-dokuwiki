FROM alpine:3.4
MAINTAINER Dmitry Prazdnichnov <dp@bambucha.org>

ENV VERSION  2015-08-10a
ENV CHECKSUM 98f0868c0cf9fc6664b57f89149fa537b73222bcc010247771e4afc08c8199fd

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
