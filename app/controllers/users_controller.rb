class UsersController < ApplicationController
  get('/users/:slug') { @user = current_user; erb :'users/show' }
end
