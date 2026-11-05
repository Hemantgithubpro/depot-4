require "test_helper"

class CartTest < ActiveSupport::TestCase
  test "add unique products" do
    cart = Cart.create
    cart.add_product(products(:pragprog)).save!
    cart.add_product(products(:one)).save!

    assert_equal 2, cart.line_items.count
  end

  test "add duplicate product" do
    cart = Cart.create
    book = products(:pragprog)
    cart.add_product(book).save!
    cart.add_product(book).save!

    assert_equal 1, cart.line_items.count
    assert_equal 2, cart.line_items.first.quantity
  end

  test "add_product captures the product price" do
    cart = Cart.create
    item = cart.add_product(products(:pragprog))

    assert_equal products(:pragprog).price, item.price
  end

  test "total_price sums line items" do
    cart = carts(:one)

    assert_equal cart.line_items.sum(&:total_price), cart.total_price
  end
end
