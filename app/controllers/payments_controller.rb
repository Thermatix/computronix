require 'paypal-sdk-rest'

class PaymentsController < ApplicationController

  include PayPal::SDK::REST

  def index
  end

  def new
    if params[:one_click_Buy]
      create
    else
      @payment = Payment.new
    end
  end

  def create
    #what we want to see
    sale = Sale::Generator.new(params[:product_id] || session[:product_ids]).generate
    session[:sale_id] = sale.id
    redirect_to sale.redirect_url

    if params[:one_click_Buy]
      #Move to sale::generator
      @product = Product.find(params[:one_click_Buy])
      @payment = Payment.new @product.one_click_buy
      @sale = ::Sale.new
      @sale.products = @product
      @sale.save

    end
    #move to sale::generator
      if @payment.create
          redirect_url = @payment.links.find{|link| link.method == 'REDIRECT'}.href
          session[:payment_id] = @payment.id
          session[:sale_id] = @sale.id
          redirect_to redirect_url
      else
      redirect_to :front_page, params[:error] = "Youre payment was unable to be created"
    end
  end

  def execute
    @payment = Payment.find(session[:payment_id])
    if @payment.execute(payer_id: params[:PayerID])
      @sale = ::Sale.find(session[:sale_id])
      @sale.payment_xid = @payment.id
      @sale.save
      params[:sale_id] = @sale.id
      redirect_to sales_success_path(sale_id:  @sale.id)
    else
      redirect_to :front_page, params[:error] = "Your payment was unable to be executed"
    end
  end

  private

  def load_payment

  end

  def load_payment_params

  end

end
