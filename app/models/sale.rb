class Sale < ActiveRecord::Base

  def payment_hash pay_method, items, description,total
    {
          intent: 'sale',
          redirect_urls: {
            return_url: 'http://127.0.0.1:3000/payments/execute',
            cancel_url:'http://127.0.0.1:3000/payments/cancel'
          },
          payer:
            payment_with(pay_method),
          transactions: [{
            item_list: {
              items: [items] },
              amount:{
                total: total,
                currency: 'GBP',
              },
              description: description
            }],
          }
  end

  def redirect_url
    @redirect_url || Sale::Generator.return_url(self.payment_xid)
  end

  def redirect_url= value
    @redirect_url = value
  end

  def payment_with pay_method
    case pay_method
    when "paypal"
      return {payment_method: 'paypal'}
    else
      raise ArgumentError, "Invalid payment time, expected(paypal,creditcard) got #{pay_method}"
    end
  end

  def hash_for_items product,quantity=1
    {
      name:product.title,
      sku: product.id,
      price: product.value,
      currency: 'GBP',
      quantity: quantity
    }
  end



  def products
  temp = []
    self.product_id.split(',').compact.each do |product_id|
      temp.push(Product.find(product_id))
    end
  temp
  end

  def products= products
    self.product_id = ""
    if products.is_a?(String) || products.is_a?(Integer)
      self.product_id = products.to_s
    elsif products.is_a?(Array)
      if products.first.is_a?(Product)
        products.each do |product|
          self.product_id += "#{product.id},"
        end
      else
        self.product_id = products.join(',')
      end
    elsif products.is_a?(Product)
      self.product_id = products.id
    end
  end

  def xid
    self.payment_xid
  end

  def xid= input
    self.payment_xid = input
  end
end
