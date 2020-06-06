%title: Docker
%author: xavki

# Docker : prune

<br>
* system prune

```
        - all stopped containers
        - all networks not used by at least one container
        - all dangling images
        - all build cache
```

* system prune -a

```
        - all stopped containers
        - all networks not used by at least one container
        - all volumes not used by at least one container
        - all images without at least one container associated to them
        - all build cache
```

# Docker : prune



<br>
* DinD (principe) : un conteneur qui contrôle les conteneurs...

```
docker run -ti --restart unless-stopped --name myprune -v /var/run/docker.sock:/var/run/docker.sock docker /bin/sh
```

<br>
* pour le clean toutes les 24h

```
-c "while true;do docker system prune -f; sleep 24h ;done"
```


