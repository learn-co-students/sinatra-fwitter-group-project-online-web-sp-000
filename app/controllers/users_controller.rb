class UsersController < ApplicationController

    get '/signup' do
        # display the user signup form
        erb :'users/create_user'
      end
    
      post '/signup' do
        # create the user, save it to database
        # log the user in
        # add the user_id to the sessions hash
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
          redirect to '/signup'
        else
          user = User.create(username: params[username], email: params[:email], password: params[:password])
          session[:user_id] = user.id
          redirect to '/tweets'
        end
      end    

    get '/login' do
        if logged_in?
            redirect to '/tweets'
        else
            erb :'users/login'
        end
    end

    post '/login' do
        user = User.find_by(username: params[username])
        if user && user.authenticate(params[:password])
            sessioin[:user_id] = user.id
            redirect to '/tweets'
        else
            redirect to '/signup'
        end
    end
end
