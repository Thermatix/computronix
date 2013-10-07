require 'money'
require 'money/bank/google_currency'
require 'json'

module FrontPageHelper

 def nav_button_class tree_level
    tree_level = "root" if tree_level == 1
    tree_level = "major" if tree_level == 2
    tree_level = "minor" if tree_level == 3
    "class='nav button #{tree_level}'".html_safe
 end

 def curr_convert value,currency
  Money.default_bank = Money::Bank::GoogleCurrency.new
  temp = value.to_money(:GBP)
  temp.exchange_to(currency)
  temp
 end

end
