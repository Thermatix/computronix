class SalesController < ApplicationController
  def cancel
  end

  def success
    @sale = Sale.find(params[:sale_id])
  end
end
