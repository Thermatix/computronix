module ApplicationHelper
  def name_conversion_for id
    Product.find(id).title
  end
end
