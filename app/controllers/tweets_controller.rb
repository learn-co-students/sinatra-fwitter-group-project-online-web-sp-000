class TweetsController < ApplicationController
  
  get "/tweets" do
    if Helpers.logged_in?(session) == true
      @user = Helpers.current_user(session)
      erb :'/tweets/index'
    else
      redirect "/login"
    end
  end
  
  get "/tweets/new" do
    if Helpers.logged_in?(session) == true
      @user = Helpers.current_user(session)
      erb :'/tweets/new'
    else
      redirect "/login"
    end
  end
  
  post "/tweets" do
    if params[:content].empty? == false
      @tweet = Tweet.create(content: params[:content])
      @user = Helpers.current_user(session)
      @user.tweets << @tweet
    else
      redirect "/tweets/new"
    end
  end
  
  get "/tweets/:id" do
    if Helpers.logged_in?(session) == true
      @user = Helpers.current_user(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show'
    else
      redirect "/login"
    end
  end
  
  get "/tweets/:id/edit" do
     if Helpers.logged_in?(session) == true
        @tweet = Tweet.find_by_id(params[:id])
        erb :'/tweets/edit'
    else
      redirect "/login"
    end
  end
    
  patch "/tweets/:id/edit" do
    @tweet =Tweet.find_by_id(params[:id])
    if params[:content].empty?
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    end
  end
  
  delete "/tweets/:id" do
    @tweet = Tweet.find_by_id(params[:id])
    if session[:user_id] == @tweet.user_id
      @tweet.delete
    end
  end
    
  
end
