class UsersController < ApplicationController

  get '/signup' do
    erb :'users/signup'
  end

  get '/login' do
    erb :'users/login'
  end

  post '/signup' do
    @user = User.new(params[:user])

    if @user.save
      session[:user_id] = @user.id
      binding.pry
      redirect "/tweets"
    else
      redirect "/error"
    end
  end

end
