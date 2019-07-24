class UsersController < ApplicationController

<<<<<<< HEAD
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
=======
  get "/signup" do
    erb :'/users/create_user'
  end

  post "/signup" do
	@user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])

	  if @user.save && @user[:username] != ""
	    erb :"/tweets/tweets"
>>>>>>> e5ccc3bc27a27f292f6cdff83150df1b7d5595a6
    end
  end




<<<<<<< HEAD
  get "/login" do
    if logged_in?
      redirect '/tweets'
    else
        erb :index
    end
  end

  post "/login" do
    user1 = User.find_by(:username => params[:username])
#binding.pry
    if user1 && user1.authenticate(params[:password])
      session[:user_id] = user1.id
    #  redirect "/account"
#    else
#      redirect "/failure"
    end
    @user = User.find(session[:user_id])
    redirect '/tweets'
  end



  get "/logout" do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect "/"
    end
  end
  #    elsif !logged_in? &&
  #      redirect "/"
  #    elsif !logged_in?
  #      redirect '/login'
=======


  get "/login" do
    erb :'/users/login'
  end

  post "/login" do
#    user = User.find_by(:username => params[:username])

#    if user && user.authenticate(params[:password])
#      session[:user_id] = user.id
#      redirect "/account"
#    else
#      redirect "/failure"
#    end
  end


>>>>>>> e5ccc3bc27a27f292f6cdff83150df1b7d5595a6

end
