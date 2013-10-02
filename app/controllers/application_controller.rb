require 'awesome_print'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  helper_method :logged_in?, :current_user, :admin?

  protect_from_forgery with: :exception

  before_filter :protect
  def protect

    if Rails.env.production?
      authenticate_or_request_with_http_basic do |username, password|
        username == "ppdev" && password == "paxeword"
      end
    end
  end
end
