FROM ruby:2.5.3-alpine

RUN \
apk add --no-cache --virtual build-dependencies --update \
    build-base \
    linux-headers \
    mariadb-client \
    mariadb-dev \
    tzdata \
    nodejs \
    yarn

ENV APP_ROOT /app

RUN mkdir ${APP_ROOT}

WORKDIR ${APP_ROOT}

ADD ./app/Gemfile Gemfile
ADD ./app/Gemfile.lock Gemfile.lock

RUN \
bundle install

ADD app ${APP_ROOT}

# 解放ポート
EXPOSE 3000

# 環境変数毎のエンドポイント
ARG RAILS_ENV
ENTRYPOINT ["/bin/sh", "-c","/app/app/script/entrypoint_${RAILS_ENV}.sh" ]