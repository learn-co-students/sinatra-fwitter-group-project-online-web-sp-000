require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end

  get '/' do
    erb :index
  end

  helpers do     #    all methods defined in helpers is accesable 
                #    to the views and controllers of the app
    def logged_in?  #using return value of current user to return a true or false value
      !!current_user  
    end

    def current_user    #if sess-id exists- find user & set @user
      @user ||= User.find_by(:id => session[:user_id]) if session[:user_id]
    end            
       
  end
end
