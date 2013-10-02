class CategoriesController < ApplicationController
  before_filter :protect

  def index
    @category = nil
    @categories = Category.where( parent_id: nil )

  end

  def show
    @category = Category.find(params[:id])
    @categories = @category.children
    @categories.each {|category| ap category }
    render :action => :index
  end

  def new
    @category = Category.new
    @category.parent = Category.find(params[:id]) unless params[:id].nil?
  end

  def edit
    load_category
  end

  def create
    @category = Category.new(category_params)
    @category.parent = Category.find(params[:id]) unless params[:id].nil?
    if @category.save
      redirect_to @category, notice: "category(#{@category.title}) was successfully created."
    else
      render action: 'new'
    end
  end

  def update
    if @category.update(category_params)
      redirect_to @category, notice: 'Competition was successfully updated.'
    else
      render action: 'edit'
    end
  end
  def destroy
    @category = load_category
    parent = @category.parent
    if @category.destroy
      redirect_to parent || :root
    end
  end

  private

    def load_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:title)
    end
end
