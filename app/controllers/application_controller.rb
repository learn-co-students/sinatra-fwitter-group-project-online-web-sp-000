require './config/environment'
require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, 'secret'
  end
 

  get '/' do 
    erb:'/homepage'
  end 

  helpers do 
    
    def current_user 
      @user = User.find_by(id:session["user_id"])
    end 

    def logged_in?
      if current_user
        true 
      else 
        false 
      end 
    end
  end  

end




 
