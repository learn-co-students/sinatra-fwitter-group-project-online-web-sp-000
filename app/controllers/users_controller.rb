# require 'rack-flash'
class UsersController < ApplicationController

    get '/users' do 
        if User.is_logged_in?(session)
             @user = User.find(session[:user_id])
             erb :"/users/show"
        else
            redirect "/login"
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :"/users/show"
    end

end
