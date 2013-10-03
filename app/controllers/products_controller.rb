class ProductsController < ApplicationController

  before_action :load_product, only: [:show, :edit, :update, :destroy]

  def index
    @category = Category.find(params[:category_id]) if params[:category_id]

    @products = @category.nil? ? Product.all : @category.all_products
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to [@product.category, :products], notice: 'product was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @product.update(product_params)
      redirect_to [@product.category, :products] , notice: 'product was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    if @product.destroy
      redirect_to products_url
    end
  end

  private

    def load_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title,:description,:value,:stock,:category_id)
    end
end
