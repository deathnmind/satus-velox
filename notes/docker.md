# Docker

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

**Performance CPU/Memory of Containers**  
`docker stats --format 'Name: {{ .Name }}\n  CPU: {{.CPUPerc}}\t  Mem: {{.MemUsage}} ({{.MemPerc}})'`  

---

## Handle Docker Secrets

Two methods to hide secrets (swarm is more secure):

- Docker Swarm
- Use the `.env` file

## Docker `.env`

- Store the secrets in a file in the `docker-compose` directory
- Load the `.env` file in the docker compose file

```yaml
    env_file:
      - .env
```

- Refrence the variable from the `.env` file by name

 ```yaml
    AUTHENTIK_POSTGRESQL__PASSWORD: ${PG_PASS}
 ```

## Docker Swarm

- To use `docker secrets` you have to init docker as a swarm: `docker swarm init`
- Add secret to the repository

```bash
docker swarm init
printf "password" | docker secret create nginx_key -
```

- Load the `secrets` as a separate stanza

```yaml
    secrets:
      nginx_key:
        external: true
```

- For each service load the secret and refrence the secret

```yaml
  nginx-proxy-manager_db:
    image: 'jc21/mariadb-aria:latest'
    container_name: nginx-proxy-manager_db
    restart: unless-stopped
    expose:
      - '3306'
    environment:
      MYSQL_ROOT_PASSWORD_FILE: /run/secrets/nginx_key
      MYSQL_DATABASE: 'npm'
      MYSQL_USER: 'npm'
      MYSQL_PASSWORD_FILE: /run/secrets/nginx_key # Refrence secret by name
    volumes:
      - ./nginx-proxy-manager_db/data/mysql:/var/lib/mysql
    secrets: #Load secrets
      - nginx_key
```
