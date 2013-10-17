require 'paypal-sdk-rest'
class Sale::Generator

  include PayPal::SDK::REST

  attr_accessor :products, :payment, :description, :sale_object, :quantity

  def initialize product_id,quantity = 1, payment='paypal',description ="This is a one click buy payment"
    self.products = [product_id].flatten.map { |id| id = ::Product.find(id)}
    self.sale_object = ::Sale.new
    self.payment = payment
    self.description = description
    self.quantity = quantity
    self
  end

  def generate
    total_value = 0
    items = {}
    [self.products].flatten.each_with_index do |product,i|
      items = self.sale_object.hash_for_items(product,quantity_is_array(i))
      total_value += product.value
    end
    payment_hash = self.sale_object.payment_hash(self.payment,items,self.description,total_value)
    @payment = Payment.new payment_hash
    @payment.create
    self.sale_object.redirect_url = @payment.links.find{|link| link.method == 'REDIRECT'}.href
    self.sale_object.xid = @payment.id
    self.sale_object.products = self.products
    self.sale_object.save
    return self.sale_object
  end

  def quantity_is_array? index
    self.quantity.is_a?(Array) ? self.quantity[index] : self.quantity
  end

  def self.return_url id
    Payment.find(id).links.find{|link| link.method =='REDIRECT'}.href
  end
end