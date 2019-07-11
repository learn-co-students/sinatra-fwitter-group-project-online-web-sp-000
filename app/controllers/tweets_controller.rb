
class TweetsController < ApplicationController

  get '/tweets/new' do

    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end

    erb :"/tweets/new"

  end

  post '/tweets' do

    user = Helpers.current_user(session)

    if params["content"].empty?
      redirect to '/tweets/new'
    end

    tweet = Tweet.create(:content => params["content"], :user_id => user.id)

    redirect to '/tweets'

  end

  get '/tweets' do

    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end

    @tweets = Tweet.all
    @user = Helpers.current_user(session)

    erb :'/tweets/tweets'

  end

  get '/tweets/:id' do

    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end

    @tweet = Tweet.find(params[:id])
    erb :"tweets/show"

  end

  get '/tweets/:id/edit' do

    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end

    @tweet = Tweet.find(params[:id])

    if Helpers.current_user(session).id != @tweet.user_id
      redirect to '/tweets'
    end

    erb :"tweets/edit"

  end

  patch '/tweets/:id' do

    tweet = Tweet.find(params[:id])

    if params["content"].empty?

      redirect to "/tweets/#{params[:id]}/edit"

    end

    tweet.update(:content => params["content"])

    tweet.save

    redirect to "/tweets/#{tweet.id}"

  end

  post '/tweets/:id/delete' do

    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end

    @tweet = Tweet.find(params[:id])

    if Helpers.current_user(session).id != @tweet.user_id
      redirect to '/tweets'
    end

    @tweet.delete

    redirect to '/tweets'

  end

end
