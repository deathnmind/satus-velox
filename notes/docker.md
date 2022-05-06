**show running docker containers**</br>
`docker ps`

**show docker images**</br>
`docker images`

**interactive command in a container**</br>
`docker exec -it {container name} ls -l /path`

**interactive docker command line**</br>
`docker exec -it {container name} /bin/sh`

**docker copy in/out of container**</br>
`docker cp [options] [source] [destination]`

**remove all containers running or not**</br>
`docker rm -f $(docker ps -aq)`

**remove dangling objects**</br>
`docker system prune`
  
**purge images not in use in containers**</br>
`docker image prune -a`

**update a docker container restart policy**
`docker update --restart unless-stopped container1`

**docker-compose fore recreate containers**  
`docker-compose up -d --force-recreate`

**Get IP Address**
`docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container`
`docker inspect -f '{{ json .NetworkSettings }}' container | jq [.Networks]`
