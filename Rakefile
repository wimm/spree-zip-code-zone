# encoding: utf-8
THIS_SPREE_EXTENSION = 'spree_zip_code_zone'
require 'rubygems'
require 'rake'
require 'rake/testtask'

desc "Default Task"
task :default => [ :spec ]

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

require 'cucumber/rake/task'
Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = %w{--format pretty}
end

desc "Regenerates a rails 3 app for testing"
task :test_app do
  SPREE_PATH = ENV['SPREE_PATH']
  raise "SPREE_PATH should be specified" unless SPREE_PATH
  require File.join(SPREE_PATH, 'lib/generators/spree/test_app_generator')
  class MyTestAppGenerator < Spree::Generators::TestAppGenerator
    def tweak_gemfile
      append_file 'Gemfile' do
<<-gems
group :test do
  gem 'webrat' # Enable Webrat Matchers for this extension's view specs.
end
gem 'spree_core', :path => '#{File.join(SPREE_PATH, 'core')}'
gem 'spree_auth', :path => '#{File.join(SPREE_PATH, 'auth')}'

## Add extra Gem Dependencies your extension may need here. ##
## Don't forget to also add them to your gemspec if you're publishing it as a real RubyGem. ##

gem "#{THIS_SPREE_EXTENSION}", :path => '#{File.dirname(__FILE__)}'
gems
      end
    end

    def install_gems
      inside "test_app" do
        run 'rake spree_core:install'
        run 'rake spree_auth:install'
        run "rake #{THIS_SPREE_EXTENSION}:install"
      end

      # generate "#{THIS_SPREE_EXTENSION}:install -f"
    end

    def migrate_db
      run_migrations
    end
  end
  MyTestAppGenerator.start
end

namespace :test_app do
  desc 'Rebuild test and cucumber databases'
  task :rebuild_dbs do
    system("cd spec/test_app && rake db:drop db:migrate RAILS_ENV=test && rake db:drop db:migrate RAILS_ENV=cucumber")
  end
end
