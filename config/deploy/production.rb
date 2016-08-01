set :branch, "master_silvermind"
set :deploy_to, "/home/silvermind_bookyt/"
set :rails_env, "production"

# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

server 'online-buha.ch:2222', user: 'silvermind_bookyt', roles: %w{app db web}

set :rbenv_ruby, '2.2.2'
set :rbenv_type, :user #:user or :system, depends on your rbenv setup
set :rbenv_map_bins, %w{rake gem bundle ruby rails unicorn eye}

set :rbenv_prefix, "RAILS_ENV=#{fetch(:rails_env)} RACK_ENV=#{fetch(:rails_env)} #{fetch(:rbenv_path)}/bin/rbenv exec"
