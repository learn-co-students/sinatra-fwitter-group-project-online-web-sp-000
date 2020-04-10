class TweetsController < ApplicationController

	get "/tweets" do
		if session[:user_id]
			@user = User.find(session[:user_id])
			@users = User.all
			erb :"tweets/index"
		else
			redirect "/login"
		end
	end

	get "/tweets/new" do
		if session[:user_id]
			@user = User.find(session[:user_id])
			erb :"tweets/new"
		else
			redirect "/login"
		end
	end

	post "/tweets" do
		if params[:content].empty?
			redirect "/tweets/new"
		end

		user = Helpers.current_user(session)
		tweet = Tweet.create(content: params[:content])
		user.tweets << tweet

		redirect "/tweets/#{tweet.id}"
	end

	get "/tweets/:id" do
		if Helpers.is_logged_in?(session)
			@tweet = Tweet.find(params[:id])
			erb :"tweets/show"
		else
			redirect "/login"
		end
	end

	get "/tweets/:id/edit" do
		redirect "/login" if Helpers.is_logged_in?(session) == false		

		@tweet = Tweet.find(params[:id])

		if Helpers.is_logged_in?(session) && @tweet.user_id == Helpers.current_user(session).id
			erb :"tweets/edit"
		end
	end

	patch "/tweets/:id" do
		tweet = Tweet.find(params[:id])

		if params[:content].empty?
			redirect "/tweets/#{tweet.id}/edit"
		end

		tweet.update(content: params[:content])
		redirect "/tweets/#{tweet.id}"
	end

	delete "/tweets/:id/delete" do
		tweet = Tweet.find(params[:id])
		if tweet.user_id == Helpers.current_user(session).id
			tweet.destroy
			redirect "/tweets"
		end
		redirect "/login"
	end
end
