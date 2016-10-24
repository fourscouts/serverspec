FROM alpine:3.4
MAINTAINER make.io <info@make.io>

ENV AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXXXXXXX
ENV AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
ENV AWS_REGION=ap-northeast-1

ENV BUNDLER_VERSION 1.13.5
ENV BUILD_PACKAGES bash curl build-base ruby-dev
ENV RUBY_PACKAGES ruby ruby-io-console

RUN apk add --update-cache \
    $BUILD_PACKAGES \
    $RUBY_PACKAGES && \
    rm -rf /var/cache/apk/*

# skip installing gem documentation
RUN echo 'gem: --no-rdoc --no-ri' >> /etc/gemrc

RUN gem install bundler --version "$BUNDLER_VERSION"

# install things globally, for great justice
# and don't create ".bundle" in all our apps
ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_PATH="$GEM_HOME" \
	BUNDLE_BIN="$GEM_HOME/bin" \
	BUNDLE_SILENCE_ROOT_WARNING=1 \
	BUNDLE_APP_CONFIG="$GEM_HOME"
ENV PATH $BUNDLE_BIN:$PATH

RUN mkdir -p "$GEM_HOME" "$BUNDLE_BIN" \
	&& chmod 777 "$GEM_HOME" "$BUNDLE_BIN"

COPY Gemfile /tmp
COPY Gemfile.lock /tmp

WORKDIR /tmp
RUN bundle install

RUN mkdir /projectfiles
WORKDIR /projectfiles
