%title: Docker
%author: xavki

# Docker : ENTRYPOINT vs CMD

<br>

* entrypoint = process de base du conteneur

* CMD : commande par défaut (arguments/paramètres)

* troublant :
		* CMD : seule remplace entrypoint

```
FROM alpine
MAINTAINER Xavki
CMD ["ping","--help"]
```

* mais ne prend pas les arguments passés en CLI

```
docker run --rm mini google.fr
```

-------------------------------------------------------------


# Docker : ENTRYPOINT vs CMD


<br>
* et également : entrypoint seul fonctionne

```
FROM alpine
MAINTAINER Xavki
ENTRYPOINT ["ping", "--help"]
```

* mais ne surcharge pas les arguments 

```
docker run --rm mini google.fr
```

<br>

----------------------------------------------------------------


# Docker : ENTRYPOINT vs CMD


<br>
* mais comment bien l'utiliser ?
		* entrypoint = process
		* CMD = paramètres par défaut

```
FROM alpine
MAINTAINER Xavki
CMD ["--help"]
ENTRYPOINT ["ping"]
```


