class TweetsController < ApplicationController

  get '/tweets/new' do
    if !Helpers.is_logged_in?(session)
      redirect '/login'
    end
    erb :'/tweets/new'
  end

  get '/tweets'do
    if Helpers.is_logged_in?(session)
      @tweets=Tweet.all
      @user=Helpers.current_user(session)
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    if !Helpers.is_logged_in?(session)
     redirect to '/login'
    end
   @tweet = Tweet.find(params[:id])
   erb :"tweets/show_tweet"
  end

  get '/tweets/:id/edit' do
    if !Helpers.is_logged_in?(session)
      redirect '/login'
    end
    @tweet=Tweet.all.find(params[:id])
    erb :'/tweets/edit'
  end

  get '/users/:slug' do
    @user=User.find_by_slug(params[:slug])

    erb :'tweets/show'
  end

  delete '/tweets/:id/delete' do
    if !Helpers.is_logged_in?(session)
      redirect '/login'
    end

    @tweet = Tweet.find_by_id(params[:id])
    if Helpers.current_user(session).id != @tweet.user_id
      redirect to '/tweets'
    end
    @tweet.delete
    redirect to '/tweets'
  end

  post '/tweets' do
    @user=User.find(session[:user_id])
    if params[:content] !=""
      @user.tweets<< Tweet.create(content: params[:content])
    else
      redirect to 'tweets/new'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content] !=""
      @tweet.content=params[:content]
      @tweet.save
    else
      redirect to "/tweets/#{params[:id]}/edit"
    end
    redirect to "/tweets/#{@tweet.id}"
  end

end
