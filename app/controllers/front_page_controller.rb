require 'paypal-sdk-rest'
class FrontPageController < ApplicationController
  include PayPal::SDK::REST

  def index
    @category = Category.find(params[:category_id]) if params[:category_id]
    @currency = params[:currency]|| :GBP
    if params[:product_id] && params[:quantity]
      id = params[:product_id]
      quan = params[:quantity]
      if !session[:cart][:products].include?(id)
        session[:cart][:products].push(params[:product_id])
        session[:cart][:quantity].push(params[:quantity])
      else
        i = session[:cart][:products].index(id)
        session[:cart][:quantity][i] +=
      end
    end
  end


end
