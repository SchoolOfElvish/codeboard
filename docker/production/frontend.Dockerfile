FROM node:18-buster AS build

WORKDIR /frontend

COPY frontend ./

ARG PUBLIC_BACKEND_URL_SSR
ARG PUBLIC_BACKEND_URL_CLIENT

RUN yarn install
RUN yarn build

FROM node:18-buster as production

WORKDIR /frontend

COPY --from=build /frontend/package.json .
COPY --from=build /frontend/build .

RUN yarn --prod
RUN yarn add dotenv

CMD node -r dotenv/config index.js
