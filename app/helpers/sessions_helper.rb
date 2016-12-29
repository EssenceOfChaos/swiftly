module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user || User.find(session[:user_id]) if session[:user_id]
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

    def log_out
      session.delete(:user_id)
      @current_user = nil
    end

  def authorize
  redirect_to '/login' unless current_user
end

def require_user
  if !logged_in?
    flash[:error] = "You must be logged in to perform that action."
  end

end

end
