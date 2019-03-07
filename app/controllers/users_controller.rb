require './config/environment'

class UsersController < ApplicationController
  
  get '/users/:slug' do 
    @user = User.find_by_slug(params[:slug])
    erb :'/index'
  end 
end
