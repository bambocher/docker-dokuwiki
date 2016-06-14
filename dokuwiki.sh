#!/usr/bin/env ash
chown -R lighttpd. /dokuwiki \
    && lighttpd -D -f /etc/lighttpd/lighttpd.conf

