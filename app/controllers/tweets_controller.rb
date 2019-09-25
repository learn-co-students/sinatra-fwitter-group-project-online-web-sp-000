class TweetsController < ApplicationController

   get '/tweets' do
     if !logged_in?
       redirect to "/login"
     else
       @user = User.find(session[:user_id])
       erb :'/tweets/tweets'
     end
   end

   get '/tweets/new' do
     if !logged_in?
       redirect to "/login"
     else
       erb :'/tweets/new'
     end
   end

  post '/tweets' do
    if params[:content] !=""
      @user = User.find(session[:user_id])
      @user.tweets << Tweet.create(content: params[:content])

      redirect "/tweets"
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect to "/login"
    else
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/show"
    end
  end


  get '/tweets/:id/edit' do
    if !logged_in?
      redirect to "/login"
    else
      @tweet = Tweet.find(params[:id])

      erb :'/tweets/edit'
    end
  end

  patch "/tweets/:id" do
    tweet = Tweet.find(params[:id])
    if params[:content] != ""
      tweet.update(content: params[:content])
      tweet.save
      redirect "/tweets/#{tweet.id}"
    else
      redirect "/tweets/#{tweet.id}/edit"
    end
  end

  delete "/tweets/:id" do
    tweet = Tweet.find_by(params[:id])
    if tweet.user_id == session[:user_id]

      tweet.delete


      redirect '/tweets'
    else
      redirect "/tweets/#{tweet.id}"
    end
  end



end
