class TweetsController < ApplicationController

	get '/tweets/new' do
		if session[:user_id]
			erb :'tweets/new'
		else
			redirect '/login'
		end
	end

	post '/tweets' do
		if !params.values.any?("")
			@tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
			redirect '/tweets/show'
		else
			redirect '/tweets/new'
		end
	end

	get '/tweets/:id' do
		if session[:user_id]
			@tweet = Tweet.find_by(user_id: session[:user_id])
			erb :'/tweets/show_tweet'
		else
			redirect '/login'
		end
	end

	get '/tweets/:id/edit' do
		if session[:user_id]
			@tweet = Tweet.find(params[:id])
			erb :'/tweets/edit_tweet'
		else
			redirect '/login'
		end
	end

	patch '/tweets/:id' do
		@tweet = Tweet.find(params[:id])
		if session[:user_id] && !params[:content].empty?
			@tweet.content = params[:content]
			@tweet.save
			redirect "/tweets/#{@tweet.id}"
		else
			redirect "/tweets/#{@tweet.id}/edit"
		end
	end

	delete '/tweets/:id' do
		if session[:user_id]
			@tweet = Tweet.find(params[:id])
			@tweet.delete
			redirect to '/tweets'
		else
			redirect '/login'
		end

	end



end
