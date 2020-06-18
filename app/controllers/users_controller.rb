require 'pry'
class UsersController < ApplicationController

    get '/signup' do
        erb :'/users/create_user'
    end 

    post '/signup' do 
        params.each do |label, input|
            if input.empty?
                redirect to "/signup"
            end 
        end 
        @user = User.new(username: params[:username], email: params[:email], password: params[:password])
        @user.save
        session[:user_id] = @user.id
        redirect to "/tweets"
    end 

end
