FROM node:18-buster

ARG UID=1000

RUN set -eux; \
    if [ "${UID}" = "1000" ]; then \
      # this image already has "node" user with UID 1000
      usermod -l frontend -s /bin/bash node; \
      groupmod -n frontend node; \
    else \
      useradd -s /bin/bash -u ${UID} -m frontend; \
    fi; \
    mkdir -p /frontend/node_modules; \
    chown -R frontend:frontend /frontend

USER frontend

WORKDIR /frontend

ENV NODE_ENV=development
