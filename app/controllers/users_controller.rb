class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/signup'
      end
    end

    post '/signup' do
      if params[:username] == "" || params[:email] == "" || params[:password] == ""
        redirect to 'users/signup'
      else
        @user = User.create(params)
        session[:id] = @user.id
        redirect to '/tweets'
      end
    end

    get '/login' do
       if !logged_in?
         erb :'users/login'
       else
         redirect to '/tweets'
       end
     end

     post '/login' do
       @user = User.find_by(username: params[:username])
       if @user && @user.authenticate(params[:password])
         session[:id] = @user.id
         redirect to "/tweets"
       else
         redirect to '/signup'
       end
     end

     get '/logout' do
       if logged_in?
         session.destroy
         redirect to '/users/login'
       else
         redirect to '/index'
      end
     end

end
