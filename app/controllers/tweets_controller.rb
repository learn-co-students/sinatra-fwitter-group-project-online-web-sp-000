class TweetsController < ApplicationController

  #action to display all tweets
  get '/tweets' do
    # binding.pry
    if is_logged_in?(session)
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  #action to display new tweet form
  get '/tweets/new' do
    if is_logged_in?(session)
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  #action to create a new tweet
  post '/tweets' do
    @user = current_user(session)
    if !params[:content].empty?
      @user.tweets << Tweet.create(params)
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  #action to display a single tweet
  get '/tweets/:id' do
    if is_logged_in?(session)
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  #action to display edit form
  get '/tweets/:id/edit' do
    if is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      if @tweet.user == current_user(session)
        erb :'tweets/edit_tweet'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  #action to edit a single tweet
   patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if is_logged_in?(session) && params[:content] == ""
      redirect ("/tweets/#{@tweet.id}/edit")
    elsif is_logged_in?(session) && @tweet.user == current_user(session)
      @tweet.update(content: params[:content])
      redirect ("/tweets/#{@tweet.id}")
    else
      redirect '/login'
      end
    end

  # #action to delete a tweet
  post '/tweets/:id/delete' do
     @tweet = Tweet.find(params[:id])
     if is_logged_in?(session) && current_user(session) == @tweet.user
       @tweet.destroy
       redirect '/tweets'
     else
       redirect '/tweets'
     end
   end

end
