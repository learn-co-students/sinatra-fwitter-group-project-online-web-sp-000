require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    #set :session_secret, ENV.fetch('SESSION_SECRET')
    #set :session_secret, SecureRandom.hex(64)
    set :session_secret, "secret"
  end

  get '/' do
    erb :'/index'
  end

  helpers

    def logged_in?
      !!current_user
    end

    def current_user
      if session[:user_id]
      @current_user ||=User.find_by(id: session[:user_id])
      end
    end

end
