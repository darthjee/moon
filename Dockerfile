FROM darthjee/taa:0.2.3

WORKDIR /home/app/app
COPY --chown=app:app Gemfile* /home/app/app/

RUN bundle install --clean

USER app
