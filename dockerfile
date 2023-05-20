FROM alpine:latest

RUN apk add --update yarn

ADD ./* ./elm_app
RUN cd elm_app

RUN yarn
EXPOSE 1234

CMD ["yarn", "run", "start"]



