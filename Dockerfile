FROM ruby:2.3-alpine
MAINTAINER make.io <info@make.io>

RUN apk add --update-cache \
    build-base \
    bash \
    curl && \
    rm -rf /var/cache/apk/*

COPY Gemfile /tmp
COPY Gemfile.lock /tmp

RUN cd /tmp && bundle install

RUN mkdir /projectfiles
WORKDIR /projectfiles

CMD cd tests; rake --silent --quiet
