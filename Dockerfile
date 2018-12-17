
FROM ruby:2.5
# run update and install build essentials
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Create lobsters user and group.
#RUN addgroup -S lobsters && adduser -S -h /lobsters -s /bin/sh -G lobsters lobsters


RUN mkdir /lobsters
WORKDIR /lobsters/

# Copy Gemfile to container.
COPY ./lobsters/Gemfile  /lobsters/
COPY ./lobsters/Gemfile.lock /lobsters/
RUN bundle install

COPY ./lobsters ./docker-assets /lobsters/




# Copy lobsters into the container.

# Expose HTTP port.
EXPOSE 3000

# Execute our entry script.
CMD ["/lobsters/docker-entrypoint.sh"]
