class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect to '/login'
    else
      @user=current_user
      @tweets=Tweet.all
      erb :'/tweets/index'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      user=User.find_by(session[:user_id])
      tweet=Tweet.create(:content => params[:content])
      user.tweets << tweet
      user.save
      redirect to "/tweets/#{tweet.id}"
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/new' do
    if !logged_in?
      redirect to '/login'
    end
    erb :'/tweets/new'
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect to '/login'
    end
    @tweet=Tweet.find(params[:id])
    erb :'/tweets/show'
  end

  get '/tweets/:id/edit' do
    @tweet=Tweet.where("user_id = ? AND id = ?", session[:user_id], params[:id]).first
    if !logged_in?
      redirect to '/login'
    elsif !@tweet
      redirect to "/tweets/#{params[:id]}"
    else
      erb :'tweets/edit'
    end

  end

  delete '/tweets/:id/delete' do
    @tweet=Tweet.where("user_id = ? AND id = ?", session[:user_id], params[:id]).first
    if !logged_in?
      redirect to '/login'
    elsif !@tweet
      redirect to "/tweets/#{params[:id]}"
    else
      @tweet.delete
    end
  end

  patch '/tweets/:id' do
    if !params[:content].empty?
      tweet=Tweet.find(params[:id])
      tweet.update(:content => params[:content])
      redirect to "/tweets/#{params[:id]}"
    else
      redirect to "/tweets/#{params[:id]}/edit"
    end
  end



end
