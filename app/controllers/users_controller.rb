class UsersController < ApplicationController

  get '/signup' do
      if !logged_in?
          erb :'/users/create_user'
      else
          redirect '/tweets'
      end
  end

  post "/signup" do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
        redirect "/signup"
    else
        @user = User.create(params)
        session[:user_id] = @user.id
        redirect "/tweets"
    end
  end






  get '/account' do
    @user = User.find(session[:user_id])
    redirect '/tweets'
  end


  get "/login" do
    erb :'/users/login'
  end

  post "/login" do
    user = User.find_by(:username => params[:username])
#binding.pry
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/account"
#    else
#      redirect "/failure"
    end
  end



end
