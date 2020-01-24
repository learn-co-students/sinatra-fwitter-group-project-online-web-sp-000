class UsersController < ApplicationController

    get '/' do
      erb :index
    end

    get '/signup' do
        erb :signup
    end

    post '/signup' do
        if params[:name] == "" || params[:email] == "" || params[:password] == ""
            redirect to '/signup'
        end

        @user = User.new(params)
        @user.save
        # binding.pry
        session[:user_id] = @user.id
        redirect to 'tweets/tweets'
    end




end
