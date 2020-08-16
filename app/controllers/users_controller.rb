class UsersController < ApplicationController

  get "/logout" do
    if logged_in?
      #erb :logout
      session.clear
      redirect "/login"      
		else
			redirect "/"
		end  
  end
  
  #post "/logout" do
	#	session.clear
	#	redirect "/login"
  #end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show' 
      end 
end
