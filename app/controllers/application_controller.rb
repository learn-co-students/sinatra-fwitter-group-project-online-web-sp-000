require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end


  get '/' do
    if session[:id]
      redirect "/home"
    else
      erb :"index"
    end
  end

# HOME PAGE
  get '/home' do
    begin
      @user = User.find(current_user)
    rescue
      redirect "/"
    end
    # @user = User.where(id: params[:id]).first
    erb(:homepage)
  end

# CREATE NEW USER
  # #register new user
  # get '/users/new' do
  #   #signup form erb
  # end

  # post '/users' do
  #   #redirect to /users/:id/home
  # end
  #^^restful route

  # get '/signup' do
  #   erb :"index"
  # end

  post '/signup' do
    @user = User.new(
      username: params[:username],
      password: params[:password],
      bio:      params[:bio],
      photo_url: params[:photo_url],
      first_name: params[:first_name],
      last_name: params[:last_name],
      )
    if @user.save
      status 200
      session[:id] = @user.id
      # redirect "/users/#{params[:id]}"
      redirect "/home"
    else
      status 400
      redirect "/"
    end
  end

# USER INDEX
  get '/users' do
    @users = User.all
    @top_ten = @users
            .sort_by {|user| user.followers.count}
            .reverse!
            .first(10)
    erb :'users/index'
  end

# DIRECT TO PROFILE
  # THROUGH USER ID
  get '/users/:id' do
    @user = User.where(id: params[:id]).first
    if @user
      #show user profile
      erb :'users/profile'
    else
      status 404
      @error = "User does not exist"
      erb :'error'
    end
  end

# EDIT PROFILE
  # EDIT FORM
  get '/users/:id/edit' do
    @user = User.where(id: params[:id]).first
    erb :'users/edit'
  end

  # SUBMIT FORM
  put '/users/:id' do
    user = User.where(id: params[:id]).first
    user.first_name = params[:first_name]
    user.last_name = params[:last_name]
    user.username = params[:username]
    user.password = params[:password]
    user.photo_url = params[:photo_url]
    user.bio = params[:bio]
    if user.save
      status 200
      redirect "/#{user.username}"
    else
      status 400
      erb :"users/edit"
    end
  end

  # DELETE PROFILE
  delete '/users/:id' do
    user = User.where(id: params[:id]).first
    user.destroy
    session[:id] = nil
    redirect '/'
  end

# LOGIN
  post '/login' do
    @user = User.where(username: params[:username]).first
    if @user && @user.password == params[:password]
      session[:id] = @user.id
      redirect "/home"
    else
      status 400
      redirect "/"
    end
  end

# LOGOUT
  delete '/login' do
    session[:id] = nil
    redirect "/"
  end

# FOLLOW
  post '/users/:id/relationships' do
    User.find(params[:id]).followers << User.find(current_user)
    redirect "/users/#{params[:id]}"
  end

# UNFOLLOW
  delete '/users/:id/relationships' do
    User.find(params[:id]).followers.delete(User.find(current_user))
    redirect "/users/#{params[:id]}"
  end

# INDEX OF USER TWEETS
  get '/users/:id/tweets' do
    #tweet index erb
  end

# CREATE NEW TWEET
  post '/users/:id/tweets' do
    @tweet = Tweet.new(
      text: params[:tweet]
    )
    User.find(params[:id]).tweets << @tweet
    redirect "/users/#{params[:id]}"
  end

# DISPLAY SINGLE TWEET
  get '/tweets/:id' do
    #display a single tweet & its attributes
  end
end 

# DELETE TWEET
  delete '/tweets/:id' do
    @tweet = Tweet.where(id: params[:id]).first
    if current_user == @tweet.user.id && @tweet.destroy
      redirect('/home')
    else
      redirect('/')
    end
  end

  post '/likes/:id' do
    @tweet = Tweet.where(id: params[:id]).first
    @user = User.where(id: current_user).first
    if @tweet.likers << @user
      redirect("/#{@tweet.user.username}")
    else
      redirect('/')
    end
  end

  delete '/likes/:id' do
    @tweet = Tweet.where(id: params[:id]).first
    @user = User.where(id: current_user).first
    if @tweet.likers.delete(@user)
      redirect("/#{@tweet.user.username}")
    else
      redirect('/')
    end
  end

  get '/search' do
    @search_result = Tweet.where("tweets.text like ?", "%#{params[:q]}%").includes(:user)
    if @search_result.empty?
      p "No results"
    else
      erb :"users/search"
    end
  end


# THROUGH USERNAME
  get '/:username' do
    @user = User.where(username: params[:username]).first
    if @user
      erb :'users/profile'
    else
      status 404
      @error = "User does not exist"
      erb :'error'
    end
  end

end
