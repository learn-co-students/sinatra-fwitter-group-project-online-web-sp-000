require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :sessions_secret, "secret"
  end

  get '/' do
    erb :index
  end

  helpers do 

    def logged_in?
      !!current_user
    end

    def current_user
       User.find_by(id: session[:user_id])
    end
  end

  #def slug
   # stripped_name = self.name.downcase.split(/[.+ ]/)
    
    #slug_name = stripped_name.join("-")

    #slug_name
  #end

  #def find_by_slug(slug)
  #  self.all.find{|song| song.slug == slug}
  #end
  
end
