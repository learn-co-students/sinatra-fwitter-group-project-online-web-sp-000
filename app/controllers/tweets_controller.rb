class TweetsController < ApplicationController

  get '/tweets' do
    if !Helpers.logged_in?(session)
      redirect '/login'
    end
    @tweets = Tweet.all
    @user = Helpers.current_user(session)
    erb :'/tweets/tweets'
  end

  # shows all tweets from a single user
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/tweets/new' do
    if !Helpers.logged_in?(session)
      flash[:message] = "You Must Be Logged in to Make Tweets"
      redirect '/login'
    end
      erb :'tweets/new'
  end

  # The tweet should be created and saved to the database
  post '/tweets' do
    if !params[:content].empty?
      Tweet.create(content: params[:content], user_id: session[:user_id])
      redirect '/tweets'
    else
      flash[:error] = "Please enter a tweet"
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if !Helpers.logged_in?(session)
      flash[:message] = "You Must Be Logged in to View Tweets"
      redirect '/login'
    else
      @tweet = Tweet.find_by(params[:id])
      erb :'/tweets/show_tweet'
    end
  end

  get '/tweets/:id/edit' do
    if !Helpers.logged_in?(session)
      flash[:message] = "You Must Be Logged in to Edit Tweets"
      redirect '/login'
    else
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    end
  end

  # lets a user edit their own tweet if they are logged in
  # does not let a user edit a text with blank content
  post '/tweets/:id' do
    @tweet = Tweet.find_by(params[:user_id])
    if !params[:content].empty?
      @tweet.update(content: params[:content])
      redirect "tweets/#{@tweet.id}"
    else
      flash[:message] = "Please fill in the text field to Tweet"
      redirect "tweets/#{@tweet.id}/edit"
    end
  end

  # lets a user delete their own tweet if they are logged in
  # does not let a user delete a tweet they did not create
  post '/tweets/:id/delete' do
    @tweet = Tweet.find_by(params[:user_id])
    if !Helpers.logged_in?(session)
      flash[:message] = "Log in to your account to delete Tweets"
      redirect '/login'
    else
      @tweet.delete
      redirect '/tweets'
    end
  end


end
