## Alpine DokuWiki Docker Container

### Run:

Run DokuWiki container:

```shell
docker run \
    --publish 80:80 \
    --name dokuwiki \
    --restart always \
    --detach \
    bambucha/dokuwiki
```

Setup DokuWiki using [installer](http://localhost/install.php).

### Data container

Create data container:

```shell
docker run --volumes-from dokuwiki --name dokuwiki-data busybox
```

Now you can safely delete dokuwiki container:

```shell
docker stop dokuwiki && docker rm dokuwiki
```

To restore dokuwiki, create new dokuwiki container and attach dokuwiki-data volume to it:

```shell
docker run \
    --publish 80:80 \
    --volumes-from dokuwiki-data \
    --name dokuwiki \
    --restart always \
    --detach \
    bambucha/dokuwiki
```

### Backup

Create dokuwiki-backup.tar.gz archive in current directory using temporaty container:

```shell
docker run \
    --rm \
    --volumes-from dokuwiki-data \
    --volume $(pwd):/backups \
    alpine:3.2 \
    tar zcvf /backups/dokuwiki-backup.tar.gz /dokuwiki
```

### Restore

Run DokuWiki container:

```shell
docker run \
    --publish 80:80 \
    --name dokuwiki \
    --restart always \
    --detach \
    bambucha/dokuwiki
```

Create data container:

```shell
docker run --volumes-from dokuwiki --name dokuwiki-data busybox
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
    alpine:3.2 \
    tar xzvf /backup/dokuwiki-backup.tar.gz
```

Start dokuwiki:

```shell
docker start dokuwiki
```

### Build:

```shell
git clone https://github.com/bambocher/docker-dokuwiki
cd docker-dokuwiki
docker build --tag bambucha/dokuwiki .
```

### License

[The MIT License (MIT)](LICENSE)
