# danie1k/picapport
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