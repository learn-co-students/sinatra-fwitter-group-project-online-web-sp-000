require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    # added next two lines. not sure if they're necessary.
    enable :sessions
    set :session_secret, "password_security"
  end

  # load homepage
  get '/' do
    erb :layout
  end

  # load signup page
  get '/signup' do
    erb :"/users/create_user"
  end

  # load fwitter index page
  get '/index' do
    erb :'/index'
  end

end
