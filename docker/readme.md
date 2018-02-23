docker run -it 26d147d2310f /bin/bash
apt-get update
apt-get install -y software-properties-common
apt-add-repository -y ppa:rael-gc/rvm
apt-get update
apt-get install -y  rvm
source /usr/share/rvm/scripts/rvm && rvm install ruby
gem install bundler


####
build
apt install -y ruby build-essential ruby-dev
gem install fpm-cookery

####

https://github.com/docker-library/ruby/blob/c9a4472a019d18aba1fdab6a63b96474b40ca191/2.5/stretch/Dockerfile

http://recipes.sinatrarb.com/p/deployment/lighttpd_proxied_to_thin

https://zaiste.net/posts/removing_docker_containers/
https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes

http://tiller.readthedocs.io/en/latest/general/docker/


https://github.com/vallard/docker/blob/master/rails/Dockerfile


https://superuser.com/questions/1160025/how-to-solve-ttyname-failed-inappropriate-ioctl-for-device-in-vagrant/1186281
https://stackoverflow.com/questions/43612927/how-to-correctly-install-rvm-in-docker


https://stackoverflow.com/questions/7057535/how-do-i-install-the-latest-version-of-ruby-in-ubuntu

https://gorails.com/setup/ubuntu/17.10



https://github.com/bernd/fpm-cookery


#!/bin/bash

tmp_dir="/tmp"
version="2.2.3"
minor_version="2.2"
ruby_version="ruby-$version"

echo "*******************"
echo "* Installing Ruby *"
echo "*******************"

sudo apt-get install -y autoconf build-essential libreadline-dev libssl-dev libyaml-dev zlib1g-dev libffi-dev

mkdir -p "$tmp_dir"
cd "$tmp_dir"

wget "http://cache.ruby-lang.org/pub/ruby/$minor_version/$ruby_version.tar.gz"
tar -xvzf $ruby_version.tar.gz
cd $ruby_version

./configure --disable-install-doc
make --jobs `nproc`
sudo make install

cd ..
rm $ruby_version.tar.gz
rm -rf $ruby_version

echo "*******************"
echo "* Ruby installed! *"
echo "*******************"
