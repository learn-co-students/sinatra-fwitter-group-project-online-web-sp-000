class UsersController < ApplicationController
    get '/signup' do
        erb :'/users/create_user'
    end

    post '/signup' do
        user = User.new(params)
        if User.find_by(email: params[:email])
            redirect '/login'
        elsif user.save
            session[:user_id] = user.id
            redirect '/login'
        else
            redirect '/signup'
        end
    end

    get '/login' do
        

    end
 



end
