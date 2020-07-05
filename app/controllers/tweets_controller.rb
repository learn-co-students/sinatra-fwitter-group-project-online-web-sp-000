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
      puts "Post creation failure, please submit tweet again"
    else
      @tweet = Tweet.create(content: params[:content])
      redirect to '/tweets'
    end
  end



  get '/tweets' do
    # tweets index page
    # display all tweets for logged in user and other users
    # if a user is not logged in, redirect to '/login'
      redirect_if_not_logged_in
      @tweets = Tweet.all
      erb :'tweets/tweets'
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
