

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


end
