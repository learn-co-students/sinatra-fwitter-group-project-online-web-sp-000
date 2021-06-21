require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

end
<h1>Login to Fwitter!</h1>
<form method="post" action="/login">
  <input type="text" name="username" placeholder="Username:">
  <input type="text" name="password" placeholder="Password:">

  <input type="submit" value="submit">
</form>
