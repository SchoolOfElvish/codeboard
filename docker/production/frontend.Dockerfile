FROM node:16-buster AS build

WORKDIR /frontend

COPY frontend ./

RUN yarn install
RUN yarn build

FROM node:16-buster as production

WORKDIR /frontend

COPY --from=build /frontend/package.json .
COPY --from=build /frontend/build .

RUN yarn --prod

CMD node index.js
