require './config/environment'
require 'rack-flash'

class UsersController < ApplicationController
    use Rack::Flash

    get '/login' do
        if Helper.is_logged_in?(session)
            redirect '/tweets'
        end

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

    get '/signup' do
        if Helper.is_logged_in?(session)
            redirect to '/tweets'
        else
            erb :'/users/create_user'
        end
    end

    post '/signup' do
        params.each do |label, input|
            if input.empty?
              flash[:new_user_error] = "Please enter a value for #{label}"
              redirect to '/signup'
            end
          end

        user = User.new(username: params[:username], email: params[:email], password_digest: params[:password_digest])
        user.save
        session[:user_id] = user.id
        redirect to "/tweets"
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end

    get '/logout' do
        erb :"/users/logout"
    end

    post '/logout' do
        session.clear
        redirect '/login'
    end

end
