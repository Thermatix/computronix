class Category < ActiveRecord::Base
  belongs_to :product

  has_many :children, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Category'
  scope :roots, -> {where(parent_id: nil)}


  def children_list
    @children ||= [children,children.try(:children_list)].flatten.compact
  end
  def parent
    return nil if self.parent_id.nil?
    self.class.find(self.parent_id)
  end

  def ancestors
    @ancestors ||= [parent,parent.try(:ancestors)].flatten.compact
  end

  def root
    @root ||= ancestors.last
  end
end
