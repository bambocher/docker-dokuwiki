# DokuWiki Docker Image

[![Version](https://images.microbadger.com/badges/version/bambucha/dokuwiki.svg)](https://microbadger.com/images/bambucha/dokuwiki) [![Layers](https://images.microbadger.com/badges/image/bambucha/dokuwiki.svg)](https://microbadger.com/images/bambucha/dokuwiki/) [![Commit](https://images.microbadger.com/badges/commit/bambucha/dokuwiki.svg)](https://microbadger.com/images/bambucha/dokuwiki) [![License](https://images.microbadger.com/badges/license/bambucha/dokuwiki.svg)](https://microbadger.com/images/bambucha/dokuwiki) [![Automated Build](https://img.shields.io/docker/automated/bambucha/docker-dokuwiki.svg)](https://registry.hub.docker.com/u/bambucha/dokuwiki/) [![Docker Pulls](https://img.shields.io/docker/pulls/bambucha/dokuwiki.svg)](https://registry.hub.docker.com/u/bambucha/dokuwiki/)

## Run:

Run DokuWiki container:

```shell
docker run \
    --publish 8080:8080 \
    --name dokuwiki \
    --restart always \
    --detach \
    bambucha/dokuwiki
```

Setup DokuWiki using [installer](http://localhost/install.php).

## Data container

Create data container:

```shell
docker run --volumes-from dokuwiki --name dokuwiki_data busybox
```

Now you can safely delete dokuwiki container:

```shell
docker stop dokuwiki && docker rm dokuwiki
```

To restore dokuwiki, create new dokuwiki container and attach dokuwiki_data volume to it:

```shell
docker run \
    --publish 80:80 \
    --volumes-from dokuwiki_data \
    --name dokuwiki \
    --restart always \
    --detach \
    bambucha/dokuwiki
```

## Backup

Create dokuwiki_backup.tar.gz archive in current directory using temporaty container:

```shell
docker run \
    --rm \
    --volumes-from dokuwiki_data \
    --volume $(pwd):/backups \
    alpine:3.5 \
    tar zcvf /backups/dokuwiki_backup.tar.gz /srv
```

## Restore

Run DokuWiki container:

```shell
docker run \
    --publish 8080:8080 \
    --name dokuwiki \
    --restart always \
    --detach \
    bambucha/dokuwiki
```

Create data container:

```shell
docker run --volumes-from dokuwiki --name dokuwiki_data busybox
```

Stop dokuwiki:

```shell
docker stop dokuwiki
```

Restore from backup using temporary container:

```shell
docker run \
    --rm \
    --volumes-from dokuwiki \
    -w / \
    -v $(pwd):/backup \
    alpine:3.5 \
    tar xzvf /backup/dokuwiki_backup.tar.gz
```

Start dokuwiki:

```shell
docker start dokuwiki
```

## License

[The MIT License](LICENSE)
