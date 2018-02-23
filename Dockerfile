FROM ruby:latest
MAINTAINER Bruno Terra
RUN gem install bundler
RUN mkdir /app
ADD . /app
RUN cd /app; bundle install
ENTRYPOINT cd /app; thin -C config.yaml start
EXPOSE 8000
