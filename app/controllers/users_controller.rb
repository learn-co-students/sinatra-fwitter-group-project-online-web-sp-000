class UsersController < ApplicationController

    get "/users/signup" do
        erb :"users/create_user"
    end

    post "/users/signup" do
        user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
        if user.save && !user.username.empty?
            redirect "/users/login"
        else
            redirect "/users/signup"
        end

    end


    get "/users/login" do
        erb :"/users/login"
    end

    post "/users/login" do
        user = User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/users/show"
        else
            redirect "/users/login"
        end
    end


    get "/users/logout" do
        session.clear
        redirect "/"
    end

    get '/users/show' do
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            @tweets = @user.tweets
            erb :"/users/show"
        else
            redirect "/"
        end
    end

end