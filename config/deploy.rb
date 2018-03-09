# config valid only for current version of Capistrano
lock "3.10.1"

set :application, "ai-system-management"
set :repo_url, "git@bitbucket.org:nldanang/ai-system-management.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, ENV['BRANCH'] || 'develop'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/ai-system-management"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto
set :rbenv_map_bins, %w{rake gem bundle ruby rails sidekiq sidekiqctl}

set :migration_role, :app
set :migration_servers, -> { primary(fetch(:migration_role)) }
set :conditionally_migrate, true
# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", "config/secrets.yml", ".env.test", ".env.staging", ".env.production"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  after :cleanup, 'nginx:restart'
end
set :whenever_roles, :app
set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }
