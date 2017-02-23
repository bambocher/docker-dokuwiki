#!/usr/bin/env ash
chown -R lighttpd. /dokuwiki \
    && lighttpd $@
