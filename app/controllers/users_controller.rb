class UsersController < ApplicationController
  get '/signup' do
    if !Helpers.is_logged_in?(session)
      erb :'users/signup'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    if params[:username]=="" || params[:email]=="" || params[:password]==""
      redirect '/signup'

    else
      @user=User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id]=@user.id
      redirect '/tweets'
   end
  end

get '/login' do
  if !Helpers.is_logged_in?(session)
    erb :'users/login'
  else
    redirect to '/tweets'
  end

end

post '/login' do
  @user=User.find_by(username: params[:username])
  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect '/tweets'
  else
    redirect '/login'
  end
end

get '/logout' do
  if Helpers.is_logged_in?(session)
    session.clear
    redirect to '/login'
  else
    redirect to '/login'
  end
end


 end
