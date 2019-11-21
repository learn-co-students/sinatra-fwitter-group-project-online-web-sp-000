require './config/environment'

class ApplicationController < Sinatra::Base
  

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    else
   erb :'/home'
    end
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    else
   erb :'/registrations/signup'
    end
  end

    get '/login' do
      if Helpers.is_logged_in?(session)
        redirect to '/tweets'
      else
      erb :'/sessions/login'
      end
    end

    post '/signup' do
      if params[:username]== "" || params[:email]== "" || params[:password] == ""
        redirect to '/signup'
      else
        user=User.create(username: params[:username], email: params[:email], password: params[:password])
        session[:user_id]=user.id
     redirect '/tweets'
      end
    end


end
