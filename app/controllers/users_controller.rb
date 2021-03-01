class UsersController < ApplicationController

    get '/user/:slug' do  #slugs user for show page 
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end

    get '/signup' do  #displays user signup page 

    end

    post '/signup' do  # processes user signup and submits -- signup should log in user and add user_id to sessions hash

    end

    get '/login' do  #form to login 

    end

    post '/login' do #processes and submits user login 

    end

    get '/logout' do  #clears sesion hash,logs out and redirects to login


end
