require './config/environment'

class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'

        enable :sessions # issues the browser a cookie
        set :session_secret, "dont_tell_anyone"
    end

    # HOME
    get '/' do
        erb :home
    end

    # SIGN UP
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
        # 1st Attempt:

        # @user = User.new
        # @user.username = params[:username]
        # @user.email = params[:email]
        # @user.password = params[:password]
        #
        # if @user.save
        #     redirect '/tweets'
        # else
        #     redirect '/signup'
        # end
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
            # session.destroy
            logout!
            redirect '/login'
        else
            redirect '/'
        end
    end

    # helper methods
    helpers do

        # validate
        def logged_in?
            !!current_user
        end

        # login
        def log_in(email, password)
            user = User.find_by_id(id: session[:user_id])

            if user && user.authenticate(password)
                session[:user_id] = user.id
            else
                redirect '/login'
            end
        end

        # current_user
        def current_user
            @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
        end

        # logout
        def logout!
            session.clear
        end

    end

end
