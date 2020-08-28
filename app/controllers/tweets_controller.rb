class TweetsController < ApplicationController
  get '/tweets/new' do
     erb :'tweets/new'
  end

  post "/tweets" do  
    if !params[:content].empty?
       @user = User.find_by(id: session[:user_id])
       @tweet =  Tweet.create(content: params[:content])
       @user.tweets << @tweet
        erb :"tweets/tweets"
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id/edit' do
    if session[:user_id] != nil
      @tweet = Tweet.find_by(id: params[:id])
       erb :'tweets/edit_tweet'
   else
     redirect '/login'
   end
  end


  patch '/Tweets/:id' do
  @tweet = Tweet.find_by(id: params[:id])
    if !params[:content].empty?
    @tweet.content = params[:content]
    @tweet.save
    redirect '/tweets'
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
    
  end





  get '/tweets/:id' do 
    if session[:user_id] != nil
       @user = User.find_by(id: session[:user_id])
       @tweet = Tweet.find_by(id: params[:id])
       erb :'tweets/my_tweets'
    else
      redirect 'login'
    end
  end

delete '/tweets/:id' do 
   user = User.find_by(id:session[:user_id])    
  @tweet = Tweet.find_by_id(params[:id])
  if user.tweets.include?(@tweet)
     @tweet.delete
  end
     redirect to '/tweets'
end

end

