FROM ubuntu:rolling

MAINTAINER Bruno Terra

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-add-repository -y ppa:rael-gc/rvm
RUN apt-get update
RUN apt-get install -y  rvm
RUN /bin/bash -l -c "rvm install ruby"
RUN /bin/bash -l -c "gem install bundler"
RUN mkdir /app

ADD .. /app

RUN cd /app; bundler install

EXPOSE 80
