set :application, "MSI Software Accounting"
set :repository,  "git@github.com:jmchilton/msi_software_accounting.git"
set :scm, "git"
set :user, "softacct"
#ssh_options[:forward_agent] = true
set :branch, "master"

set :deploy_to, "/home/softacct/app"
server "appdev-dom0.msi.umn.edu", :app, :web, :db, :primary => true
set :use_sudo, false

set :rvm_ruby_string, '1.8.7@softacct'
set :rvm_type, :system  
require "rvm/capistrano"
require 'bundler/capistrano'
require "whenever/capistrano"

after "deploy:create_symlink", "whenever:update_crontab"  

#role :web, "your web-server here"                          # Your HTTP server, Apache/etc
#role :app, "your app-server here"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
