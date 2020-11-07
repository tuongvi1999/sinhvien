## STAGE 1: Build
FROM node:12-alpine as build

WORKDIR /usr/src/app

ADD package.json .

RUN yarn install

ADD . .

RUN yarn build

## STAGE FINAL: Run
FROM gcr.io/distroless/nodejs:12

WORKDIR /app

COPY --from=build /usr/src/app/ ./

ENV NODE_ENV=production

EXPOSE 3000

CMD ["/app/dist/main"]