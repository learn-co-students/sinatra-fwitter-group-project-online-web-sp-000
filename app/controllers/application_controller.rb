require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :'layout'
  end

  get '/signup' do
    erb :'signup'
  end

  post '/signup' do
    user = User.new(:username => params[:username], :password => params[:password])

    if params[:username] == "" or params[:email] == "" or paams[:password] == ""
      #redirect "/failure"
      redirect "/signup"
    else
      user.save
      #redirect "/login"
      redirect 'tweets/index'
	  end

  end

  get '/login' do
    erb :login
  end

  post '/login' do

    user = User.find_by(:username => params[:username])

	  if user && user.authenticate(params[:password])
	    session[:user_id] = user.id
	    redirect "/tweets/index"
	  else
	    redirect '/failure'
	  end
  end

  get '/failure' do
    erb :failure
  end

end
