class TweetsController < ApplicationController

  get '/tweets' do

    if !logged_in?
        redirect '/login'
    end    

    @user = current_user
    @tweets = Tweet.all
    erb :'/tweets/index'
  end

  get '/tweets/new' do
    if logged_in?
        erb :'/tweets/new'
    else
        redirect '/login'
    end
  end

  post '/tweets' do
    user = current_user
    if params[:content].empty?
        "Please enter content for your tweet"
        redirect '/tweets/new'
    else
        tweet = Tweet.create(:content => params[:content], :user_id => user.id)
    end

    redirect to '/tweets'
  end

  get '/tweets/:id' do
    if logged_in?
        @tweet = Tweet.find_by(params[:id])
        erb :'/tweets/show'
    else
        redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
        @tweet = Tweet.find_by(params[:id])
        erb :'/tweets/edit'
    else
        redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    if logged_in?
        if params[:content] == ""
            redirect "/tweets/#{params[:id]}/edit"
        else
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet && @tweet.user == current_user
                if @tweet.update(content: params[:content])
                    redirect "/tweets/#{@tweet.id}"
                else
                    redirect "/tweets/#{@tweet.id}/edit"
                end
            else
                redirect to '/tweets'
            end
        end
    else
        redirect '/login'
    end
  end
        
  delete '/tweets/:id' do
    if logged_in?
        @tweet = Tweet.find_by(params[:id])
        @tweet.delete
        redirect to '/tweets'
    else
        redirect to '/login'
    end
  end


end
