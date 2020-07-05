class TweetsController < ApplicationController

# CRUD

# CREATE
  get '/tweets/new' do
    # load the create tweet form
    # tweet should be created and saved to the database
    redirect_if_not_logged_in
    erb :'tweets/new'
  end

  post '/tweets' do
    # process the form submission to create a new tweet
    if params[:content] == ""
      puts "ERROR: Post creation failure, please DO NOT submit blank tweet!"
      redirect to '/tweets/new'
    else
      @tweet = Tweet.create(content: params[:content])
      @tweet.user_id = current_user.id
      @tweet.save
      redirect to '/tweets'
    end
  end

# READ
  get '/tweets' do
    # tweets index page
    # display all tweets for logged in user and other users
    # if a user is not logged in, redirect to '/login'
      redirect_if_not_logged_in
      @tweets = Tweet.all
      erb :'tweets/tweets'
  end

# UPDATE
  get '/tweets/:id/edit' do
    redirect_if_not_logged_in
    find_tweet
    if authorized_to_edit?(@tweet)
      erb :'tweets/edit_tweet'
    else
      puts "ERROR: NOT authorized to edit this tweet!"
      redirect '/tweets/#{@tweet.id}'
    end
  end

  patch '/tweets/:id' do
    find_tweet
    @tweet.update(content: params[:content])
    redirect '/tweets/#{@tweet.id}'
  end




  get '/tweets/:id' do
    # displays the information for a single tweet
      redirect_if_not_logged_in
      find_tweet
      erb :'tweets/show_tweet'
  end


  def find_tweet
    @tweet = Tweet.find(params[:id])
  end
end
