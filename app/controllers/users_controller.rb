class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
            redirect '/tweets'
        else
            erb :'users/create_user'
        end
    end

    post '/signup' do
        params.each do |key, value|
            if value.empty?
                flash[:new_user_error] = "Please enter a value for #{key}"
                redirect '/signup'
            end
        end
        user = User.create(params)
        session[:user_id] = user.id
        redirect '/tweets'
    end

    get '/login' do
        if logged_in?
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
            flash[:login_error] = "Incorrect login. Please try again."
		    redirect '/login'
		end
    end

    get '/logout' do
        if logged_in?
            session.clear
            redirect '/login'
        else
            redirect '/'
        end
    end

    post '/logout' do
        if logged_in?
            session.clear
            redirect '/login'
        else
            redirect '/'
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end

end
