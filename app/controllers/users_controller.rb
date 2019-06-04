class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    # binding.pry
  erb :'users/show'
  end

end
