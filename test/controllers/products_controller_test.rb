require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @title = "The Great Book #{rand(1000)}"
    login_as users(:one)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end


  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should destroy product" do
    assert_raises ActiveRecord::RecordNotDestroyed do
      delete product_url(products(:two))
    end

    assert Product.exists?(products(:two).id)
  end
end
