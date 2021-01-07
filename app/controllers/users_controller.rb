class UsersController < ApplicationController

    get '/' do
        erb :index
    end

    get '/signup' do
        if !!session[:id]
            redirect to '/tweets'
        else
            erb :'users/create_user'
        end
    end
    
    post '/signup' do
        user = User.new(email: params[:email], username: params[:username], password: params[:password])
        if user.email != '' && user.username != '' && user.save
            session[:id] = user.id
            redirect to '/tweets'
        else
            redirect to '/signup'
        end
    end

    get '/login' do
        if !!session[:id]
            redirect to '/tweets'
        else
            erb :'users/login'
        end
    end
    
    post '/login' do
        user = User.find_by(username: params[:username])
        # binding.pry
        if user && user.authenticate(params[:password])
            session[:id] = user.id
            redirect to '/tweets'
        else
            redirect to '/login'
        end
    end
end
