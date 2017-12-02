FROM ruby:2.4-alpine3.6

ENV APP_HOME /app

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY src/Gemfile* ./
RUN bundle install

ADD src/ $APP_HOME
