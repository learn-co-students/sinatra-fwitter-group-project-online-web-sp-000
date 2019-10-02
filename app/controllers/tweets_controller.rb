class TweetsController < ApplicationController

  get "/tweets" do 
    if logged_in?
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end
  
  get "tweets/:id" do 
    if logged_in? 
      @tweet = Tweet.find(params[:id]) 
      erb :"/tweets/show"
    else 
      redirect "login" 
    end 
  end 
  
  post "/tweets" do 
    if logged_in? 
    @tweet = current_user.tweets.new(content: params[:content])
      if @tweet.save 
        redirect "/tweets/#{@tweet.id}"
      else 
        redirect "/tweets/new" 
      end
    else
      redirect "/login" 
    end
  end
  
  
  

end
