FROM ruby:2.7.1

WORKDIR /app
ADD . /app

RUN gem install bundler:1.16.1

RUN cd /app && \
    bundle install

EXPOSE 4567

CMD ["ruby", "web.rb"]
