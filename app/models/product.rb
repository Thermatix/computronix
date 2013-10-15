

class Product < ActiveRecord::Base

  belongs_to :category

  def all_images
  #images are connected with the field but with
  #a strict naming convention
  # eg, product ID = 34, image is 34_front.png
  #the name is combined from the image ID and
  #the name in the images field
  # the field is name:alt,name:alt,name:alt
  temp = []
  id = self.id
  images = self.images.split(',')
  images.each do |image|
    name,alt,size = image.split(':')
    temp.push(["products/#{id}_#{name}",alt,size])
  end
  temp
  end

  def one_click_buy
    item_hash = self.hash_for_items 1
    description = "This is a one click buy payment for a: #{self.title}"
    pay_method = 'paypal'
    total = self.value
    payment_hash(pay_method,item_hash,description, total)
  end
  def payment_hash pay_method, items={}, description,total
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
              items:[items]},
              amount:{
                total: total,
                currency: 'GBP',
              },
              description: description
            }],
          }
  end


  def payment_with pay_method
    case pay_method
    when 'paypal'
      return {payment_method: 'paypal'}
    else
      raise ArgumentError, "Invalid payment time, expected(paypal,creditcard) got #{pay_method}"
    end
  end

  def hash_for_items quantity
    {
      name:self.title,
      sku: self.id,
      price: self.value,
      currency: 'GBP',
      quantity: quantity
    }
  end

  def random times
    temp = ""
    for i in 1..times do
      temp += r(1..(r(1..i)*10)).to_s
    end
    temp
  end

  def r range
    Random.new.rand(range)
  end



end
