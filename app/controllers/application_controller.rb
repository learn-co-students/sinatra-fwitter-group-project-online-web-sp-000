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
  
  get '/signup' do
    erb :signup
  end
  
  post '/tweets/tweets' do
    user = User.create(params)
    redirect "/tweets/tweets"
  end
end