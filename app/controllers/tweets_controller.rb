class TweetsController < ApplicationController

  get '/tweets' do
  	redirect to '/login' if !is_logged_in?(session)
  	@user = current_user(session)
  	@tweets = Tweet.all
  	erb :'/tweets/index'
  end

  get '/tweets/:id/edit' do
  	redirect '/login' if !is_logged_in?(session)
  	@tweet = Tweet.find(params[:id])
  	@user = User.find_by(id: current_user(session).id)
  	if @tweet.user == current_user(session) && is_logged_in?(session)
  	  erb :'/tweets/edit_tweets'
  	else	
  	  redirect to '/login'
  	end	
  end

  get '/tweets/new' do
  	redirect '/login' if !is_logged_in?(session)
  	erb :'/tweets/new'
  end

  get '/tweets/:id' do
  	redirect '/login' if !is_logged_in?(session)
  	@tweet = Tweet.find_by(id: params[:id])
  	erb :'tweets/show'
  end

  post '/tweets' do
  	redirect '/tweets/new', flash[:error]="Content field cannot be blank" if params[:user][:content].empty? 
  	user = current_user(session)
  	tweet = Tweet.create(title: params[:title], content: params[:user][:content])
  	user.tweets << tweet
  	redirect to "/tweets/#{tweet.id}"
  end

  patch '/tweets/:id' do

    @tweet = Tweet.find_by(id: params[:id])

    if !params[:content].empty?
      @tweet.update(:content => params[:content])
      @tweet.save
      redirect "tweets/#{@tweet.id}"
    else
      redirect "tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by(id: params[:id])
  	if @tweet.user == current_user(session) && is_logged_in?(session)
  	  @tweet.delete
  	else	
  	  redirect to '/login'
  	end	
    
    redirect to '/tweets'
  end
end
