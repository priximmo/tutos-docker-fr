%title: Docker
%author: xavki

# Docker : --log-opt

<br>
* simuler la génération de log

```
docker run --rm --name loggen sudobmitch/loggen 100 120
watch du  -h */*.log*
```

Rq : 100 nb block seconde + 120 nb secondes

<br>
* --log-opt max-size=1m : taille maxi du fichier

Rq : attention au-delà = suppression

<br>
* --log-opt max-file=10

<br>
* --log-driver local : pour compresser

Rq : watch du  -h */*/*.log*


<br>
* pour tous les conteneurs :

```
cat /etc/docker/daemon.json
{
	"log-driver": "local",
	"log-opts": {"max-size": "1m", "max-file": "5"}
}
systemctl reload docker
```
