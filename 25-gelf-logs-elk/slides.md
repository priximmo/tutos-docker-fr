%title: Docker
%author: xavki

# Docker : logs vers ELK

<br>
* graylog format

* doc : https://docs.docker.com/config/containers/logging/gelf/

* édition : /etc/logstash/conf.d/docker.conf 

```
input {
  gelf {
    type => docker
    port => 12201
  }
}

output {
  elasticsearch {
      hosts => ["127.0.0.1:9200"]
      index => "logstash-dk-%{+YYYY.MM.dd}"
  }
}
```

--------------------------------------------------------------------------------------


# Docker : logs vers ELk


<br>
* test conteneur unique

```
docker run --log-driver gelf --log-opt gelf-address=udp://192.168.20.101:12201 alpine echo hello world
```

<br>

* édition /etc/docker/daemon.json

```
{
  "log-driver": "gelf",
  "log-opts": {
    "gelf-address": "udp://192.168.20.101:12201"
  }
}
```

* test

```
docker run -p 80:80 nginx
```
