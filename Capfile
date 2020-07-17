# Load DSL and Setup Up Stages
require 'capistrano/setup'
require 'capistrano/deploy'

require 'capistrano/rails'
require 'capistrano/bundler'
require 'capistrano/rvm'
require 'capistrano/puma'
install_plugin Capistrano::Puma  # Default puma tasks
# install_plugin Capistrano::Puma::Workers  # if you want to control the workers (in cluster mode)
# install_plugin Capistrano::Puma::Jungle # if you need the jungle tasks
# install_plugin Capistrano::Puma::Monit  # if you need the monit tasks
# install_plugin Capistrano::Puma::Nginx  # if you want to upload a nginx site template

require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
