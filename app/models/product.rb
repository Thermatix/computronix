class Product < ActiveRecord::Base
  belongs_to :category

  def all_images
  #images are connected with the field but with
  #a strict naming convention
  # eg, product ID = 34, image is 34_front.png
  #the name is combined from the image ID and
  #the name in the images field
  # the field is name:alt,name:alt,name:alt
  temp = {}
  id = self.id
  images = self.images.split(',')
  images.each_with_index do |image,i|
    name,alt = image.split(':')
    temp["products/#{id}_#{name}".to_sym] = alt
  end
  temp
  end

end
