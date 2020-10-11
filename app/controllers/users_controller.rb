class UsersController < ApplicationController

    get '/login' do
        if self.logged_in?
            redirect '/tweets'
        else
            erb :'users/login'
        end
    end

    post '/login' do
        user = User.find_by(username: params[:username])

        if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect '/tweets'
        else
        redirect '/login'
        end
    end

    get '/logout' do
        if !self.logged_in?
            redirect '/tweets'
        else
            session.clear
            redirect '/login'
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end

end
