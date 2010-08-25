set :application, "Stoneboat Pottery"
set :repository,  "git://github.com/kimos/stoneboat_pottery.git"
set :deploy_to, "/home/kevin/stoneboatpottery.ca"
set :user, "kevin"
set :use_sudo, false
set :scm, "git"
set :keep_releases, 10

default_run_options[:pty] = true

role :web, "stoneboatpottery.ca"
role :app, "stoneboatpottery.ca"
role :db,  "stoneboatpottery.ca", :primary => true


namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy", "symlink_shared_files"

task :symlink_shared_files do
  run "ln -s #{shared_path}/images #{release_path}/public/images/attachment"

  %w{database.yml}.each do |config|
    run "ln -s #{shared_path}/#{config} #{release_path}/config/#{config}"
  end
end

