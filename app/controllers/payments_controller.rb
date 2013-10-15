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
    if params[:one_click_Buy]
      @payment = Payment.new Product.find(params[:one_click_Buy]).one_click_buy
    else
      # @payment = Payment.new (load_payment_params)
    end

    if @payment.create
        redirect_url = @payment.links.find{|link| link.method == 'REDIRECT'}.href
        ap "redirect to: #{redirect_url}"
        session[:payment_id] = @payment.id
        redirect_to redirect_url
    else
      redirect_to :front_page, params[:error] = "Youre payment was unable to be created"
    end
  end

  def execute
    @payment = Payment.find(session[:payment_id])
    if @payment.execute(payer_id: params[:PayerID])
      session[:payment_id] = @payment.id
      redirect_to "/payments/success"
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
