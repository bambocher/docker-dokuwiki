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

RUN apk --no-cache add lighttpd php7-cgi php7-curl php7-gd php7-json \
		php7-openssl php7-xml php7-zlib \
	&& apk --no-cache --virtual build-dependencies add curl tar \
	&& mkdir /dokuwiki \
	&& curl -sL https://github.com/splitbrain/dokuwiki/archive/release_stable_$VERSION.tar.gz \
        | tar xz -C /dokuwiki --strip-components=1 \
    && apk del build-dependencies \
    && chmod 755 dokuwiki \
    && chmod +x /usr/local/bin/dokuwiki \
    && sed -ie "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php7/php.ini

COPY lighttpd.conf /etc/lighttpd

VOLUME ["/dokuwiki/data", "/dokuwiki/lib/plugins", \
        "/dokuwiki/conf", "/dokuwiki/lib/tpl"]

EXPOSE 80

ENTRYPOINT ["dokuwiki"]
