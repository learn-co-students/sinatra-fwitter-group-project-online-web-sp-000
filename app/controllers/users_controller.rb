class UsersController < ApplicationController

    # get '/login' do
    #
    #   erb :"users/login"
    # end
    #
    # post '/login' do
    #   user = User.find_by(:username => params[:username])
    #
    #    if user && user.authenticate(params[:password]) && user.username != ""
    #      session[:user_id] = user.id
    #
    #       redirect "/users/#{user.id}"
    #   else
    #      erb :"users/error"
    #   end
    # end

    get '/signup' do
      erb :"users/create_user"
    end


    post '/users' do

    if params[:username] != "" && params[:email] != "" && params[:password] != ""
  		 @user = User.create(params)
  		     redirect "/login"
  		   else
  		     erb :"users/failure"
  		  end
      end

    get '/users/:id' do
      "this will be the users show route"
    end


end
