class Category < ApplicationRecord
  has_many :products
  belongs_to :parent, class_name: "Category", optional: true
  has_many :sub_categories, class_name: "Category", foreign_key: :parent_id
  has_many :sub_category_products, through: :sub_categories, source: :products

  validates :name, presence: true, uniqueness: { scope: :parent_id }, allow_blank: true
  validate :ensure_one_level_sub_category_nesting

  def total_products_count
    products_count + sub_categories.sum(:products_count)
  end

  private

  def ensure_one_level_sub_category_nesting
    return if parent_id.nil? || parent.parent_id.nil?
    errors.add(:category, "only one level nesting of sub category allowed")
  end
end
