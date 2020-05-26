class TweetsController < ApplicationController

    get '/tweets' do
        if !logged_in?
            redirect '/login'
        else
        @tweets = Tweet.all
        erb :'tweets/tweets'
        end
    end

    get '/tweets/new' do
        if !logged_in?
            redirect '/login'
        else
            erb :'/tweets/new'
        end
    end

    post '/tweets' do
        if params[:content] == "" || current_user.id != session[:user_id]
            redirect to "/tweets/new"
        else
            @tweet = Tweet.create(content: params[:content], user_id: @current_user.id)
            redirect "/tweets/#{@tweet.id}"
        end
    end

    get '/tweets/:id' do
        if !logged_in?
            redirect '/login'
        end
        @tweet = Tweet.find(params[:id])
        erb :'/tweets/show'
    end

    get "/tweets/:id/edit" do
        @tweet = Tweet.find(params[:id])
        erb :'/tweets/edit'
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        binding.pry
        if logged_in?
            if @tweet.user == current_user
                @tweet.update(content: params[:content])
                redirect "/tweets/#{@tweet.id}"
            else
                redirect "/tweets/#{@tweet.id}/edit"
            end
        else
            redirect '/login'
        end
    end

    delete '/tweets/:id/delete' do
        if logged_in?
          @tweet = Tweet.find_by_id(params[:id])
          if @tweet && @tweet.user == current_user
            @tweet.destroy
          end
          redirect to '/tweets'
        else
          redirect to '/login'
        end
      end
end


=begin
class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    #check to see if the user is logged in or not
    if logged_in?
      #if the user is logged in then check to see if the content is empty
      if params[:content] == ""
        #if the content is empty then redirect to the new page
        redirect "/tweets/new"
      else
        #if the content is not empty then save the tweet
        @tweet = current_user.tweets.build(content: params[:content])
        if @tweet.save
          redirect to "/tweets/#{@tweet.id}"
        else
          redirect to "/tweets/new"
        end
      end
    else
      #if the user is not logged in then send them to the login page
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show'
    else
      redirect :'/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        erb :'/tweets/edit'
      else
        erb :'/tweets'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    #check to see if user is logged in or not
    if logged_in?
      #check to see if content is empty or not
      if params[:content] == ""
        #if the content is empty then redirect to the edit page again
        redirect "/tweets/#{params[:id]}/edit"
      else
        #if the content is not empty then check to see if the tweet's user is a valid user
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
          #if the user is a valid user then check to see if it can update or not
          if @tweet.update(content: params[:content])
            #if the tweet is updated then send to the id page to show it
            redirect "/tweets/#{@tweet.id}"
          else
            #if the update is not possible then send back to edit page
            redirect "/tweets/#{@tweet.id}/edit"
          end
        else
            #if the user can't be updated then send to the tweets page
            redirect '/tweets'
        end
      end
    else
      #if the user is not logged in then send to the login page
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet =  Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.delete
      else
        redirect '/tweets'
      end
    else
        redirect '/login'
    end
  end

end
=end
