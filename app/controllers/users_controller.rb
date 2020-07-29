class UsersController < ApplicationController


  get '/signup' do
    if !logged_in
      erb :'/users/signup'
    else 
      redirect '/tweets'
    end
  end


  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""

       redirect '/signup'
    else
       @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
       @user.save
       session[:user_id] = @user.id
       redirect '/tweets'
     end
  end



  get '/login' do
    # if logged_in 
    #   redirect '/tweets'
    # else
    #   erb :'/users/login'
    if !logged_in
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end




  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect to '/signup'
    end
  end


  # get '/logout' do
  #   if logged_in
  #     session.destroy
  #     redirect '/login'
  #   else
  #     redirect '/'
  #   end
  # end

  # get '/users/:slug' do
  #   @users = User.find_by_slug(params[:slug])
  #   erb :'users/show'
  # end


end
