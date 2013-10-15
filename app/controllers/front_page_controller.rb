
class FrontPageController < ApplicationController

  def index
    @category = Category.find(params[:category_id]) if params[:category_id]
    @currency = params[:currency]|| :GBP
  end


end
