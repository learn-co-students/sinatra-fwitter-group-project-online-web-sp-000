class TweetsController < ApplicationController

 get '/tweets' do
   if !is_logged_in?(session)
      redirect to '/login'
    end
    @tweets = Tweet.all
    @user = current_user(session)
   erb :'tweets/tweets'
 end

 get '/tweets/new' do
    if !is_logged_in?(session)
      redirect to '/login'
    end
    erb :"/tweets/new"
  end

  post '/tweets' do
    user = current_user(session)
    if params["content"].empty?
      redirect to '/tweets/new'
    end
    tweet = Tweet.create(:content => params["content"], :user_id => user.id)

    redirect to '/tweets'
  end

  get '/tweets/:id' do
    if !is_logged_in?(session)
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    erb :"tweets/show_tweet"
  end

  get '/tweets/:id/edit' do
    if !is_logged_in?(session)
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    if current_user(session).id != @tweet.user_id
      redirect to '/tweets'
    end
    erb :"tweets/edit_tweet"
  end

  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if params["content"].empty?
      redirect to "/tweets/#{params[:id]}/edit"
    end
    tweet.update(:content => params["content"])
    tweet.save

    redirect to "/tweets/#{tweet.id}"
  end

  post '/tweets/:id/delete' do
    if !is_logged_in?(session)
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    if current_user(session).id != @tweet.user_id
      redirect to '/tweets'
    end
    @tweet.delete
    redirect to '/tweets'
  end


end
