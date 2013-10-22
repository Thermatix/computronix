require 'paypal-sdk-rest'
class FrontPageController < ApplicationController
  include PayPal::SDK::REST

  def index
    @category = Category.find(params[:category_id]) if params[:category_id]
    @currency = params[:currency]|| :GBP
  end


end
