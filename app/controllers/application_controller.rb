require './config/environment'
require 'sinatra/base'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  
  enable :sessions
  use Rack::Flash
  configure do
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  helpers do
    def current_user
      @user = User.find(session[:user_id]) if session[:user_id]
    end
  
    def logged_in?
      !!current_user
    end
  end

end
