class UsersController < ApplicationController

  get "/login" do
  	if session[:user_id]
  		redirect "/tweets"
		end  	
  	erb :"users/login"
  end

  post "/login" do
  	user = User.find_by(username: params[:username])
  	if user
  		session[:user_id] = user.id
  		redirect "/tweets"
		end
  end

  get "/logout" do
  	# binding.pry
  	if session[:user_id]
  	  session.clear
  		redirect "/login"
		else
			redirect "/"
  	end
  end

  get "/users/:slug" do
		@user = User.find_by_slug(params[:slug])
		erb :"users/show"  	
  end
end





