class TweetsController < ApplicationController

  get '/tweets' do 
    if !is_logged_in?
        redirect "/login"
    else 
        @tweets = Tweet.all
        erb :'/tweets/index'
    end 
  end

  get '/tweets/new' do 
      if !is_logged_in?
          redirect "/login"
      else 
          erb :'/tweets/new'
      end
  end

  post '/tweets' do 
      if !is_logged_in?
          redirect "/login"
      else 
          @tweet = Tweet.new(content: params[:content], user_id: current_user.id)
          if @tweet.content.length > 0 && @tweet.save
              redirect "/"
          end
      end 
  end

  get '/tweets/:id' do
      if !is_logged_in?
          redirect "/login"
      else
          @tweet = Tweet.find_by_id(params[:id])
          if @tweet
            erb :'/tweets/show'
          else
            redirect '/tweets'
          end 
      end 
  end

  get '/tweets/:id/edit' do 
      if !is_logged_in?
          redirect "/login"
      else
          @tweet = Tweet.find_by_id(params[:id])

          if @tweet && is_authorized?(@tweet)
            erb :'/tweets/edit'
          else 
            redirect "/"
          end
      end 
  end

  patch '/tweets/:id' do
      if !is_logged_in?
          redirect "/login"
      else 
          @user = current_user
          @tweet = Tweet.find_by_id(params[:id])
          @tweet.content = params[:new_tweet]
          @tweet.save
          redirect to "/tweets/#{@tweet.id}"
      end 
  end

  get '/tweets/:id/delete' do 
    if !is_logged_in?
      redirect "/login"
    else 
      erb :"/tweets/delete"
    end
  end

  delete '/tweets/:id/delete/' do
    if !is_logged_in?
      redirect "/login"
    else 
      @tweet = Tweet.find_by_id(params[:id])
      @user = current_user

      if @user.id == @tweet.user_id
          @tweet.delete
          redirect '/tweets'
      else 
          redirect '/'
      end 
    end 
  end
end