class UsersController < ApplicationController

    get '/login' do
        if !logged_in?
            erb :'users/login'
        else
            redirect '/tweets'
        end    
    end

    post '/login' do
        login(params[:username], params[:password])
        if logged_in?
            redirect '/tweets'
        else
            redirect '/login'
        end
    end

    get '/signup' do
        if logged_in?
            redirect to '/tweets'
        else
            erb :'users/create_user'
        end
    end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect '/signup'
        else
            @user=User.new(email:params[:email], username:params[:username])
            @user.password = params[:password]
            @user.save
            login(@user.username,@user.password)
            redirect '/tweets'
        end
    end

    get '/logout' do
        logout
        redirect '/login'
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end

end
