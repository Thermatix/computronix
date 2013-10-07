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
    unique_invoice_id = random(10)
    values = {
      buisness: 'Computronix@test.co.uk',
      cmd: '_cart',
      upload: 1,
      :return => '/payment/success/',
      invoice: unique_invoice_id
    }
    values.merge!({
      "amount_1" => self.value,
      "item_name_1" => self.title,
      "item_number_1" => self.id,
      "quantity_1" => '1'
      })

    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
    #https://www.sandbox.paypal.com/cgi-bin/webscr?amount_1=&buisness=rpgjaguar-facilitator%40gmail.com&cmd=_cart&invoice=4517182822301241&item_name_1=some+game&item_number_1=2&quantity_1=1&return=%2Fpayment%2Fsuccess&upload=1
  end

  def random(times)
    temp = ""
    for i in 1..times do
      temp += r(1..(r(1..i)*10)).to_s
    end
    temp
  end

  def r(range)
    Random.new.rand(range)
  end



end
