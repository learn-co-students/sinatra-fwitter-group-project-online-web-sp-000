require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, ENV['SESSION_SECRET']
  end

  get '/' do
    erb :homepage
  end

  get '/welcome' do
    erb :homepage
  end

  helpers do
    def logged_in?
      !!current_user
    end
    
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end

end
