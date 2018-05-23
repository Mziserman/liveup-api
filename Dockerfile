FROM ruby:2.5

RUN apt-get update -qq \
	&& apt-get install -y build-essential libpq-dev nodejs

RUN mkdir -p /app

# Copy the entrypoint at root
COPY docker-entrypoint.sh /docker-entrypoint.sh
# Make it executable
RUN chmod +x /docker-entrypoint.sh

WORKDIR /app

# Install dependencies
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

# Copy all the app
COPY . /app

ENTRYPOINT ["/docker-entrypoint.sh"]
