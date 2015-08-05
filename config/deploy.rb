# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'drop'
set :repo_url, 'git@github.com:ongair/drop.git'
set :bundle_flags, "--deployment"


# Default branch is :master
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/home/deploy/apps/drop'

set :linked_files, %w{config/database.yml config/application.yml config/sidekiq.yml  production/assets/manifest.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for keep_releases is 5
set :keep_releases, 5

set :assets_prefix, "production/assets"

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'

end
