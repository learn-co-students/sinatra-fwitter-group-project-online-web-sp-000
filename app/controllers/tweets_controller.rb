class TweetController < ApplicationController

  # Index Action
  get '/tweets' do
    if session[:id] 
      @user = User.find(session[:id])
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end
  
  # New Action
  get '/tweets/new' do
    if session[:id] 
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end
  
  # Create Action
  post '/tweets' do
    content = params['content']
    if content.empty?
      session[:flash] = "Please enter some content for your tweet."
      redirect '/tweets/new'
    else 
      tweet = Tweet.create(content: content)
      tweet.user = User.find(session[:id])
      tweet.save
      redirect "tweets/#{tweet.id}"
    end
  end
  
  # Show Action
  get '/tweets/:id' do
    if session[:id]
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end      
  end
  
  # Edit Action
  get '/tweets/:id/edit' do
    if !session[:id]
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      if session[:id] != @tweet.user.id 
        session[:flash] = "You cannot edit another user's Tweet."
        redirect "/tweets/#{params[:id]}/-e"
      else 
        @users = User.all
        erb :'/tweets/edit_tweet'
      end
    end
  end
  
  # Patch Action
  patch '/tweets/:id' do
    if params['tweet']['content'].empty?
      session[:flash] = "Please enter some content for your tweet."
      redirect "/tweets/#{params[:id]}/edit"
    else 
      tweet = Tweet.find(params[:id])
      tweet.update(params['tweet'])
      tweet.save
      redirect "tweets/#{tweet.id}"
    end
  end
  
  # Delete Action
  delete '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if session[:id] != tweet.user.id 
      session[:flash] = "You cannot delete another user's Tweet."
      redirect "/tweets/#{params[:id]}"
    else 
      tweet.delete
      session[:flash] = "Your Tweet has been deleted."
      redirect "/tweets"
    end
  end
  
end