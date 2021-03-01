require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do #read - home page for fwitter

  end

  def logged_in?  #helper method to keep non users from using fwitter

  end

  def current_user  #makes sure user is current user

  end

end
