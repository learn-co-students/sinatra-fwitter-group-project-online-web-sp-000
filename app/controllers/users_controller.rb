class UsersController < ApplicationController

    # signup routes ################################################
    # display signup form route
    get '/signup' do
        if logged_in?
            redirect '/tweets'
        else
            erb :"users/create_user"
        end        
    end

    # process signup form route
    post '/signup' do
        user = User.new(params)

        if user.save
            signup_login(params[:username], params[:email], params[:password])
            redirect '/tweets'
        else
            redirect '/signup'
        end        
    end


    # login routes ################################################
    # display login form
    get '/login' do
        if logged_in?
            redirect '/tweets'
        else
            erb :"users/login"
        end
    end

    # process login form - add the user_id to the sessions hash
    post '/login' do
        login(params[:username], params[:password])        
        redirect "/tweets"
    end


    # user home routes ################################################
    # shows only the signed in users's tweets
    get "/users/:slug" do        
        user = User.find_by_slug(params[:slug])
        @tweets = user.tweets
        erb :"users/show"
    end

    
    # logout routes ################################################
    # process logout form (in layout.erb right now)
    get '/logout' do        
        if logged_in?
            session.clear
            redirect "/login"
        else
            redirect '/'
        end        
    end
end
