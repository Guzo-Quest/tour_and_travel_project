FROM ruby:3.2.2

ARG UID
ARG GID

RUN getent group $GID || addgroup --gid $GID app
RUN adduser --disabled-password --gecos '' --uid $UID --gid $GID app || true

RUN apt-get update && apt-get install -y --no-install-recommends postgresql-client nodejs && rm -rf /var/lib/apt/lists/*

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./

# Change ownership of the /app directory
USER root
RUN chown -R app:app /app
USER app

RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]