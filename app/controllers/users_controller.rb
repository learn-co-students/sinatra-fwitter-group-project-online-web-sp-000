class UsersController < ApplicationController

    get '/signup' do
        # display the user signup form
        if logged_in?
            redirect to '/tweets'
        else
            erb :'users/create_user'
        end
    end
    
      post '/signup' do
        # create the user, save it to database
        # log the user in
        # add the user_id to the sessions hash
        # directs user to twitter index
        # does not let a logged in user view the signup page
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
          redirect to '/signup'
        else
          user = User.create(username: params[:username], email: params[:email], password: params[:password]) # .create(params)
          session[:user_id] = user.id
          redirect to '/tweets'
        end
      end    

    get '/login' do
        # loads the login page
        # loads the tweets index after login
        # does not let user view login page if already logged in
        if logged_in?
            redirect to '/tweets'
        else
            erb :'users/login'
        end
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to '/tweets'
        else
            redirect to '/signup'
        end
    end

    get '/logout' do
        if logged_in?
            session.clear
            redirect to '/login'
        else
            redirect to '/'
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end

end
