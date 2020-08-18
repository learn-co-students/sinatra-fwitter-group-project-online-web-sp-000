class TweetsController < ApplicationController

  get '/tweets' do
    
    if logged_in
      
      @tweets = Tweet.all
      binding.pry
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end


  get '/tweets/new' do
    if logged_in
      erb :'tweets/new'
    else 
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in
      if params[:content] == ""
        redirect '/tweets/new'
      else
        @tweet = current_user.tweets.create(content: params[:content])
        if @tweet.save
          redirect '/tweets/#{@tweet.id}'
        else
          redirect '/tweets/new'
        end
      end
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show'
    else
      redirect to '/login'
    end
  end

  


end
