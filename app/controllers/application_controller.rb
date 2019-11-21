require './config/environment'

class ApplicationController < Sinatra::Base
  

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
   erb :'/home'
  end

  get '/signup' do
   erb :'/registrations/signup'
    end

    get '/login' do
      erb :'/sessions/login'
    end

    post '/signup' do
      if params[:username]== "" || params[:email]== "" || params[:password] == ""
        redirect to '/signup'
      else
     redirect '/tweets'
      end
    end


end
