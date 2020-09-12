class UsersController < ApplicationController

get '/signup' do
    erb :'users/create_user'
end

post '/signup' do
    #binding.pry
    # if user is not logged in, cannot view page
    if params[:email].empty? || params[:username].empty? ||params[:password].empty?
        redirect to '/signup'
    end
    User.create(email: params[:email], username: params[:username], password: params[:password])
    redirect to '/tweets'
end

get '/login' do
    erb :'users/login'
end

post '/login' do
    binding.pry
    @user = User.find_by(:username => params[:username])
    
    if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        @user = @user
        redirect to '/tweets'
    else
        redirect to '/login'
    end  
end

get '/logout' do
    session.clear
    redirect '/'
end

end