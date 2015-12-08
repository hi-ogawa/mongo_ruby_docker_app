FROM ruby:2.1-onbuild
RUN mkdir -p /usr/src/app/config
VOLUME /usr/src/app/config
RUN mkdir -p /usr/src/app/logs
VOLUME /usr/src/app/logs
CMD irb
