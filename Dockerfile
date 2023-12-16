# Start from the official ruby image
FROM ruby:3.2.2

# Envs
ENV RAILS_SERVE_STATIC_FILES=0
ENV RAILS_ENV=development
ENV QUBIKL_DATABASE_HOST=localhost
ENV QUBIKL_DATABASE_NAME=qubikl_production
ENV QUBIKL_DATABASE_USER=qubikl
ENV QUBIKL_DATABASE_PASSWORD=qubikl
ENV NODE_OPTIONS=--openssl-legacy-provider

# Install dependencies
# RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN apt-get update -qq && apt-get install -y postgresql-client curl && \
    curl -sS https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install yarn

# Create a group and user
RUN groupadd -r qubikl && useradd -r -g qubikl -m qubikl

# Change to non-root privilege
USER qubikl

# Set the work directory in the qubikl's home directory
WORKDIR /home/qubikl/myapp

# Add the Gemfile and Gemfile.lock
ADD --chown=qubikl:qubikl Gemfile /home/qubikl/myapp/Gemfile
ADD --chown=qubikl:qubikl Gemfile.lock /home/qubikl/myapp/Gemfile.lock

# Install gems
RUN bundle install

# Mount the application code as a volume
VOLUME /home/qubikl/myapp

# Start the server
CMD ["rails", "server", "-b", "0.0.0.0"]