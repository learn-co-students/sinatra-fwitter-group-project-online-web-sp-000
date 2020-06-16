require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
		set :session_secret, "password_security"  
  end

  get "/" do
		erb :index
	end

  get "/signup" do
		if logged_in?
			redirect "/tweets"
		else
			erb :signup
		end    
	end

	post "/signup" do
		user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if (user.save) && (params[:username].length > 0) && (params[:email].length > 0)
      session[:user_id] = user.id
			redirect "/tweets"
		else
			redirect "/signup"
		end
	end

  get "/login" do
    if logged_in?
			redirect "/tweets"
		else
      erb :login
		end   
	end

	post "/login" do
		user = User.find_by(:username => params[:username])
 
		if user && user.authenticate(params[:password])
		  session[:user_id] = user.id
		  redirect "/tweets"
		else
		  redirect "/failure"
		end	
	end

	get "/success" do
		if logged_in?
			redirect "/tweets"
		else
			redirect "/login"
		end
	end

	get "/failure" do
		erb :failure
	end

	helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
  end

end
