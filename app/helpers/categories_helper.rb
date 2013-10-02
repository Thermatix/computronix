module CategoriesHelper

  def child?
    @category && !@category.parent.nil?
  end

  def first_child_catagory?
    @category.parent.nil? ? :categories : @category.parent
  end

end
