## Alpine DokuWiki Docker Container

---

### Build:

```
git clone https://github.com/bambocher/docker-dokuwiki
cd docker-dokuwiki
docker build --tag bambucha/dokuwiki .
```

### Run:

```
docker run --detach --restart always --publish 80:80 --name dokuwiki bambucha/dokuwiki
```

You can now visit the [install](http://localhost/install.php) page to configure your new DokuWiki.

### License

[The MIT License (MIT)](LICENSE)
