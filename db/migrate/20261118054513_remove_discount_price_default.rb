class RemoveDiscountPriceDefault < ActiveRecord::Migration[8.1]
  def change
    change_column_default :products, :discount_price, from: 0, to: nil
  end
end
