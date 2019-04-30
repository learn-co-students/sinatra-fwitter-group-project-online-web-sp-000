require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    enable :sessions
    set :session_secret, "fdsakl;fja343qrejdjasklfjasl;fase23423qrljsdflk;asdjfkl;asjrio3w;rjdfsan"
    set :views, 'app/views'
  end

  get "/" do
    erb :index
  end

end
