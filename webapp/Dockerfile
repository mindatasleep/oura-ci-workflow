FROM ruby:2.6.5

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

WORKDIR /myapp
COPY Gemfile Gemfile.lock /myapp/
RUN gem install bundler && bundle install --jobs 20 --retry 5
RUN rails webpacker:compile
COPY . /myapp/

# Add a script to be executed every time the container starts.
# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
# EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
