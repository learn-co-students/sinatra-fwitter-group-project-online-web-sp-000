class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
    redirect '/login'
    end
    @tweets = Tweet.all
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do 
    if !logged_in?
      redirect '/login'
    else
    erb :'/tweets/create_tweet' 
  end 
end


 
  post '/tweets' do
    redirect '/login' if !logged_in?
    #binding.pry
    @tweet = current_user.tweets.create(params)
    if @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    redirect '/login' if !logged_in?
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show'
  end
   

  get '/tweets/:id/edit' do
    redirect '/login' if !logged_in?
    @tweet = Tweet.find(params[:id])
    redirect '/tweets' if @tweet.user != current_user
    erb :'/tweets/edit'
  end

  patch '/tweets/:id' do 

    redirect '/login' if !logged_in?
    #binding.pry
    if params[:content] == "" 
      redirect "/tweets/#{params[:id]}/edit"
    end 
    
    @tweet = Tweet.find(params[:id])
    @tweet.content = params[:content]

    @tweet.save 
    redirect "/tweets/#{params[:id]}"
  end 

  delete '/tweets/:id/delete' do
    tweet = current_user.tweets.find_by(id: params[:id])
    if tweet && tweet.destroy
      redirect '/tweets'
    else
      redirect "/tweets/#{ params[:id] }"
    end
  end



  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    redirect "/" if @tweet.user != current_user
    redirect "/tweets/#{@tweet.id}/edit" if params[:tweet][:content].empty?
    @tweet.content = params[:tweet][:content]
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end
end