class UsersController < ApplicationController
  get '/users/:slug' do
    # binding.pry
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end
end
