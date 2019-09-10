require 'pry'
class UsersController < ApplicationController

  get '/users/:slug' do

    if logged_in?
      if User.find_by_slug(params[:slug]) == current_user
        @user = current_user
        erb :'users/index'
      end
    else
      redirect '/login'
    end
  end
end
