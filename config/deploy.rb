lock "~> 3.11.0"

set :application, "sof"
set :repo_url, "git@github.com:egor-t/sof.git"
set :deploy_to, "/home/deployer/sof"
set :deploy_user, "deployer"
set :use_sudo, true

set :rails_env, 'production'
set :rvm_ruby_version, '2.5.1'

append :linked_files, "config/database.yml config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system, public/uploads"

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
end
