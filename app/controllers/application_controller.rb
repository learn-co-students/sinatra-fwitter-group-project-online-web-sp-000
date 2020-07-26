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
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    end
    erb :'/users/create_user'
  end

  post '/signup' do
    if params["username"]=="" || params["password"] == "" || params["email"] == ""
      redirect to '/signup'
    end
    user = User.create(:username => params["username"], :email => params["email"], :password => params["password"])
    user.save
    session[:user_id] = user.id
    redirect to '/tweets'
  end

 

end
