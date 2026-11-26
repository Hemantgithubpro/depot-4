class Category < ApplicationRecord
  has_many :products
  belongs_to :parent

  validates :name, presence: true, uniqueness: { scope: :parent_id }, allow_blank: true
  validate :ensure_one_level_sub_category_nesting

  private

  def ensure_one_level_sub_category_nesting
    return if parent_id.nil? || parent.parent_id.nil?
    errors.add(:category, "only one level nesting of sub category allowed")
  end
end
