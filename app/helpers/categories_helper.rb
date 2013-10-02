module CategoriesHelper

  def child?
    if @category
      true
    else
      false
    end
  end

  def first_child_catagory?
    @category.parent.blank? ? :categories : @category.parent
  end

end
