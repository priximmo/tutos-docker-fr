%title: Docker
%author: xavki



# Docker : cgroups et namespaces


<br>
* docker : des processus, des volumes, des réseaux, des users...


<br>
* docker utilise plusieurs systèmes du noyau linux


<br>
* notamment CGroups et Namespaces


<br>
* apporte de la sécurité : users / processus / ressources


<br>
* user namespace > cf vidéo précédente de la playlist

* on peut toujours définir le user au run : --userns = host
	- utilisation des users du host

----------------------------------------------------------------------


# Les CGroups



<br>
* inventé par Google à partir de 2006

* permet la gestion des allocations de ressources et une isolation

<br>
* Memory CG : limites la mémoire disponible (encadre)

<br>
* Huge TBL : utilisation de la RAM par des pages de grandes tailles 
			- impact important sur l'utilisation de la mémoire/performance

<br>
* CPU CG : allocation du CPU par group

<br>
* BlkIO CG : gestion des IO (policies etc)

<br>
* net-cls et net_prio : tag du traffic pour la gestion réseau

<br>
* freezer et devices : maintenance, debug, devices


------------------------------------------------------------------------


# Les Namespaces



<br>
* isolation en conteneur système linux


<br>
* PID ns : isolation des processus


<br>
* NET ns : gestion du réseau


<br>
* IPC ns : accès aux ressources IPC


<br>
* MNT ns : gestion des montages (mount)


<br>
* UTS ns : kernel isolation (users et hostname)
