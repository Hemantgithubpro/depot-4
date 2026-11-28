class Category < ApplicationRecord
  has_many :products, dependent: :restrict_with_error
  belongs_to :parent, class_name: "Category", optional: true
  has_many :sub_categories, class_name: "Category", foreign_key: :parent_id, dependent: :destroy
  has_many :sub_category_products, through: :sub_categories, source: :products

  validates :name, presence: true, uniqueness: { scope: :parent_id }, allow_blank: true
  validate :ensure_one_level_sub_category_nesting

  before_destroy :ensure_sub_categories_have_no_products, prepend: true
  # after_destroy :ensure_sub_categories_also_destroyed

  def total_products_count
    products_count + sub_categories.sum(:products_count)
  end

  private

  def ensure_one_level_sub_category_nesting
    return if parent_id.nil? || parent.parent_id.nil?
    errors.add(:category, "only one level nesting of sub category allowed")
  end

  def ensure_sub_categories_have_no_products
    return if sub_category_products.none?
    errors.add(:sub_categories, "sub categories still have products")
    throw :abort
  end


  # def ensure_sub_categories_also_destroyed
  #   sub_categories.each { |t| t.destroy }
  # end
end
