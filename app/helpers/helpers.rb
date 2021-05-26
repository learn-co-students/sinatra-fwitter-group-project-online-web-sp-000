class Helpers

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  end
end
