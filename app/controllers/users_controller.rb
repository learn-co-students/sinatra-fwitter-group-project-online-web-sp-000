class UsersController < ApplicationController

	get '/signup' do

		redirect('/tweets') if logged_in?
		# binding.pry
		erb :'users/signup'		
	end

	post '/signup' do
		user = User.new(params)
		# binding.pry
		if user.save 
			# binding.pry
			session[:user_id] = user.id
			redirect('/tweets')
		else
			redirect('/signup')
		end
	end

	get '/login' do
		# binding.pry
		if !logged_in?
			erb :'users/login'
		else
			redirect('/tweets')
		end
	end

	post '/login' do
		@user = User.find_by(username: params[:username])
		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			# binding.pry
			redirect :'/tweets'
		else
			# binding.pry
			redirect :'/signup'
		end
	end

	get '/logout' do
		session.destroy
		# binding.pry
		redirect :'/login'
	end

	get "/users/:slug" do
		@user = User.find_by_slug(params[:slug])
		@tweets = @user.tweets
    erb :'users/show'
	end

end
