class TweetsController < ApplicationController
  configure do
    enable :sessions
    set :session_secret, "password_security"
  end
  
  get '/tweets' do
    if session[:user_id]
      @user = User.find(session[:user_id])
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/new' do
    if session[:user_id]
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/:id' do
    if session[:user_id]
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/:id/edit' do
    if session[:user_id]
      @tweet = Tweet.find(params[:id])
      
      if @tweet.user_id == session[:user_id]
       erb :'tweets/edit'
     else
       redirect "/tweets/#{@tweet.id}"
     end
     
    else
      redirect '/login'
    end
  end
  
  post '/tweets' do
    if params[:content] == ""
      redirect '/tweets/new'
    else
      user = User.find(session[:user_id])
      tweet = Tweet.create(content: params[:content], user_id: user.id)
      redirect "/tweets/#{tweet.id}"
    end
  end
  
  
  patch '/tweets/:id' do
    if params[:content] == ""
      redirect "/tweets/#{params[:id]}/edit"
    else
      tweet = Tweet.find(params[:id])
      tweet.update(content: params[:content])
      tweet.save
      redirect "/tweets/#{tweet.id}"
    end
  end
  
  delete '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if session[:user_id] == tweet.user_id 
      tweet.destroy
      redirect "/tweets"
    else
      redirect "/tweets/#{params[:id]}"
    end
  end
  

end
