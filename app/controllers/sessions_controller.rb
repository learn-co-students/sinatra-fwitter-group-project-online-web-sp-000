class SessionsController < ApplicationController

  # get '/login' do 
  #   erb :'/sessions/login'
  # end

  # post '/login' do 
  #   @user = User.find_by(email: params[:email])

  #   if @user && @user.authenticate(params[:password])
  #       session[:user_id] = @user.id
  #       erb :"/users/user_home"
  #   else 
  #       erb :"/sessions/something_went_wrong"
  #   end
  # end

  get '/logout' do 
    erb :"users/logout"
  end 

  post '/logout' do 
    if session[:user_id]
      session.clear
    end 
      redirect '/'
  end

end 