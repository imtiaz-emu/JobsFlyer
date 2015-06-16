# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'jobsflyer'
set :repo_url, 'git@bitbucket.org:bytelogistics/jobsflyer.git'

set :user, 'deployer'
set :use_sudo, false

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app

# Default value for :scm is :git
set :scm, :git

# set :deploy_via, :remote_cache, # off while it is first deployment

# Default value for :format is :pretty
# set :format, :pretty
set :rvm1_ruby_version, "ruby-2.1.5"

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle}
set :linked_dirs, fetch(:linked_dirs) + %w{public/system public/uploads}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

set :pty, true

# Default value for keep_releases is 5
set :keep_releases, 5


# set config unicorn.rb, unicorn_init.sh, nginx.conf file permission after deployment
set :file_permissions_roles, :all
set :file_permissions_users, ['deployer']
set :file_permissions_chmod_mode, "0777"


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 1 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
      # execute "sudo service nginx restart"
      # execute "sudo service unicorn restart"
    end
  end

  before "deploy:updated", "deploy:set_permissions:chmod"

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end


