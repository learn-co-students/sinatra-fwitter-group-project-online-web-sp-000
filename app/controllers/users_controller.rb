class UsersController < ApplicationController

  #This method loads the signup page
 	get '/signup' do
		if !logged_in?
      erb :'users/sign_up'
    else
			redirect '/tweets'
		end
	end
  #This method creates new users and logs them in with valid info submission.  Logged in users cannot view signup page.
  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end
  #This method loads the login page
 	get '/login' do
		if logged_in?
			redirect '/tweets'
		else
			erb :'users/login'
		end
	end

 	post '/login' do
		@user = User.find_by(username: params[:username])
		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			redirect '/tweets'
		else
			redirect '/signup'
		end
	end

  get '/users/:slug' do
		@user = User.find_by_slug(params[:slug])
		erb :'users/show'
	end


 	get '/logout' do
		if logged_in?
			session.clear
			redirect '/login'
		else
			redirect '/'
		end
	end
end
