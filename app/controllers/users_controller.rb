class UsersController < ApplicationController

  get '/users/:id' do
      @user = User.find(params[:id])
      erb :'users/show'
  end
end