require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions 
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
    use Rack::Flash
  end

   helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

  get '/' do
    erb :'index'
  end

end
