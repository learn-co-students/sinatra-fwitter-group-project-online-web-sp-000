require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      !!current_user #turns current_user into boolearn (true/false) Where did current_user come from?
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

end
