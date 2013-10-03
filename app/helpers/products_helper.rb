module ProductsHelper

  def edit_button_for product
    link_to 'edit',[:edit,product]
  end

end
