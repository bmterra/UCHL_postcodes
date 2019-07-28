install:
	docker network create web
	sudo cp traefik/traefik.service /etc/systemd/system/docker-traefik.service
	sudo systemctl enable docker-traefik.service
