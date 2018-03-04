FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /hacker_news_rbrt
WORKDIR /hacker_news_rbrt
COPY Gemfile /hacker_news_rbrt/Gemfile
COPY Gemfile.lock /hacker_news_rbrt/Gemfile.lock
RUN bundle install
COPY . /hacker_news_rbrt
