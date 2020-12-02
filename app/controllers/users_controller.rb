require './config/environment'
require 'rack-flash'

class UsersController < ApplicationController
    use Rack::Flash

    get '/login' do
        if logged_in?
            redirect to '/tweets'
        end

        erb :'/users/login'
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/tweets'
         else
            erb :'/users/login'
         end
    end

    get '/signup' do
        
        if logged_in?
            redirect to '/tweets'
        else
            # binding.pry
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

        user = User.new(username: params[:username], email: params[:email], password: params[:password])
        user.save!
        session[:user_id] = user.id
        redirect to "/tweets"
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end

    get '/logout' do
        if logged_in?
          session.destroy
          redirect to '/login'
        else
          redirect to '/'
        end
      end

end
