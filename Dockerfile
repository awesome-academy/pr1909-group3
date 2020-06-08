FROM ruby:2.6.5

RUN apt-get update && \
  apt-get install -y nodejs npm nano vim \
  && curl -o- -L https://yarnpkg.com/install.sh | bash

RUN mkdir /project2_group1
WORKDIR /project2_group1
COPY Gemfile /project2_group1/Gemfile
COPY Gemfile.lock /project2_group1/Gemfile.lock
RUN bundle install
RUN npm install -g yarn
RUN yarn install --check-files
COPY . /project2_group1

# Add a script to be executed every time the container starts.
COPY docker/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]