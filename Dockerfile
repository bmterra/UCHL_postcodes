FROM ruby:latest
MAINTAINER Bruno Terra

LABEL traefik.backend=uchl_map
LABEL traefik.frontend.rule=Host:postcodes.alors.blue
LABEL traefik.enable=true
LABEL traefik.port=80

RUN gem install bundler
RUN mkdir /app
ADD . /app
RUN cd /app; bundle install
ENTRYPOINT cd /app; thin -C config.yaml start
EXPOSE 80
