ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(ENV['SINATRA_ENV'].to_sym)

require_all 'app'

configure do
    enable :sessions unless test?
    set :session_secret, "superduperhypersecret"
end

