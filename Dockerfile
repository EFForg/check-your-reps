FROM ruby:2.5-alpine

RUN mkdir -p /opt/check-your-reps
WORKDIR /opt/check-your-reps

RUN adduser -DS -h /opt/trainers-hub www-data;

RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >>/etc/apk/repositories \
  && apk upgrade --update-cache \
  && apk add \
    build-base \
    tzdata \
    git \
    postgresql-dev \
    postgresql-client \
    nodejs \
    yarn

COPY Gemfile* ./
RUN bundle install

COPY package.json ./
COPY yarn.lock ./
RUN yarn install

COPY . .

RUN bundle exec rake assets:precompile \
  RAILS_ENV=production \
  SECRET_KEY_BASE=noop \
  DATABASE_URL=postgres://noop

RUN mkdir -p /var/www /opt/check-your-reps/files \
  && chown -R www-data /opt/check-your-reps/public \
                       /opt/check-your-reps/files \
                       /opt/check-your-reps/tmp \
                       /var/www
USER www-data

CMD ["rails", "s", "-b", "0.0.0.0"]
