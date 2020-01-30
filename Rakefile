ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
#Gives you many Rake tasks from ActiveRecord like like "rake db:migrate"
require 'sinatra/activerecord/rake'

task :console do
  Pry.start
end 


# Type `rake -T` on your command line to see the available rake tasks.
