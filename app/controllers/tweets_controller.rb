class TweetsController < ApplicationController

	get '/tweets' do
		if logged_in?
			@user = current_user
			@tweets = Tweet.all
			erb :'/tweets/index'
		else
			redirect 'login'
		end
	end
	
	post '/tweets' do
		redirect '/login' if !logged_in?
		@tweet = Tweet.new(content: params[:content])
		if @tweet.content != ""
			@user = current_user
			@user.tweets << @tweet
			redirect '/tweets'
		else
			redirect '/tweets/new'
		end
	end

	get '/tweets/new' do
		if !logged_in? || !current_user
			redirect '/login' 
		end
		erb :'/tweets/new'
	end

	get '/tweets/:id' do
		redirect '/login' if !logged_in?
		@tweet = Tweet.find_by_id(params[:id])
		erb :'tweets/show'
	end

	patch '/tweets/:id' do
		@tweet = Tweet.find(params[:id])
		if @tweet.user != current_user
			redirect '/'
		elsif params[:content].empty?
			redirect "/tweets/#{@tweet.id}/edit"
		else
			@tweet.update(content: params["content"])
			@tweet.save
			redirect "/tweets/#{@tweet.id}"
		end
	end

	get '/tweets/:id/edit' do
		redirect '/login' if !logged_in?
		@tweet = Tweet.find(params[:id])
		redirect '/tweets' if @tweet.user != current_user
		erb :'/tweets/edit'
	end

	delete '/tweets/:id/delete' do
		redirect '/login' if !logged_in?
		@tweet = Tweet.find(params[:id])
		@tweet.delete if current_user == @tweet.user
		redirect '/tweets'
	end

end
