require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image].any?
  end

  def new_product(filename, content_type)
    Product.new(
      title:       "My Book Title",
      description: "yyy",
      price:       1
    ).tap do |product|
      product.image.attach(
        io: File.open("test/fixtures/files/#{filename}"), filename:, content_type:)
    end
  end


  test "product is not valid without a unique title" do
    product = Product.new(title:       products(:pragprog).title,
                          description: "yyy",
                          price:       1)
    product.image.attach(io: File.open("test/fixtures/files/lorem.jpg"),
                        filename: "lorem.jpg", content_type: "image/jpeg")

    assert product.invalid?
    assert_equal [ "has already been taken" ], product.errors[:title]
  end

  test "product is not valid without a unique title - i18n" do
    product = Product.new(title:       products(:pragprog).title,
                          description: "yyy",
                          price:       1)

    product.image.attach(io: File.open("test/fixtures/files/lorem.jpg"),
                        filename: "lorem.jpg", content_type: "image/jpeg")


    assert product.invalid?
    assert_equal [ I18n.translate("errors.messages.taken") ],
                 product.errors[:title]
  end
end
