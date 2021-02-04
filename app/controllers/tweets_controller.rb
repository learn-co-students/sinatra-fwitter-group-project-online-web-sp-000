require 'rack-flash'

class TweetsController < ApplicationController
  use Rack::Flash
  # tweets index page
  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect to '/login'
    end
  end

  # new tweet form if logged in
  get '/tweets/new' do
    if logged_in?
      erb :"tweets/new"
    else
      redirect to '/login'
    end
  end

  # if logged in  and params not empty, build new tweet and redirect to the new tweet page
  post '/tweets' do
    if logged_in?
      if params[:content] == ""
        redirect to "/tweets/new"
      else
        @tweet = current_user.tweets.build(content: params[:content])
        if @tweet.save
          flash[:message] = "Successfully created Tweet!"
          redirect to "/tweets/#{@tweet.id}"
        else
          redirect to "/tweets/new"
        end
      end
    else
      redirect to '/login'
    end
  end

  # displays show page for single tweet
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/show'
    else
      redirect to '/login'
    end
  end

   # Allows a user to edit their own tweet (and ONLY their own) if they're logged in.
  # Redirects the user to /tweets if they try to edit someone else's tweet (or if they try to edit a nonexistent tweet).
  # Redirects the user to the login page if they're logged out.
  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet && @tweet.user == current_user
        erb :'tweets/edit'
      else 
        flash[:error] = "You can only edit your own tweet!"
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end
  
  # if logged in and params not empty, find the tweet by id
  # if tweet.user is current_user update tweet and redirect to the updated tweet page
  patch '/tweets/:id' do
    if logged_in?
      if params[:content] == ""
        redirect to "/tweets/#{params[:id]}/edit"
      else
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
          if @tweet.update(content: params[:content])
            flash[:message] = "Successfully updated Tweet!"
            redirect to "/tweets/#{@tweet.id}"
          else
            redirect to "/tweets/#{@tweet.id}/edit"
          end
        else # not current user
          redirect to '/tweets'
        end
      end
    else # user not logged in
      redirect to '/login'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.delete
      end
      flash[:message] = "Successfully deleted Tweet!"
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end
  
end

    

  



