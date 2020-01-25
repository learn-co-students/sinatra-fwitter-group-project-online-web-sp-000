require './config/environment'

class ApplicationController < Sinatra::Base
  enable :sessions

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  helpers do

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end


    def logged_in?
      !!current_user
    end
  end
  

end
