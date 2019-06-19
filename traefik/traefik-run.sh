docker network create web
docker run -d -p 8000:8000 -p 80:80  -p 443:443 -v $PWD/config.toml:/etc/traefik/traefik.toml -v /var/run/docker.sock:/var/run/docker.sock --network web traefik
