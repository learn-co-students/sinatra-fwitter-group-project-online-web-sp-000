class TweetsController < ApplicationController

    enable :sessions 

    get '/tweets' do 
        if logged_in? 
            @user = User.find(session[:user_id])
            @tweets = Tweet.all
            erb :"tweets/index"
        else
            redirect to "/login"
        end
    end

    get "/tweets/new" do 
        if logged_in?
            erb :"tweets/new"
        else 
            redirect :"/login"
        end
    end

    post "/tweets" do 
        if logged_in? 
            if !params[:content].empty?
                @tweet = Tweet.new(content: params[:content])
                @user = current_user
                @user.tweets << @tweet 
                @user.save
                redirect to "users/#{@user.slug}"
            else 
                redirect to "/tweets/new"
            end
        end
    end

    get "/tweets/:id" do 
        @tweet = Tweet.find_by(id: params[:id])
        erb :"tweets/show"
    end

    get "/tweets/:id/edit" do 
        
        if logged_in? 
            @tweet = Tweet.find_by(id: params[:id])
            erb :"tweets/edit"
        else 
            redirect to "/login"
        end
    end
     
    patch "/tweets/:id/edit" do 
        @tweet = Tweet.find_by(id: params[:id])
        if params[:content].empty? 
            redirect to "/tweets/#{@tweet.id}/edit"
        else
            @tweet.content = params[:content]
            @tweet.save
        
            redirect to "/tweets/#{@tweet.id}"
        end
    end

    get "/tweets/:id/delete" do 
        if logged_in?
            @tweet = Tweet.find_by(id: params[:id])
            if current_user == @tweet.user
                @tweet.destroy 
                redirect to "/tweets"
            end
        else 
            redirect to "/login"
        end
    end

end
