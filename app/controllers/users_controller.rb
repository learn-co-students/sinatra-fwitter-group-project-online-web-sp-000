class UsersController < ApplicationController

    get '/signup' do
        if !logged_in?
            erb :'users/create_user'
        else
            redirect to '/tweets'
        end
    end

    post '/signup' do
        if params[:email].empty? || params[:username].empty? || params[:password].empty?
            redirect to '/signup'
        else
            @user = User.create(email: params[:email], username: params[:username], password: params[:password])
            session[:user_id] = @user.id
            redirect '/tweets'
        end
    end

    get '/login' do
        if logged_in?
            redirect '/tweets'
        else 
            erb :'/users/login'
        end
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to '/tweets'
        else
            redirect to '/login'
        end
    end

    get '/users/:slug' do
        slug = params[:slug]
        @user = User.find_by_slug(slug)
        erb :"users/show"
    end

    get '/logout' do
        if logged_in?
            session.clear
            redirect '/login'
        else
            redirect '/'
        end
    end

    #post '/logout' do
    #    binding.pry
    #    session.clear
    #    redirect '/login'      
   # end

end