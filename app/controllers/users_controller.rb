require './config/environment'

class UsersController < ApplicationController

    get '/signup' do
        # if Helper.is_logged_in?(session)
        #     redirect '/tweets'
        # end
        
        erb :'/users/new'
    end

    get '/logout' do
        erb :"/users/logout"
    end

    post '/logout' do
        session.clear
        redirect '/'
    end

    post '/users' do
        params.each do |label, input|
            if input.empty?
              flash[:new_user_error] = "Please enter a value for #{label}"
              redirect to '/signup'
            end
          end

        user = User.new(username: params[:username], email: params[:email], password_digest: params[:password_digest])
        user.save
        session[:user_id] = user.id
        redirect "/tweets"
    end

    get '/login' do
        erb :'/users/login'
    end

    post '/login' do
        user = User.find_by(username: params[:username]) # , password_digest: params[:password_digest])
        if user
            session[:user_id] = user.id
            redirect '/tweets'
         else
            erb :'/users/login'
         end
    end

end
