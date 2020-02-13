require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  enable :sessions
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    use Rack::Flash
    enable :sessions
      set :session_secret, "password_security"
  end

  get '/' do
    erb :'index.html'
  end

get '/' do 
  erb :'index.html'
end
