# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

SoftwareWebApp::Application.load_tasks

require 'rubygems'

desc 'Default: run specs.'
task :default => :spec

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  require 'rspec/core/rake_task'
  require 'ci/reporter/rake/rspec'


  t.pattern = "./spec/**/*_spec.rb" # don't need this, it's default.
  # Put spec opts in a file named .rspec in root
  t.rcov = true
  t.rcov_opts = ['--exclude "spec/*,gems/*,features/*" --aggregate coverage/aggregate.data']
  
end

