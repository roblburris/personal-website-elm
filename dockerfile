FROM alpine:latest

RUN apk add --update yarn

ADD ./* ./

RUN yarn
EXPOSE 1234

CMD ["yarn", "run", "start"]



