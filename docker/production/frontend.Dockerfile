FROM node:18-buster AS build

WORKDIR /frontend

COPY frontend ./

RUN yarn install
RUN yarn build

FROM node:18-buster as production

WORKDIR /frontend

COPY --from=build /frontend/package.json .
COPY --from=build /frontend/build .

RUN yarn --prod
RUN yarn add dotenv

CMD node -r dotenv/config index.js
