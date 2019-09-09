class TweetsController < ApplicationController

get '/tweets' do
  if Helpers.is_logged_in?(session)
    erb :'tweets/tweets'
  else
    redirect '/login'
  end
end

get '/tweets/new' do
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
    erb :'tweets/show_tweet'
  end
end

# get '/tweets/:id/edit' do
#   if Helpers.is_logged_in?(session)
#     @tweet = Tweet.find(params[:id])
#     if @tweet &&  @tweet.user == Helpers.current_user?(session)
#     erb :"/tweets/edit_tweet"
#   else
#     flash[:wrong_user_edit] = "You could only edit your own tweets"
#     redirect to "/tweets"
#   end
#   else
#     redirect to "/login"
#   end
# end









get '/tweets/:id/edit' do
  #binding.pry
  @tweet = Tweet.find(params[:id])
  if !Helpers.is_logged_in?(session)
    redirect to '/login'
  elsif Helpers.current_user(session).id != @tweet.user_id
    flash[:wrong_user_edit] = "You could only edit your own tweets"
    redirect to '/tweets'
  else
  @tweet = Tweet.find(params[:id])
  erb :"tweets/edit_tweet"
  end
end

patch '/tweets/:id' do
tweet = Tweet.find(params[:id])
if params["content"].empty?
  flash[:empty_tweet] = 'Enter content for tweet'
  redirect to "/tweets/#{params[:id]}/edit"
end
tweet.update(:content => params["content"])
tweet.save
redirect to "/tweets/#{tweet.id}"
end

post '/tweets/:id/delete' do
if Helpers.is_logged_in?(session)
  redirect to '/login'
end
@tweet = Tweet.find(params[:id])
if Helpers.current_user(session).id != @tweet.user_id
  flash[:wrong_user] = "You could only delete your own tweets"
  redirect to '/tweets'
end
@tweet.delete
redirect to '/tweets'
end



end
