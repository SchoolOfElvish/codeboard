FROM ruby:3.1.2-buster

RUN set -eux; \
    apt-get update; \
    apt-get -y upgrade; \
    apt-get install -y libpq-dev libssl-dev openssl

ARG UID=1000

RUN set -eux; \
    useradd -s /bin/bash -u ${UID} -m backend; \
    mkdir -p /backend/vendor/bundle; \
    chown -R backend:backend /backend

USER backend

WORKDIR /backend

ENV BUNDLE_PATH=vendor/bundle
ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH
ENV BUNDLE_USER_CACHE=vendor/bundle/caches
ENV RAILS_ENV=production

COPY --chown=backend:backend backend/Gemfile backend/Gemfile.lock ./

RUN bundle config set --local deployment true; \
  bundle config set --local without development test

RUN bundle config set force_ruby_platform true
RUN bundle install

COPY --chown=backend:backend backend ./

RUN SECRET_KEY_BASE=`bundle exec rake secret` bundle exec rake assets:precompile

CMD bundle exec rake db:migrate && bin/rails server
