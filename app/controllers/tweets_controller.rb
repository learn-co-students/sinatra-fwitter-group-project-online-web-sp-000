class TweetsController < ApplicationController



  #-----Create-----
  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect '/tweets/new'
    else
      Tweet.create(params).tap do |tweet|
        tweet.user = current_user
        tweet.save
      end
      redirect '/tweets'
    end
  end

  #-----Read-----

  get '/tweets' do
    if logged_in?
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  #-----Update-----

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:tweet][:content].empty?
      redirect "/tweets/#{params[:id]}/edit"
    else
      tweet = Tweet.find(params[:id])
      tweet.update(params[:tweet])
      redirect "/tweets/#{tweet.id}"
    end
  end

  #----Delete-----

  delete '/tweets/:id' do
    if logged_in?
      tweet = Tweet.find(params[:id])
      tweet.destroy if current_user == tweet.user
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

end
