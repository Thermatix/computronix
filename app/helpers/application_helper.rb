module ApplicationHelper
  def name_conversion_for id
    Product.find(id).title
  end

  def curr_convert value,currency
    Money.default_bank = Money::Bank::GoogleCurrency.new
    temp = value.to_money(:GBP)
    temp.exchange_to(currency)
    temp
  end

  def cart
    session[:cart]
  end

end
