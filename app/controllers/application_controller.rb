require 'awesome_print'
class ApplicationController < ActionController::Base
  include NavGateHelpers
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :render_navigation
  before_filter :cart, :make_menu

  def cart
    session[:cart] ||= {products: [], quantity: []}
  end
end
