FROM ruby:2.1-onbuild
RUN mkdir -p /usr/src/app/config
VOLUME /usr/src/app/config
CMD irb