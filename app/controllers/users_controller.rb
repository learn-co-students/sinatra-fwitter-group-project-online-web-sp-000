class UsersController < ApplicationController

    get '/' do
        erb :index
    end

    get '/signup' do
        erb :'users/create_user'
    end

    post '/signup' do
        user = User.new(email: params[:email], username: params[:username], password: params[:password])
        if user && user.save && user.authenticate(params[:password])
            redirect to '/tweets'
        else
            redirect to '/signup'
        end
    end
end
