FROM alpine:3.5
MAINTAINER Dmitry Prazdnichnov <dp@bambucha.org>

ARG BUILD_DATE
ARG VERSION
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url=https://github.com/bambocher/docker-dokuwiki \
      org.label-schema.license=MIT \
      org.label-schema.schema-version=1.0

COPY ./entrypoint.sh /
COPY ./lighttpd.conf /etc/lighttpd/lighttpd.conf

RUN apk --no-cache add lighttpd php5-cgi php5-curl php5-gd php5-json \
		php5-openssl php5-xml php5-zlib \
	&& apk --no-cache --virtual build-dependencies add curl tar \
	&& mkdir /dokuwiki \
	&& curl -sL https://github.com/splitbrain/dokuwiki/archive/release_stable_$VERSION.tar.gz \
        | tar xz -C /dokuwiki --strip-components=1 \
    && apk del build-dependencies \
    && chmod +x /entrypoint.sh \
    && sed -ie "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/php.ini

VOLUME ["/dokuwiki/data", "/dokuwiki/lib/plugins", \
        "/dokuwiki/conf", "/dokuwiki/lib/tpl"]

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
CMD ["-D", "-f", "/etc/lighttpd/lighttpd.conf"]
