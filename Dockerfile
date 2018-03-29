FROM ruby:2.5-alpine

RUN mkdir -p /opt/check-your-reps
WORKDIR /opt/check-your-reps

RUN adduser -DS -h /opt/check-your-reps www-data;

RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >>/etc/apk/repositories \
  && apk upgrade --update-cache \
  && apk add \
    build-base \
    tzdata \
    git \
    postgresql-dev \
    postgresql-client \
    nodejs \
    yarn \
    apk-cron \
    ssmtp \
  && echo "www-data:no-reply@eff.org:mail2.eff.org:587" > /etc/ssmtp/revaliases

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

COPY docker/crontab /etc/cron.d/crontab
RUN chmod 0644 /etc/cron.d/crontab
RUN touch /var/log/cron.log

USER www-data

CMD ["rails", "s", "-b", "0.0.0.0"]
