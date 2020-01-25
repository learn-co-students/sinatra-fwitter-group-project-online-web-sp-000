class UsersController < ApplicationController

    get '/' do
      erb :index
    end

    get '/signup' do
        # binding.pry
        if !logged_in?
            erb :'users/signup'
        else
            redirect to '/tweets'
        end
    end

    post '/signup' do
        # binding.pry
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect to '/signup'
        end

        @user = User.new(params)
        @user.save
        session[:user_id] = @user.id
        #  binding.pry
        redirect to '/tweets'
    end

    get '/login' do
        if !logged_in?
            erb :'users/login'
        else
            redirect '/tweets'
        end

    end


    post '/login' do
        if params[:username].empty? || params[:password].empty?
            redirect "/login"
          end
          user = User.find_by(username: params[:username])
          if user && user.authenticate(params[:password])
            session[:user_id] = user.id 
           redirect "/tweets"
          else
            redirect "/login"
          end

    end


    get '/logout' do
        session.destroy
        redirect '/login'
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end


    get '/users/:id' do
        if logged_in?
            erb :'users/show'
        else
            redirect '/login'
        end
    end






end
