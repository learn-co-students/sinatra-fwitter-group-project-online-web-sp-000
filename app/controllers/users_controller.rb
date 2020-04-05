class UsersController < ApplicationController

  get '/users/:user_slug' do
    @user = User.find_by(username: params[:user_slug])
    erb :'users/show'
  end
end
