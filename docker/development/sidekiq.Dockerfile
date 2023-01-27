FROM ruby:3.1.2-buster

RUN set -eux; \
    apt-get update; \
    apt-get -y upgrade; \
    apt-get install -y libpq-dev libssl-dev openssl

ARG UID=1000

RUN set -eux; \
    useradd -s /bin/bash -u ${UID} -m sidekiq; \
    mkdir -p /sidekiq/vendor/bundle; \
    chown -R sidekiq:sidekiq /sidekiq

USER sidekiq

WORKDIR /sidekiq

ENV BUNDLE_PATH=vendor/bundle
ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH
ENV BUNDLE_USER_CACHE=vendor/bundle/cache

# This will force using gems with native extensions instead of pre-compiled versions.
# Using precompiled versions leads to compatibility issues in the case of ARM platform.
RUN bundle config set force_ruby_platform true
