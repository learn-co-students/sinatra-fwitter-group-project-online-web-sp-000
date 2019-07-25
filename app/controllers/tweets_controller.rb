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
    if logged_in?
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show_tweet'
    else
    redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet.user_id == current_user.id
            erb :'/tweets/edit_tweet'
        else
            redirect "/tweets"
        end
    else
        redirect "/login"
    end
  end

  patch '/tweets/:id' do
    if params[:content].empty?
        redirect "/tweets/#{params[:id]}/edit"
    else
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.update(:content => params[:content])
        redirect "/tweets/#{@tweet.id}"
    end
  end




  get '/tweets/:id/edit' do
    if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet.user_id == current_user.id
            erb :'/tweets/delete_tweet'
        else
            redirect "/tweets"
        end
    else
        redirect "/login"
    end
  end


  delete '/tweets/:id' do
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
