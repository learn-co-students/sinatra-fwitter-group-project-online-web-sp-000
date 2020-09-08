ENV['SINATRA_ENV'] ||= "development"
require 'bundler/setup'
require 'sysrandom'
require 'securerandom'
require 'rack-flash'
#ENV["SESSION_SECRET"] = SecureRandom.hex(64)
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(ENV['SINATRA_ENV'].to_sym)

require_all 'app'
#ENV["SESSION_SECRET"] = SecureRandom.hex(64)
