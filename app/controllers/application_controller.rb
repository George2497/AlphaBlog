class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?

  def current_user
    # If we have current_user then return the @current_user instance variable
    # if we do not have the current_user then do the query to find the user
    # and to then return them
    # This is done by using ||= If true, use the value on the left, else use the value on the right
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user # Makes current_user a boolean to see if they're logged in or not by using !! (Double bang)
  end

  def require_user
    if !logged_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end

end
