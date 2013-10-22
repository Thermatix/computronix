require 'awesome_print'
class ApplicationController < ActionController::Base
  include NavGateHelpers
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :render_navigation, :currency, :curr_convert, :cart, :cur_format
  before_filter :make_menu, :cart?




  def currency
    @currency ||= session[:currency]|| :GBP
  end

  def curr_convert value,currency
    Money.default_bank = Money::Bank::GoogleCurrency.new
    temp = value.to_money(:GBP)
    temp.exchange_to(currency)
    temp
  end
  def cur_format value
    "#{'%.2f' % curr_convert(value,currency) }"
  end

  def cart
    @cart ||= session[:cart]
  end
  def cart?
    redirect_to new_cart_path if !session[:cart]
  end



end
