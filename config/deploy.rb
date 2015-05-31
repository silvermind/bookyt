# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'silvermind_bookyt'

set :repo_url, "git@github.com:silvermind/bookyt.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# NOTE: define in ENV !!
# set :deploy_to, "/home/silvermind_bookyt"

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/secrets.yml config/database.yml')
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/newrelic.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/sitemaps','public/sites', 'public/uploads')

# Bookyt AttachmentUploader Files
set :linked_dirs, fetch(:linked_dirs, []).push('uploads')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5


### EYE
set :eye_roles, -> { :app }
# set :eye_env, -> { {rails_env: fetch(:rails_env)} }
set :eye_config_file, -> { "#{current_path}/config/eye/#{fetch :rails_env}.rb" }


### Rollbar Deploy Pings
set :rollbar_token, Proc.new { ENV['ROLLBAR_ACCESS_TOKEN'] }
set :rollbar_env, Proc.new { fetch :stage }
set :rollbar_role, Proc.new { :app }

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end


namespace :eye do

  task :start do
    on roles(fetch(:eye_roles)), in: :groups, limit: 3, wait: 10 do
      within current_path do
          execute :bundle, "exec eye start silvermind_bookyt"
      end
    end
  end

  task :stop do
    on roles(fetch(:eye_roles)), in: :groups, limit: 3, wait: 10 do
      within current_path do
          execute :bundle, "exec eye stop silvermind_bookyt"
      end
    end
  end

  task :restart do
    on roles(fetch(:eye_roles)), in: :groups, limit: 3, wait: 10 do
      within current_path do
          execute :bundle, "exec eye restart silvermind_bookyt"
      end
    end
  end

  desc "Start eye with the desired configuration file"
  task :load_config do
    on roles(fetch(:eye_roles)) do
      within current_path do
          execute :bundle, "exec eye quit"
          execute :bundle, "exec eye load #{fetch(:eye_config_file)}"
      end
    end
  end

end
after "deploy:published", "eye:load_config"
after "deploy:published", "eye:restart"


# #############################################################
# #	Indexes
# #############################################################
# after 'deploy:update_code', 'indexes:create'
#
# namespace :indexes do
#   desc "create indexes"
#   task :create, :roles => [:web] do
#     run "cd #{current_path} && bundle exec rake db:mongoid:create_indexes"
#   end
# end
#



# 
# 
# ############################################################
# #       Special Rake Task available via Capistrano
# ############################################################
# # NOTE: we may use https://github.com/njonsson/cape for this in the future
# 
# # rake cnc:rails_cache:sweep_all
# 
# # Foreman tasks
# namespace :cnc do
#   namespace :rails_cache do
#     desc 'Cleart the Rails Cache via Capistrano'
#     task :sweep_all, :roles => [:app] do
#       run_rake "cnc:rails_cache:sweep_all"
#     end
#   end
# end
# 
# def run_rake(task, options={}, &block)
#   command = "cd #{current_path} && /usr/bin/env bundle exec rake #{task} RAILS_ENV=#{rails_env}"
#   #run("cd #{deploy_to}/current && bundle exec rake #{ENV['task']} RAILS_ENV=#{rails_env}")
#   run(command, options, &block)
# end