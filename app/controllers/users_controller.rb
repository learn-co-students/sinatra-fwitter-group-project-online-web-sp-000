class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do
    #user = User.new(:username => params[:username], :password => params[:password])

		#if user.username != "" && user.save
		  #redirect "/login"
		#else
		  redirect to '/tweets'
		#end
  end

end
