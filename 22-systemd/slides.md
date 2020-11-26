%title: Docker
%author: xavki

# Docker : gestion via systemd

<br>


* systemd = gestionnaire de processus system
		- démarrage
		- arrêt
		- séquence

<br>


* pourquoi les applis docker ?
		- rassurer les plus novices
		- formaliser les lancements
		- utiliser les orchestrateurs et leurs modules systemd (ansible)
		- amélioration des logs dans syslog

<br>


* comment ?
		- création d'un service systemd qui gère docker-compose
		- arrêt / démarrage
		- redémarrage sur fail
		- users / groupes
		

--------------------------------------------------------------------------------


# Le fichier de service


<br>


/etc/systemd/system/<nom_service>.service


<br>


```
[Unit]
Description=Mon nginx
Requires=docker.service
After=docker.service

[Service]
Restart=always
User=root
Group=docker
ExecStartPre=/usr/bin/docker-compose -f /chemin/complet/docker-compose.yml down -v
ExecStart=/usr/bin/docker-compose -f /chemin/complet/docker-compose.yml up
ExecStop=/usr/bin/docker-compose -f /chemin/complet/docker-compose.yml down -v
SyslogIdentifier=monginx

[Install]
WantedBy=multi-user.target
```
