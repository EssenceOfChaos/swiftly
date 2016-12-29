module Current
  thread_mattr_accessor :user
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  around_filter :user_time_zone, if: :current_user
  around_filter :set_current_user

helper_method :current_user, :logged_in?, :authorize, :require_user

  def set_current_user
    Current.user = current_user
    yield
  ensure
    # to address the thread variable leak issues in Puma/Thin webserver
    Current.user = nil
  end

  private
  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end

end
