FROM ruby:2.3.7

WORKDIR /app
ADD . /app

RUN cd /app && \
    bundle install

EXPOSE 4567

CMD ["ruby", "web.rb"]
