class TweetsController < ApplicationController

	get '/tweets' do
		@tweets = Tweet.all
		if !logged_in?
			redirect '/login'
		else
			erb :'tweets/index'
		end
	end

	# => create
	get '/tweets/new' do
		if !logged_in?
			redirect '/login'
		else
			erb :'tweets/new'
		end
	end

	post '/tweets' do
		if params[:content].empty?
			redirect '/tweets/new'
		else
			@tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
			redirect "/tweets/#{@tweet.id}"
		end
	end

	# => read
	get '/tweets/:id' do
		if !logged_in?
			redirect '/login'
		else
			@tweet = Tweet.find(params[:id])
			erb :'tweets/show'
		end
	end

	# => update
	get '/tweets/:id/edit' do
		# @tweet = Tweet.find(params[:id])
		#
		# if logged_in? && @tweet.user_id == session[:user_id]
		# 	erb :'tweets/edit_tweet'
		# else
		# 	redirect '/login'
		# end
		if !logged_in?
			redirect '/login'
		else
			@tweet = Tweet.find(params[:id])
			erb :'tweets/edit_tweet' if @tweet.user_id == session[:user_id]
		end
	end

	patch '/tweets/:id' do

		if params[:content].empty?
			redirect "/tweets/#{params[:id]}/edit"
		else
			@tweet = Tweet.find(params[:id])
			@tweet.update(content: params[:content])
			redirect "/tweets/#{@tweet.id}"
		end
	end

	# => delete
	delete '/tweets/:id' do
		@tweet = Tweet.find(params[:id])

		if logged_in? && @tweet.user_id == session[:user_id]
			@tweet.destroy
		else
			redirect '/login'
		end
	end

end
