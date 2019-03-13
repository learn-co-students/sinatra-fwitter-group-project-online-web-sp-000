class UsersController < ApplicationController

  get '/users/logout' do
    binding.pry
    session.clear
    erb :'/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

end
