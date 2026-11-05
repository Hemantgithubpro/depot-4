require "test_helper"

class LineItemTest < ActiveSupport::TestCase
  test "quantity must be at least one" do
    line_item = line_items(:one)
    line_item.quantity = 0

    assert line_item.invalid?
    assert line_item.errors[:quantity].any?
  end

  test "total_price is the stored price times quantity" do
    line_item = line_items(:one)
    line_item.price = 5
    line_item.quantity = 3

    assert_equal 15, line_item.total_price
  end
end
