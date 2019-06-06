class TweetsController < ApplicationController

  get '/tweets' do

    if !logged_in?(session)
      redirect "/login"
    end
    @user = current_user(session)
    @tweets = Tweet.all
    # binding.pry
    erb :'/tweets/index'
  end

  get '/tweets/new' do
    if !logged_in?(session)
      redirect "/login"
    end
  erb :'/tweets/new'
  end

  get '/tweets/:id' do
    if !logged_in?(session)
      redirect '/login'
    end

    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/show'
  end

  get '/tweets/:id/edit' do
    if !logged_in?(session)
      redirect '/login'
    end
  @tweet = Tweet.find_by_id(params[:id])
  erb :'tweets/edit'
  end

  post '/tweets' do
    if !logged_in?(session)
      redirect '/login'
    end

    if !params[:content].empty?
    @tweet = Tweet.create(:content => params[:content])
    @tweet.user_id = current_user(session).id
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
    else
    redirect "/tweets/new"
    end
  end

  patch '/tweets/:id' do
    if !logged_in?(session)
      redirect '/login'
    end
    @tweet = Tweet.find_by_id(params[:id])
    if !params[:content].empty?
      @tweet.update(:content => params[:content])
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  get '/tweets/:id/delete' do

  end 
end
