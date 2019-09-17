class TweetsController < ApplicationController
    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            @user = current_user
            erb :"tweets/index"
        else
            redirect '/login'
        end
    end

    get '/tweets/new' do
        if logged_in?
            erb :"/tweets/new"
        else
            redirect '/login'
        end
    end

    post '/tweets' do
        if params[:content] != ""
            @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
            redirect "/tweets/#{@tweet.id}"
        else
            redirect '/tweets/new'
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find_by(id: params[:id])
            @user = User.find_by(id: @tweet.user_id)
            erb :"/tweets/show"
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find_by(id: params[:id])
            @user = User.find_by(id: @tweet.user_id)
            if @user == current_user
                erb :"/tweets/edit"
            else
                redirect '/tweets'
            end
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do
        
        @tweet = Tweet.find_by(id: params[:id])
        if params[:content] != ""
            @tweet.content = params[:content]
            @tweet.save

            redirect "/tweets/#{@tweet.id}"
        else
            redirect "/tweets/#{@tweet.id}/edit"
        end
    end

    delete '/tweets/:id/delete' do
        if logged_in?
          @tweet = Tweet.find_by(id: params[:id])
          if @tweet && @tweet.user == current_user
            @tweet.delete
          end
          redirect to '/tweets'
        else
          redirect to '/login'
        end
      end

end
