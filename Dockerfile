FROM ruby:2.3-alpine
MAINTAINER make.io <mtishauser@make.io>

ENV SERVERSPEC_VERSION=2.36.1
ENV DOCKERAPI_VERSION=1.32.0

RUN apk add --update-cache \
    bash \
    curl && \
    rm -rf /var/cache/apk/*


RUN gem install serverspec -v "${SERVERSPEC_VERSION}"
RUN gem install docker-api -v "${DOCKERAPI_VERSION}"

RUN mkdir /projectfiles
WORKDIR /projectfiles

CMD cd tests; rake --silent --quiet
