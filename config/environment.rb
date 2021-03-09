ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(ENV['SINATRA_ENV'].to_sym)

require_relative '../app/controllers/application_controller'
require_relative '../app/controllers/users_controller'
require_relative '../app/controllers/tweets_controller'
require_all 'app'
