ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

task :reset do
  Rake::Task['db:migrate'].invoke
  Rake::Task['db:migrate'].reenable
  Rake::Task["db:migrate SINATRA_ENV=test"].execute
end

task :console do
  Pry.start
end

# Type `rake -T` on your command line to see the available rake tasks.
