install:
	sudo docker network create web
	sudo cp traefik/traefik.service /etc/systemd/system/traefik.service
	sudo systemctl enable traefik.service
	sudo cp postal_map.service /etc/systemd/system/postal_map.service
	sudo systemctl enable postal_map.service
	sudo systemctl start postal_map.service
