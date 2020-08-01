require './config/environment'
require 'sinatra/base'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  


  configure do
  enable :sessions
  use Rack::Flash
  configure do
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  end
  
  get "/" do 
    erb :index 
  end 
end
