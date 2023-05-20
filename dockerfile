FROM alpine:latest

RUN apk add --update yarn
RUN yarn global add create-elm-app

ADD ./* ./elm_app
RUN ls elm_app



