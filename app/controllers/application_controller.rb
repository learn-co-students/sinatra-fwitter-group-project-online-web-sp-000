require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security" # Do you need this for sessions to work?
  end

  get '/' do
    erb :index
  end

end
