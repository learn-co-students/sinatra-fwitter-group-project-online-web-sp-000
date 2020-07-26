require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
   #  binding.pry
     if logged_in?
       redirect "/users/#{current_user.id}"
     else
     erb :index
   end
 end

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(session[:id]) if session[:id]
    end
  end
end
