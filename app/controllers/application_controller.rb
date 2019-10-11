require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end
  
  get '/' do
    erb :layout
  end

  helpers do
    
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user = User.find(session[:user_id]) if session[:user_id]
    end

  end
    get '/tweets' do
      if logged_in?
        @tweets = Tweet.all
        erb :'tweets/tweets'
      else
        redirect to '/login'
      end
    end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/signup' do
    if !logged_in?
      erb :'users/create_user', locals: {message: "Please sign up before you sign in"}
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  ############################################################################
  
    get '/tweets/new' do
      if logged_in?
        erb :'tweets/new'
      else
        redirect to '/login'
      end
    end
  
    post '/tweets' do
      if logged_in?
        if params[:content] == ""
          redirect to "/tweets/new"
        else
          @tweet = current_user.tweets.build(content: params[:content])
          if @tweet.save
            redirect to "/tweets/#{@tweet.id}"
          else
            redirect to "/tweets/new"
          end
        end
      else
        redirect to '/login'
      end
    end
  
    get '/tweets/:id' do
      if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        erb :'tweets/show_tweet'
      else
        redirect to '/login'
      end
    end
  
    get '/tweets/:id/edit' do
      if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
          erb :'tweets/edit_tweet'
        else
          redirect to '/tweets'
        end
      else
        redirect to '/login'
      end
    end
  
    patch '/tweets/:id' do
      if logged_in?
        if params[:content] == ""
          redirect to "/tweets/#{params[:id]}/edit"
        else
          @tweet = Tweet.find_by_id(params[:id])
          if @tweet && @tweet.user == current_user
            if @tweet.update(content: params[:content])
              redirect to "/tweets/#{@tweet.id}"
            else
              redirect to "/tweets/#{@tweet.id}/edit"
            end
          else
            redirect to '/tweets'
          end
        end
      else
        redirect to '/login'
      end
    end
  
    delete '/tweets/:id/delete' do
      if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
          @tweet.delete
        end
        redirect to '/tweets'
      else
        redirect to '/login'
      end
    end
end
