class UsersController < ApplicationController


  get '/signup' do
	redirect to '/tweets' if is_logged_in?(session)
  	erb :'/users/create_user'
  end

  get '/login' do 
  	redirect to '/tweets' if is_logged_in?(session)
    erb :'users/login'
  end

  get '/logout' do
    if is_logged_in?(session)
      session.clear
    end
    redirect to '/login' if !is_logged_in?(session)
    
  	
  end 

  post '/signup' do

    #PROBLEM WITH SIGNUP. ROUTE DOES NOT TAKE USER TO TWEETS PAGE. ROUTE RETURNS TO SIGNUP PAGE AFTER PERSISTING TO DB

    if User.find_by(username: params[:username]) 
      redirect "/signup", flash[:error] = "User account already exists please sign up for a new account"

    else   
  	  user = User.new(username: params[:username], email: params[:email], password: params[:password])
   	
      if user.save
     	  session[:user_id] = user.id

     	  redirect to '/tweets'
     	else
     	  signup_error(user)
     	end
    end
end

  post '/login' do
   	user = User.find_by(username: params[:username])
     	if user && user.authenticate(params[:password])
     	  session[:user_id] = user.id
     	  current_user(session)
     	  redirect to '/tweets'
     	else
     	  redirect to '/login', flash[:error] = "Username or password is incorrect. Please enter or sign up for a new account"
     	end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug]) 
    erb :'/users/show'
  end

end
