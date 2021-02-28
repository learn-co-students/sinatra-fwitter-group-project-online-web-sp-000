class UsersController < ApplicationController

    get '/signup' do
        if !!logged_in?
            redirect'/tweets' 
        else
            erb :"/users/create_user"
        end
    end

    post '/signup' do
        if params.values.include?("")
            redirect'/signup'
        else
            user = User.create(params)
            session[:user_id] = user.id
            redirect "/tweets"
        end
    end

    get '/login' do
        if !logged_in?
            erb :"/users/login"
        else
            redirect '/tweets'
        end
    end

    post '/login' do
        user = User.find_by_slug(params[:username].parameterize)
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/tweets'
        else
            redirect '/login'
        end
    end

    get '/logout' do
        if !!logged_in?
            session.clear
            redirect '/login'
            #erb :"/users/logout" ###using this page & post/logout doesn't make sense for the tests....
        else
            redirect '/'
        end
    end

    #post '/logout' do
    #    session.clear
    #    redirect '/login'
    #end

    get '/users/:user_slug' do
        @user = current_user
        erb :"/users/show"
    end

end
