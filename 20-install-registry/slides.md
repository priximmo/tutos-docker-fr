%title: Docker registry
%author: xavki

# Docker : installation d'une registry

<br>


* si besoin vidéo pull/push/tags

<br>


* installation via conteneur docker => docker compose (tracabilité du fichier)

<br>


* sécuriser => important comme tous les dépôts


# Génération d'un certificat auto-signé


* pour éviter le mode insecure (alerte docker)

<br>


```
mkdir certs/
openssl req -x509 -newkey rsa:4096 -nodes -keyout certs/myregistry.key -out certs/myregistry.crt -days 365 -subj /CN=myregistry.my
```

Rq : attention aux droits (0600) sur la clef

---------------------------------------------------------------------------



# Création d'un user mot de passe de connexion



<br>


* cas d'une authentification par user/password

* autres méthodes possibles


<br>


* génération du fichier htpasswd


```
mkdir passwd/
docker run --entrypoint htpasswd registry:2 -Bbn xavki password > passwd/htpasswd
```

----------------------------------------------------------------------------


# Docker compose

* répertoire de data : mkdir data/

```
version: "3.5"
services:
  registry:
    restart: always
    image: registry:2
    container_name: registry
    ports:
      - 5000:5000
    environment:
      REGISTRY_HTTP_TLS_CERTIFICATE: /certs/myregistry.crt
      REGISTRY_HTTP_TLS_KEY: /certs/myregistry.key
      REGISTRY_AUTH: htpasswd
      REGISTRY_AUTH_HTPASSWD_PATH: /auth/htpasswd
      REGISTRY_AUTH_HTPASSWD_REALM: Registry Realm
    volumes:
      - ./data:/var/lib/registry
      - ./certs:/certs
      - ./passwd:/auth
```
