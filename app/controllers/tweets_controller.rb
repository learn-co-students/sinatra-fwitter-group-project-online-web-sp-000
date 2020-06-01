class TweetsController < ApplicationController
	get '/tweets' do
		# binding.pry
		@tweets = Tweet.all
		if logged_in?
			erb :'tweets/tweets'
		else
			redirect :'/login'
		end
	end

	get '/tweets/new' do
		if logged_in?
			erb :'tweets/new'	
		else
			redirect :'/login'
		end
		
	end

	post '/tweets' do
		# binding.pry
		tweet = Tweet.new(params[:tweet])
		tweet.user = current_user
		if tweet.save
			redirect '/tweets'
		else
			redirect '/tweets/new'
		end
	end

	get "/tweets/:id" do
		@tweet = Tweet.find(params[:id])
		if logged_in?
			erb :'tweets/show'
		else
			redirect '/login'
		end
	end

	delete "/tweets/:id" do
		redirect :'/login' if !logged_in?
		tweet = Tweet.find(params[:id])
		# binding.pry
		if tweet && tweet.user == current_user
      tweet.delete
    end
		redirect :'/tweets'
	end

	get "/tweets/:id/edit" do
		if logged_in?
			@tweet = Tweet.find(params[:id])
			erb :'tweets/edit'
		else
			redirect '/login'
		end
	end

	patch "/tweets/:id" do
		tweet = Tweet.find(params[:id])
		if tweet.update(content: params[:content])
			redirect "/tweets/#{params[:id]}"
		else
			redirect "/tweets/#{params[:id]}/edit"
		end
	end

end
