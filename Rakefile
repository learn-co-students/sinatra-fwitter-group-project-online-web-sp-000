ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'
desc "opens up a pry console with database available"
task :console do
  Pry.start
end

# Type `rake -T` on your command line to see the available rake tasks.