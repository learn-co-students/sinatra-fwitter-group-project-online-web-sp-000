class UsersController < ApplicationController

	get '/signup' do
		redirect '/tweets' if logged_in?
		erb :'/users/signup'
	end

	post '/signup' do
		@user = User.new(:email => params[:email], :username => params[:username], :password => params[:password])
		
		if @user.save
			session[:user_id] = @user.id
			redirect '/tweets'
		else
			redirect '/signup'
		end
	end

	get '/login' do
		redirect '/tweets' if logged_in?
		erb :'/users/login'
	end

	post '/login' do
		user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect '/tweets'
		else
			erb :'users/login'
		end
	end

	get '/logout' do
		if logged_in?
			erb :'/users/logout'
		end
		redirect '/login'
	end 

	post '/logout' do
		if !logged_in?
			logout!
			erb :'/users/login'
		end
		redirect '/tweets' 		
	end

	get '/users/:slug' do
		@user = User.find_by_slug(params[:slug])
		erb :"/users/show"
	end

	patch '/users/:slug/edit' do

	end



end
