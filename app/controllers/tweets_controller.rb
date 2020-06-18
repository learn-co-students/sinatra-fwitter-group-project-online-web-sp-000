class TweetsController < ApplicationController
<<<<<<< HEAD
=======

>>>>>>> 6265492469202805c30fcd2243607474289ef005
    get '/tweets' do
      if logged_in?
        @tweets = Tweet.all
        erb :'tweets/tweets'
      else
        redirect to '/login'
      end
    end
<<<<<<< HEAD
=======

>>>>>>> 6265492469202805c30fcd2243607474289ef005
    get '/tweets/new' do
      if logged_in?
        erb :'/tweets/new'
      else
        redirect to '/login'
      end
    end
<<<<<<< HEAD
=======

>>>>>>> 6265492469202805c30fcd2243607474289ef005
    post '/tweets' do
      @tweet = Tweet.create(:content => params[:content])
      redirect to "/tweets/#{@tweet.id}"
    end
<<<<<<< HEAD
=======

>>>>>>> 6265492469202805c30fcd2243607474289ef005
    get '/tweets/:id' do
     if logged_in?
       @tweet = Tweet.find_by_id(params[:id])
       erb :'tweets/show_tweet'
     else
       redirect to '/login'
     end
   end
<<<<<<< HEAD
=======

>>>>>>> 6265492469202805c30fcd2243607474289ef005
    get '/tweets/:id/edit' do
        @tweet = Tweet.find_by_id(params[:id])
        @user = User.find_by(params[:id])
        if logged_in? && @tweet.user_id == @user.id
            erb :'/tweets/edit_tweet'
<<<<<<< HEAD
        else
          redirect '/tweets'
        end
    end
=======
        else 
            redirect '/tweets'
        end 
    end

>>>>>>> 6265492469202805c30fcd2243607474289ef005
    patch '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.content = params[:content]
        @tweet.save
        redirect to "/tweets/#{@tweet.id}"
    end
<<<<<<< HEAD
=======

>>>>>>> 6265492469202805c30fcd2243607474289ef005
    delete '/tweets/:id/delete' do
        @tweet = Tweet.find_by_id(params[:id])
        @user = User.find_by_id(params[:id])
        if logged_in? && @tweet.user_id == @user.id
            @tweet.destroy
            redirect to "/tweets"
<<<<<<< HEAD
        else
            redirect '/login'
        end
   end
end
=======
        else 
            redirect '/login'
        end
            #erb :show
   end
end  
>>>>>>> 6265492469202805c30fcd2243607474289ef005
