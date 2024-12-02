class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user, :user_signed_in?

  # Redirect to login if the user is not signed in
  def authenticate_user!
    unless user_signed_in?
      redirect_to new_session_path, alert: "You must be logged in to do that."
    end
  end

  # Authorize Admin users
  def authorize_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end

  # Authorize Moderator users
  def authorize_moderator!
    unless current_user&.moderator?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end

  # Get the current signed-in user, either from session or cookies (for "Remember me?")
  def current_user
    @current_user ||= session[:user_id] ? User.find_by(id: session[:user_id]) : authenticate_user_from_cookie
  end

  # Check if a user is signed in
  def user_signed_in?
    current_user.present?
  end

  # Log the user in and set the session
  def login(user)
    Current.user = user
    reset_session
    session[:user_id] = user.id
  end

  # Log the user out
  def logout(user)
    Current.user = nil
    reset_session
  end

  private

  # Authenticate user from persistent cookies (for "Remember me?")
  def authenticate_user_from_cookie
    if cookies.signed[:user_id]
      user = User.find_by(id: cookies.signed[:user_id])
      if user
        session[:user_id] = user.id
        user
      end
    end
  end
end
