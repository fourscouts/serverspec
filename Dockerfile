FROM ruby:2.3-alpine
MAINTAINER make.io <info@make.io>

ENV AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXXXXXXX
ENV AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
ENV AWS_REGION=ap-northeast-1

RUN apk add --update-cache \
    build-base \
    bash \
    curl && \
    rm -rf /var/cache/apk/*

COPY Gemfile /tmp
COPY Gemfile.lock /tmp

WORKDIR /tmp
RUN bundle install

RUN mkdir /projectfiles
WORKDIR /projectfiles
