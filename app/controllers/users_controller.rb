class UsersController < ApplicationController

  get '/users' do
    if session[:user_id]
      @users = User.all
      erb :'users/show'
    else
      redirect '/login'
    end
  end

  #route to get user page by id
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

end