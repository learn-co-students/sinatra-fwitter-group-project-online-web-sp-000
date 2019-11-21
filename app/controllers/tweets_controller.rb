class TweetsController < ApplicationController

    get '/tweets' do
        @tweets=Tweet.all
        if Helpers.is_logged_in?(session)
            @user=User.find_by_id(session[:user_id])
        erb :'tweets/index'
        else
            redirect to "/login"
        end
    end

    get '/tweets/new' do
        if Helpers.is_logged_in?(session)
        erb :"tweets/new"
        else 
        redirect to "/login"
        end
    end

    post "/tweets" do
        @user=User.find_by_id(session[:user_id])
        if params[:content]==""
            redirect to '/tweets/new'
        else
            @user.tweets << Tweet.new(content: params[:content])
        redirect to "/users/#{@user.slug}"      
        end
    end

    get "/tweets/:id" do
        if Helpers.is_logged_in?(session)
        @tweet=Tweet.find_by_id(params[:id])
        erb :"tweets/show"
        else redirect to "/login"
        end
    end

    delete  "/tweets/:id" do
        @tweet=Tweet.find_by_id(params[:id])
        if Helpers.is_logged_in?(session) && @tweet.user_id==session[:user_id]
        @tweet.destroy
        redirect to "/tweets"
        else
            redirect to '/login'
        end
    end

    post "/tweets/:id/edit" do
        if Helpers.is_logged_in?(session)
        @tweet=Tweet.find_by_id(params[:id])
        erb :"tweets/edit" 
        else redirect to "/login"  
        end 
    end

    get "/tweets/:id/edit" do
        if Helpers.is_logged_in?(session)
        @tweet=Tweet.find_by_id(params[:id])
        erb :"tweets/edit" 
        else redirect to "/login"  
        end 
    end

    patch  "/tweets/:id" do
        @tweet=Tweet.find_by_id(params[:id])
        if params[:content]==""
            redirect to "/tweets/#{@tweet.id}/edit"
        else
        @tweet.content=params[:content]
        @tweet.save
    redirect to '/tweets' 
        end
    end

end
