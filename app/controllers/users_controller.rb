class UsersController < ApplicationController

    get "/login" do
        if User.is_logged_in?(session)
            redirect "/tweets"
        else
        erb :"/users/login"
        end
    end

    get "/signup" do

        if User.is_logged_in?(session)
            redirect "/tweets"
        else
            erb :"/users/signup"
        end
    end

    get "/logout" do
        if User.is_logged_in?(session)
            session.clear
            redirect "/login"
            # erb :"users/logout"
        else
            redirect "/tweets"
        end
    end

    get "/users/:slug" do
        @user = User.find_by_id(session[:user_id])
        @user_page = User.find_by_slug(params[:slug])
        @tweets = Tweet.all.collect do |t| 
            if t.user_id == @user_page.id.to_i
                t
            end
        end
        if !@tweets
            @tweets << "There are no tweets by this user"
        end
        erb :"/users/show"

    end

    post "/login" do
        @user = User.find_by(username: params[:username])

        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/tweets"
        else
            redirect "/login"
        end
        
    end

    post "/signup" do

        if params[:username]== ""
            redirect "/signup"
        elsif params[:email] == ""
            redirect "/signup"
        elsif params[:password]== ""
            redirect "/signup"
        else
            @user = User.create(params)
            session[:user_id] = @user.id
            redirect "/tweets"
        end
    end
    post '/logout' do
        session.clear
        redirect "/login"
    end
end
