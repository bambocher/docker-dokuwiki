## Alpine DokuWiki Docker Container

### Build:

```shell
git clone https://github.com/bambocher/docker-dokuwiki
cd docker-dokuwiki
docker build --tag bambucha/dokuwiki .
```

### Run:

```shell
docker run \
    --publish 80:80 \
    --name dokuwiki \
    --restart always \
    --detach \
    bambucha/dokuwiki
```

You can now visit the [install](http://localhost/install.php) page to configure your new DokuWiki.

### License

[The MIT License (MIT)](LICENSE)
