class UsersController < ApplicationController

    get '/signup' do
    erb :"/users/new"
    end 

    post '/users' do 
        user = User.new(params)
        if user.save
            session[:user_id] = user.id 
            redirect to "/users/#{user.id}"
        else 
            redirect to "/signup"
        end 
    end 

    get '/users/:id' do 
        @user = User.find(params[:id])
        @tweets = @user.tweets
        erb :"/users/show"
    end 

    get '/login' do
    erb :"/users/login"
    end 

    post '/login' do 
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params:[password])
            session[:user_id] = @user.id
            redirect to "/users/#{@user.id}"
        else 
            redirect to "/login"
        end 
    end 

    get '/logout' do
    session.destroy
    erb :"/users/logout"
    end 

end
