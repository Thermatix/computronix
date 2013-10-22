class CartsController < ApplicationController
  skip_before_filter :cart?, only: [:new]

  def index
  end

  def update
    if params[:cart]
      cart =[]
      product_ids = params[:product_id]
      quant = params[:quantity].each {|q| q = q.to_i}
      product_ids.each_with_index do |id,i|
        cart.push({id:id, quantity: quant[i]})
      end
    else
      cart = session[:cart]
      quantity = params[:quantity].to_i
      id = params[:product_id]
      add_to_cart = true
      cart.each do |product|
        if product[:id] == id
          product[:quantity] += quantity
          add_to_cart = false
        end
      end
      if add_to_cart
        cart.push({id: id,quantity: quantity})
      end
    end
    session[:cart] = cart
    redirect_to :back
  end

  def new
    session[:cart] = []
    redirect_to :root
  end

  def delete
  end

  private

end
