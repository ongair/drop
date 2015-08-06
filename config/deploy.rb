# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'drop'
set :repo_url, 'git@github.com:ongair/drop.git'
set :bundle_flags, "--deployment"


# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/home/deploy/apps/drop'

set :linked_files, %w{config/database.yml config/secrets.yml config/sidekiq.yml  production/assets/manifest.yml}
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

  # namespace :assets do
  #   Rake::Task['deploy:assets:precompile'].clear_actions

  #   desc 'Precompile assets locally and upload to servers'
  #   task :precompile do
  #     on roles(fetch(:assets_roles)) do
  #       run_locally do
  #         with rails_env: fetch(:rails_env) do
  #           execute 'bin/rake assets:precompile'
  #         end
  #       end

  #       within release_path do
  #         with rails_env: fetch(:rails_env) do
  #           old_manifest_path = "#{shared_path}/public/assets/manifest*"
  #           execute :rm, old_manifest_path if test "[ -f #{old_manifest_path} ]"
  #           upload!('./public/assets/', "#{shared_path}/public/", recursive: true)
  #         end
  #       end

  #       run_locally { execute 'rm -rf public/assets' }
  #     end
  #   end

  # end

end
