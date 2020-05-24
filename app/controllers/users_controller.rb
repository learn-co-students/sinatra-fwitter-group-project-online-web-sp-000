# frozen_string_literal: true

class UsersController < ApplicationController
  get '/signup' do
    return erb :'users/sign_up' unless logged_in?

    redirect to '/tweets'
  end

  post '/signup' do
    begin
      @user = User.create!(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    rescue StandardError
      redirect to '/signup'
    end
  end

  get '/login' do
    return erb :'users/login' unless logged_in?

    redirect to '/tweets'
  end

  post '/login' do
    @user = User.find_by_username(params[:username])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
    redirect to '/signup'
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    end
    redirect to '/'
  end

  get '/users/:slug' do
    @user = User&.find_by_slug(params[:slug])
    erb :'users/user_page'
  end
  end
