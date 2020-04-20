require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret" #--> Needs to be manually set to prevent Sinatra from generating random keys with each Application instance. This allows the session hash to be accessed across all Controllers and not be reset
  end

  get '/' do
    erb :home
  end

# Define Helper Methods to be inherited by child Controllers
  def current_user
    User.find(session[:user_id])
  end

  def logged_in?
    !!session[:user_id]
  end
end
