%title: Docker
%author: xavki



# Docker: backup de volumes


<br>


* une astuce : pas forcément une pratique courante

* besoin de sauvegarder un volume docker nommé

<br>


* lancement d'un conteneur avec un volume nommé monvolume

```
docker run -tid --name monconteneur -v monvolume:/usr/share/nginx/html/ -p 80:80 nginx 
```

<br>


* liste des volumes

```
docker volume ls
```


---------------------------------------------------------------------------------------


# Sauvegarde par tar.gz


<br>


Principe :
- lancer un conteneur de sauvegarde léger  alpine
- lui monter le volume à sauvegarder  monvolume:/tmp/src
- lui monter le volume de destination    /tmp/:/tmp/dest
- lui ajouter la commande de sauvegarde (suivant le cas) : tar -czvf <dest> <source>
- prévoir la suppression automatique à la fin de la commande

<br>


Commande :

```
docker run --rm -v monvolume:/tmp/src -v /tmp/:/tmp/dest -u root alpine tar -czvf /tmp/dest/monbackup.tar.gz /tmp/src/
```

<br>


Vérification sur le host :

```
tar -xzvf /tmp/monbackup.tar.gz
```




