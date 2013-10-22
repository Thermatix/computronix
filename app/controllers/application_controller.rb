require 'awesome_print'
class ApplicationController < ActionController::Base
  include NavGateHelpers
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :render_navigation, :sorted_cart
  before_filter :make_menu, :cart?


  def cart?
    redirect_to new_cart_path if !session[:cart]
  end


end
