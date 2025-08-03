FROM ruby:3.2.2

ARG UID
ARG GID

RUN groupadd -g $GID app || true
RUN useradd -u $UID -g $GID -m -s /bin/bash app || true

RUN apt-get update && apt-get install -y --no-install-recommends postgresql-client nodejs && rm -rf /var/lib/apt/lists/*

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./

# Change ownership of the /app directory
USER root
RUN chown -R $UID:$GID /app
USER app

RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
