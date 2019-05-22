require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
     enable :sessions
    set :session_secret, "secret_phrase"
  end

 get '/' do
      erb :index
  end


private

def logged_in?
   !!current_user
end

def current_user
  if session[:user_id]
  @current_user ||= User.find_by(id: session[:user_id])
end
end
end
