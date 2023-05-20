FROM alpine:latest

RUN apk add --update yarn

WORKDIR /home

COPY . .

RUN yarn cache clean
RUN yarn install
EXPOSE 3000

CMD ["yarn", "run", "start"]