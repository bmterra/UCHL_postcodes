FROM ubuntu:rolling

MAINTAINER Bruno Terra


#RUN apt-get update
#RUN apt-get install ruby-full

RUN apt-get update
RUN apt-get -y install wget
#RUN curl http://ftp.ruby-lang.org/pub/ruby/2.5/ruby-2.5.0.tar.gz --output ruby-2.5.0.tar.gz
RUN wget http://ftp.ruby-lang.org/pub/ruby/2.5/ruby-2.5.0.tar.gz
RUN tar -xzvf ruby-2.5.0.tar.gz
RUN apt-get -y install build-essential
RUN cd ruby-2.5.0/; ./configure; make; make install
RUN ruby -v


RUN mkdir /app
ADD . /app
