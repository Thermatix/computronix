require 'paypal-sdk-rest'

class PaymentsController < ApplicationController

  include PayPal::SDK::REST

  def index
  end

  def new
    create
  end

  def create
    sale = ::Sale::Generator.new(params[:product_id] || session[:product_ids]).generate
    session[:sale_id] = sale.xid
    redirect_to sale.redirect_url
  end

  def execute
    @payment = Payment.find(session[:sale_id])
    if @payment.execute(payer_id: params['PayerID'])
      @sale = ::Sale.find_by_payment_xid(session[:sale_id])
      @sale.payment_xid = @payment.id
      @sale.save
      params[:sale_id] = @sale.id
      redirect_to sales_success_path(sale_id:  @sale.id)
    else
      redirect_to :front_page, error: "Your payment was unable to be executed"
    end
  end

  private

  def load_payment

  end

  def load_payment_params

  end

end
