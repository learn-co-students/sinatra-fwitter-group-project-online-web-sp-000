require 'pry'
class UsersController < ApplicationController

    get '/users/create_user' do
        binding.pry
        erb :'/users/create_user'
    end 

    post '/users' do 
        binding.pry
        @user = User.new(name: params[:name], email: params[:email], password: params[:password])
        @user.save
        session[:user_id] = @user.id
    end 

end
