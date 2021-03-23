require './config/environment'

class ApplicationController < Sinatra::Base

  #use Rack::Flash Might wanna get this to work or not

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
     @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def authentication_required
      if !logged_in
        flash[:notice] = "You must be logged in to view tweets."
        redirect '/'
      end
    end
  end
end
