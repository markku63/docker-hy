FROM jekyll/jekyll:3.8.3 as build-stage

WORKDIR /tmp

COPY Gemfile* ./

RUN bundle install

WORKDIR /usr/src/app

COPY . .

RUN chown -R jekyll .

RUN jekyll build

FROM nginx:alpine
ENV PORT=80
COPY --from=build-stage /usr/src/app/_site/ /usr/share/nginx/html
COPY default.conf.template /etc/nginx/templates/default.conf.template