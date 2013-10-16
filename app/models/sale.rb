class Sale < ActiveRecord::Base

  def products
  temp = []
    self.product_id.split(',').each do |product_id|
      temp.push(Product.find(product_id))
    end
  temp
  end

  def products= products
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

end
