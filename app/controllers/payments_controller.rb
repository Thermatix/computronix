require 'paypal-sdk-rest'

class PaymentsController < ApplicationController

  include PayPal::SDK::REST

  def index
  end

  def new
    if params[:one_click_buy]
      redirect_to :create
    else
      @payment = Payment.new
    end
  end

  def create
    @payment = Payment.new (params[:one_click_buy] || load_payment_params)

    if @payment.create

      @payment.id
      redirect_to payments_path
    else
      @payment.error
    end
  end

  private

  def load_payment

  end

  def load_payment_params

  end

end
