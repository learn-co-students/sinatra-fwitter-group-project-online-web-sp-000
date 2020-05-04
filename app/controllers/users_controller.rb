class UsersController < ApplicationController

  get '/signup' do
    erb :'users/signup'
  end

  get '/login' do
    erb :'users/login'
  end

  post '/signup' do
    # Create a new user with the information submitted
    @user = User.new(params[:user])
    binding.pry

    if @user.save
      redirect "/login"
    else
      redirect "/error"
    end
  end

end
