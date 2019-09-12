require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_lab_session_key"
  end

  get '/' do
    erb :index
  end

  helpers do
    def signup_form_incomplete?(params)
      !!(params[:username].empty? || params[:email].empty? || params[:password].empty?)
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def logged_in?
      !!current_user
    end

  end

end
