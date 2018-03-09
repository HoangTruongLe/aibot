# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server "example.com", user: "deploy", roles: %w{app db web}, my_property: :my_value
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}



# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
set :rails_env, :test
set :sidekiq_default_hooks => true
set :sidekiq_pid => File.join(shared_path, 'tmp', 'pids', 'sidekiq.pid')
set :sidekiq_log => File.join(shared_path, 'log', 'sidekiq.log')
set :sidekiq_env => fetch(:rack_env)
set :sidekiq_log => File.join(shared_path, 'log', 'sidekiq.log')
set :sidekiq_config => File.join(shared_path, 'config', 'sidekiq.yml')
set :sidekiq_role => :app
set :pty,  false
#
# set :nginx_domains, "52.197.85.170"
# set :nginx_service_path, "/etc/init.d/nginx"
# set :nginx_roles, :web
# set :nginx_sudo_tasks, ['nginx:start', 'nginx:stop', 'nginx:restart', 'nginx:reload']
#
# server "52.197.85.170",
#   user: "ubuntu",
#   roles: %w{web app},
#   port: 64852,
#   ssh_options: {
#     user: "ubuntu", # overrides user setting above
#     keys: %w(~/.ssh/aichatbot_stg_id_rsa.pem),
#     forward_agent: true
#     # auth_methods: %w(publickey password)
#     # password: "please use keys"
#   }


set :nginx_domains, "52.55.148.0"
set :nginx_service_path, "/etc/init.d/nginx"
set :nginx_roles, :web
set :nginx_sudo_tasks, ['nginx:start', 'nginx:stop', 'nginx:restart', 'nginx:reload']

server "52.55.148.0",
  user: "ubuntu",
  roles: %w{web app},
  port: 48712,
  ssh_options: {
    user: "ubuntu", # overrides user setting above
    keys: %w(~/.ssh/aichatbot_dev_id_rsa.pem),
    forward_agent: true
    # auth_methods: %w(publickey password)
    # password: "please use keys"
  }
