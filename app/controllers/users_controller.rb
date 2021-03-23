# require 'rack-flash'
class UsersController < ApplicationController

    get '/users' do 
        @user = User.find(session[:user_id])
        erb :"/users/show"
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :"/users/show"
    end

end
