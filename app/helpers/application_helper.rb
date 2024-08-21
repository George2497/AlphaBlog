module ApplicationHelper

  def gravatar_for(user,options = {size: 80})
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size] # Ensure the size from options is used
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "rounded shadow mx-auto d-block")
  end

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

end
