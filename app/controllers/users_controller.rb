class UsersController < ApplicationController

  get '/login' do
    erb :"/users/login"
  end

  get "/login" do
    erb :login
  end

  post "/login" do
    puts params
    user = User.find_by(:username => params[:username])
    if user
      session[:user_id] = user.id
      redirect "/tweets/index"
    else
      redirect "/users/signup"
    end
  end

  get "/logout" do
    session.destroy
    redirect "/login"
  end

end
