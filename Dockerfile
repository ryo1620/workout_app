# Stage 1
FROM ruby:2.6.3-alpine as builder

ENV RAILS_ENV production

WORKDIR /tmp

RUN apk add --update --no-cache \
    build-base \
    libxml2-dev \
    libxslt-dev \
    postgresql-dev \
    curl-dev \
    nodejs \
    yarn \
    tzdata

# Bundle Install
RUN gem install bundler
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install --jobs $(nproc) --without development test # 並列実行で時間短縮

# Yarn Install    
COPY package.json .
COPY yarn.lock .
RUN yarn install --frozen-lockfile # yarn.lockを生成せず、更新がある場合は失敗する

# Precompile Assets
COPY . .
# assets:precompileしようとするとmaster.keyが求められるため、ダミーを作成して回避
RUN mv config/credentials.yml.enc config/credentials.yml.enc.backup && \
    EDITOR=vim rails credentials:edit && \
    bundle exec rake assets:precompile
    
# Stage 2 
FROM ruby:2.6.3-alpine

ENV RAILS_ENV production
ENV LANG C.UTF-8

ENV APP_ROOT /workout_app

RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

RUN apk add --update --no-cache postgresql-dev tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /tmp/public/packs $APP_ROOT/public/packs
COPY . .

RUN mkdir -p tmp/sockets \
    && mkdir -p tmp/pids
    
CMD ["bundle", "exec", "pumactl", "start"]