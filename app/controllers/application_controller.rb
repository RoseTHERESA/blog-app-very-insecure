class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  #this one was too easy to find. UNCOMMENTED THE FOLLWING LINE
  protect_from_forgery with: :exception

  def confirm_logged_in
    unless session[:user_id] and current_user
      redirect_to login_path, alert: "Please log in"
    end
  end

  def prevent_login_signup
    if session[:user_id]
      redirect_to :back, notice: "You are already logged in"
    end
  end

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find_by_id(session[:user_id])
  end

  def login_user(user)
    if user.persisted?
      session[:user_id] = user.id
      session[:password] = user.password
    end
  end

  def authenticate(user, password)
    if password.eql?(user.password)
      true
    else
      false
    end
  end

  helper_method :current_user
end
