require './config/environment'

class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'

        enable :sessions
        set :session_secret, "dont_tell_anyone"
    end

    get '/' do
        erb :home
    end

    get '/signup' do
        if !logged_in? #helper method
            erb :'users/new'
        else
            redirect '/tweets'
        end
    end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect '/signup'
        else
            @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
            session[:user_id] = @user.id
            redirect '/tweets'
        end
    end

    get '/login' do
        if !logged_in?
            erb :'/login'
        else
            redirect '/tweets'
        end
    end

    post '/login' do
        user = User.find_by(:email => params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/tweets'
        else
            redirect '/signup'
        end
    end

    get '/logout' do
        if logged_in?
            logout!
            redirect '/login'
        else
            redirect '/'
        end
    end
    
    helpers do

        def logged_in?
            !!current_user
        end

        def log_in(email, password)
            user = User.find_by_id(id: session[:user_id])

            if user && user.authenticate(password)
                session[:user_id] = user.id
            else
                redirect '/login'
            end
        end

        def current_user
            @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
        end

        def logout!
            session.clear
        end

    end

end