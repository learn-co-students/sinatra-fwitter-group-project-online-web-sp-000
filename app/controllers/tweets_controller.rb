class TweetsController < ApplicationController
  get '/tweets' do
    if is_logged_in?(session)
      @user = User.find(session[:user_id])
      erb :"/tweets/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if is_logged_in?(session)
      erb :'/tweets/new'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect "/tweets/new"
    else
      tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
      redirect "/tweets"
    end
  end

  get '/tweets/:id' do
    if is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  post '/tweets/:id' do
    redirect "/tweets/#{params[:id]}/edit" if params[:content].empty?

     Tweet.update(params[:id], content: params[:content])
    redirect "/tweets/#{params[:id]}"
  end

  get '/tweets/:id/edit' do
     if is_logged_in?(session)
       @tweet = Tweet.find(params[:id])
       erb :"/tweets/edit_tweet"
     else
       redirect "/login"
     end
  end

  post '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
     if tweet.user_id != session[:user_id]
      redirect "/tweets/#{params[:id]}"
    else
      tweet.delete
      redirect "/tweets"
    end
  end

end
