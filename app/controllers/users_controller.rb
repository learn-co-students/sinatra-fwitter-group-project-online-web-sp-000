class UsersController < ApplicationController

  get '/signup' do
      if !logged_in?
          erb :'/users/create_user'
      else
          redirect '/tweets'
      end
  end

  post "/signup" do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
        redirect "/signup"
    else
        @user = User.create(params)
        session[:user_id] = @user.id
        redirect "/tweets"
      end
  end


  post "/signup" do
	@user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])

	  if @user.save && @user[:username] != ""
	    erb :"/tweets/tweets"
    end
  end




  get "/login" do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post "/login" do
    user1 = User.find_by(:username => params[:username])
    if user1 && user1.authenticate(params[:password])
      session[:user_id] = user1.id
      redirect "/tweets"
    else
    redirect "/signup"
    end
  end



  get "/logout" do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect "/"
    end
  end




  get '/users/:id' do
      @user = User.all.find_by_id(params[:id])
      erb :'/users/show'
  end

end
