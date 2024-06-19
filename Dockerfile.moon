FROM darthjee/moon-base:1.2.0

WORKDIR /home/app/app
COPY --chown=app:app source/Gemfile* /home/app/app/
COPY --chown=app:app source/package.json /home/app/app/

# RUN bundle install
RUN yarn install
