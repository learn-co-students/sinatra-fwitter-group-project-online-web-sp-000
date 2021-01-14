class UsersController < ApplicationController
    #   

    get '/signup' do
        if Helpers.is_logged_in?(session)
          redirect to '/tweets'
        else
          erb :signup
        end
    end

    post '/signup' do
        if ((params[:username] != "") && (params[:email] != "") && (params[:password] != ""))
            @user = User.create(username: params[:username], email: params[:email], password: params[:password])
            session[:user_id] = @user.id
            redirect to '/tweets'
        else
            redirect to '/signup'
        end
    end

    get '/login' do
        if Helpers.is_logged_in?(session)
            redirect to '/tweets'
        else
            erb :'users/login'
        end
    end

    post "/login" do
        @user = User.find_by(:username => params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to '/tweets'
        else
            redirect to '/login'
        end
    end

    get '/logout' do
        if Helpers.is_logged_in?(session)
            session.destroy
            redirect to '/login'
            erb :'users/logout'
        else
            redirect to '/login'
        end
    end

    post '/logout' do
        session.destroy
        redirect to '/login'
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end


end
