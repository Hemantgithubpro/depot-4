class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product
  belongs_to :cart, counter_cache: true, optional: true

  validates :quantity, numericality: { greater_than_or_equal_to: 1 }
  validates :product_id, uniqueness: { scope: :cart_id, message: "Combination of product_id and cart_id should be unique" },
    if: :in_cart?

  def total_price
    price * quantity
  end

  private
    def in_cart?
      cart_id.present?
    end
end
