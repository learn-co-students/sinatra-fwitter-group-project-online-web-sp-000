require './config/environment'

class ApplicationController < Sinatra::Base

  require 'rack-flash'
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret'
  end

  get '/' do #homepage
    erb :index
  end

  helpers do
    def fields_filled?
      !(params[:username].empty? || params[:password].empty? || (!!params[:email] ? params[:email].empty? : false))
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def login(user)
      session[:user_id] = user.id
    end
  end

end
