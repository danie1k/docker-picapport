# danie1k/picapport

[![Docker Hub Build Type](https://img.shields.io/docker/cloud/automated/danie1k/picapport)][1]
[![Docker Hub Build Status](https://img.shields.io/docker/cloud/build/danie1k/picapport)][1]
[![MIT License](https://img.shields.io/github/license/danie1k/docker-picapport)][2]
[![Docker Hub](https://img.shields.io/badge/hub-picapport-660198.svg)][3]

Non-root [PicApport](https://www.picapport.de/) @ Alpine

**Volumes:**
* `/home/picapport/.picapport`
    must contain file `picapport.properties`
* _Any number of volumes related to configuration, at lease one with your photos._

Exposes port `80`.

Image user: `picapport` (UID 1000, GID 100)

**`picapport.properties` minimal configuration:**
```
server.port = 80
robot.root.0.path = /srv/photos  # <- This should be set as Docker volume
foto.jpg.usecache = 2
```

Full config documentation: http://wiki.picapport.de/display/PICE/PicApport-Server+Guide

[1]: https://hub.docker.com/r/danie1k/picapport
[2]: https://github.com/danie1k/danie1k/docker-picapport/blob/master/LICENSE
[3]: https://hub.docker.com/r/danie1k/picapport/builds
