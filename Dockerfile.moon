FROM darthjee/moon-base:1.1.1

WORKDIR /home/app/app
COPY --chown=app:app source/Gemfile* /home/app/app/
COPY --chown=app:app source/bower.json /home/app/app/

RUN bundle install

USER app
RUN bower install
