FROM ubuntu:rolling

MAINTAINER Bruno Terra

RUN apt-get update
RUN apt-get -y install wget build-essential lighttpd zlib1g-dev libssl-dev libreadline6-dev libxml2-dev libsqlite3-dev libqdbm-dev libgdbm-dev
RUN wget http://ftp.ruby-lang.org/pub/ruby/2.5/ruby-2.5.0.tar.gz
RUN tar -xzf ruby-2.5.0.tar.gz
RUN cd ruby-2.5.0/; ./configure; make; make install
RUN apt-get purge -y --auto-remove wget build-essential
RUN rm -fr ruby-2.5.0*
RUN apt-get clean
RUN gem install bundler

RUN mkdir /app
ADD . /app

RUN cd /app; bundler install
