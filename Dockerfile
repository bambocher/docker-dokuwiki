FROM alpine:3.2
MAINTAINER Dmitry Prazdnichnov <dp@bambucha.org>

RUN apk --update add lighttpd php-cgi php-gd \
    && rm -rf /var/cache/apk/*

ENV VERSION     2015-08-10a
ENV CHECKSUM    a4b8ae00ce94e42d4ef52dd8f4ad30fe

RUN wget -O dokuwiki.tgz http://download.dokuwiki.org/src/dokuwiki/dokuwiki-$VERSION.tgz \
    && echo "$CHECKSUM  dokuwiki.tgz" | md5sum -c - \
    && tar -zxf dokuwiki.tgz \
    && rm dokuwiki.tgz \
    && mv dokuwiki-$VERSION /dokuwiki \
    && chmod 755 /dokuwiki \
    && chown -R lighttpd:lighttpd /dokuwiki \
    && chmod +x /dokuwiki \
    && chown -R lighttpd:lighttpd /var/log/lighttpd \
    && chmod +x /var/log/lighttpd

ADD lighttpd.conf /etc/lighttpd/lighttpd.conf

EXPOSE 80

VOLUME [/dokuwiki/data, /dokuwiki/lib/plugins, \
        /dokuwiki/conf, /dokuwiki/lib/tpl, /var/log/lighttpd]

ENTRYPOINT ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
