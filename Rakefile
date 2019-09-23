ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'



# Type `rake -T` on your command line to see the available rake tasks.

task :remigrate do
  Rake::Task["db:rollback"].execute
  Rake::Task["db:rollback"].execute
  Rake::Task["db:migrate"].execute 
end