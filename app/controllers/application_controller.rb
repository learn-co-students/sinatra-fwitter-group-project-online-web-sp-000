require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "my_application_secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :"index"
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      user = User.find_by(id: session[:id])
    end
  end
end
