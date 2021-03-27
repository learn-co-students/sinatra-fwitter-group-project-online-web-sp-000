class TweetsController < ApplicationController
  
  get '/tweets' do
   # @user = User.find(session[:user_id])
   #binding.pry
   @tweets= Tweet.all
   @user = Helpers.current_user(session)
    erb :'tweets/tweets'
    
  end

  get '/tweets/new' do
    erb :'tweets/new'
  end

  post '/tweets' do
    @user= Helpers.current_user(session)
    if !params[:content].empty?
      @tweet = Tweet.new(:content => params[:content])
      @tweet.user = @user
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      #flash[:message] ="Your tweet must includee content."
      erb :'tweets/new'
    end
  end

  get '/tweets/:id/edit' do
    #binding.pry
    @user= Helpers.current_user(session)
    @tweet= @user.tweets.find(params[:id])
    erb :'tweets/edit_tweet'
  end

  get '/tweets/:id' do
    @user = Helpers.current_user(session)
    @tweet= @user.tweets.find(params[:id])
    erb :'tweets/show_tweet'
  end

  patch '/tweets/:id' do
    @user= Helpers.current_user(session)
    @tweet= @user.tweets.find(params[:id])
    if !params[:content].empty?
      @tweet.content = params[:content]
      @tweet.save
    end
    redirect to "/tweets/#{@tweet.id}"
  end      

  delete '/tweets/:id' do
    @user = Helpers.current_user(session)
    @tweet= @user.tweets.find(params[:id])
    @tweet.destroy
    redirect to "/tweets"
  end


end
