require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
  	erb :index
  end

  get "/signup" do
  	if session[:user_id]
  		redirect "/tweets"
		end
  	erb :signup
  end

  post "/signup" do
		if params[:username].empty? || params[:email].empty? || params[:password].empty?
  		redirect "/signup"
		else 
	  	user = User.create(params)
	  	session[:user_id] = user.id
	  	redirect "/tweets"
  	end
  end
end
