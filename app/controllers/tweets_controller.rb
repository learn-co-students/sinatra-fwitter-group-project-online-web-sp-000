class TweetsController < ApplicationController

get '/tweets' do
  if Helpers.is_logged_in?(session)
#binding.pry
    erb :'tweets/tweets'
  else
    redirect '/login'
  end
end

get '/tweets/new' do
  #binding.pry
  if Helpers.is_logged_in?(session)
    erb :'tweets/new'
  else
    redirect to '/login'
  end
end

post '/tweets' do
  user = Helpers.current_user(session)
  if params["content"].empty?
    flash[:empty_tweet] = "Fill in the Tweet"
    redirect to '/tweets/new'
  else
  tweet = Tweet.create(:content => params[:content], :user_id => user.id)
  redirect to '/tweets'
  end
end



get '/tweets/:id' do
  if !Helpers.is_logged_in?(session)
    redirect to '/login'
  else
    @tweet = Tweet.find(params[:id])
    redirect to '/tweets/show_tweet'
  end
end

get '/users/:slug' do
 @user = User.find_by(params[:slug])
end



end
