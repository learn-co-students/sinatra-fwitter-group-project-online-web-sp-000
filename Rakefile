ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'



# Type `rake -T` on your command line to see the available rake tasks.
desc 'drop into the Pry console'
task :console do
  Pry.start
end


desc 'seed the database with some dummy data'
  task :seed do
    require_relative './db/seeds.rb'
  end