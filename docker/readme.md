docker run -it 26d147d2310f /bin/bash
apt-get update
apt-get install -y software-properties-common
apt-add-repository -y ppa:rael-gc/rvm
apt-get update
apt-get install -y  rvm
source /usr/share/rvm/scripts/rvm && rvm install ruby
gem install bundler

http://recipes.sinatrarb.com/p/deployment/lighttpd_proxied_to_thin

https://zaiste.net/posts/removing_docker_containers/
https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes

http://tiller.readthedocs.io/en/latest/general/docker/
