class Sale::Cart
  attr_accessor :cart, :quanitity
  def initialize session
    self.session = session[:cart][:products]
    self.quanitity = session[:cart][:quanitity]
  end

  def update_cart session,
    self.session = session[:cart][:products]
    self.quanitity = session[:cart][:quanitity]
  end

  def
end