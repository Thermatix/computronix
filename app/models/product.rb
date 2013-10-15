

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
    return  {
      intent: 'sale',
      redirect_urls: {
        return_url: 'http://127.0.0.1:3000/'
      },
      payer:{
        payment_method: 'paypal',
        },
      transactions: [{
        item_list: {
          items:[{
            name:self.title,
            sku: self.id,
            price: self.value,
            currency: 'GBP',
            quantity: 1
          }]},
          amount:{
            total: self.value,
            currency: 'GBP',
          },
          description: "This is a one click buy payment for a: #{self.title}"
        }],
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
