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

    erb :'/tweets/new'
    else
    redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content].empty? && params[:content] == ""
        redirect "/tweets/new"
    else
        @tweet = current_user.tweets.create(:content => params[:content])
        redirect "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit_tweet'
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.update(content: params[:content])
    @tweet.save

    redirect "/tweets/#{@tweet.id}"
  end




  delete '/tweets/:id/delete' do
      if logged_in?
          @tweet = Tweet.find_by_id(params[:id])
          if @tweet.user_id == current_user.id
              @tweet.destroy
              redirect '/tweets'
          else
              redirect '/tweets'
          end
      else
          redirect '/login'
      end
  end

end
