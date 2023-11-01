FROM ruby:3.2.2
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /archimate
WORKDIR /archimate
COPY Gemfile /archimate/Gemfile
COPY Gemfile.lock /archimate/Gemfile.lock
RUN bundle install
COPY . /archimate

CMD ["rails", "server", "-b", "0.0.0.0"]
