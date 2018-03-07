FROM ruby:2.4.1

# Install dependencies
RUN apt-get update -qq
RUN apt-get install -y build-essential libpq-dev nodejs graphviz

WORKDIR /tmp
ADD tuniversidad/tuniversidad/Gemfile Gemfile
ADD tuniversidad/tuniversidad/Gemfile.lock Gemfile.lock
RUN gem install bundler
RUN bundle install


# Prepare app
RUN mkdir /app
WORKDIR /app

# Move gemfile and run
#COPY Gemfile /app/Gemfile
#COPY Gemfile.lock /app/Gemfile.lock

#Config Puma
COPY tuniversidad/tuniversidad/config/puma.rb config/puma.rb

# Move folders
COPY . /app

#RUN bundle install

# Expose and setup start command
ENV RAILS_ENV=development
ENV RAILS_ROOT=/app
EXPOSE 3000

CMD bundle exec puma -C config/puma.rb

# Run app
CMD rails db:migrate
#CMD rails db:seed
CMD ["rails", "server", "-b", "0.0.0.0"]
