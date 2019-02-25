class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
    erb :'/tweets/tweets'
     else
       redirect '/login'
   end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"/tweets/new"
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in? && params[:content] != ""

      @tweet = current_user.tweets.build(content: params[:content])
      @tweet.save

     redirect "/tweets/#{@tweet.id}"

   elsif logged_in? && params[:content] == ""
    redirect '/tweets/new'

   else
    redirect '/login'
  end
end

  get '/tweets/:id' do
    if logged_in?
    @tweet = Tweet.find(params[:id])

    erb :'/tweets/show_tweet'
    else
      redirect '/login'
   end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/edit_tweet"
    else
     redirect '/login'
   end
  end

  patch '/tweets/:id' do

    @tweet = Tweet.find(params[:id])

    if logged_in? && params[:content] != ""
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"

    else logged_in? && params[:content] == ""
       redirect "/tweets/#{@tweet.id}/edit"
    end
  end

end
