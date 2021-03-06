class Parentage < ActiveModel::Validator
 def validate(record)
  if record.ancestors.length > 2
    record.errors[:base] << "Can't have more then two ancestors"
  end
 end
end
class Category < ActiveRecord::Base

  has_many :products

  has_many :children, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Category'
  validates_with Parentage

  scope :roots, -> {where(parent_id: nil)}

  def ancestors
    @ancestors ||= [parent,parent.try(:ancestors)].flatten.compact
  end

  def all_children
    @all_children ||= [self,children,children.map{|child| child.all_children}].flatten.compact
  end

  def all_products
    @all_products ||= Product.where(category_id: all_children)
  end

  def root
    @root ||= ancestors.last
  end

  def root?
    self.parent.nil?
  end
end