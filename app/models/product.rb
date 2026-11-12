class Product < ApplicationRecord
  has_many :line_items

  after_initialize :set_default_title
  after_validation :set_default_discount_price

  before_destroy :ensure_not_referenced_by_any_line_item

  has_one_attached :image
  after_commit -> { broadcast_refresh_later_to "products" }
  validates :title, :description, :image, presence: true

  validates :title, uniqueness: true
  validate :acceptable_image

  def acceptable_image
    return unless image.attached?

    acceptable_types = [ "image/gif", "image/jpeg", "image/png" ]
    unless acceptable_types.include?(image.content_type)
      errors.add(:image, "must be a GIF, JPG or PNG image")
    end
  end
  validates :title, length: { minimum: 10 }
  validates :price, numericality: { greater_than_or_equal_to: 0.01, greater_than: ->(product) { product.discount_price } }, if: -> { price.present? }
  # validates :price, numericality: { greater_than_or_equal_to: 0.01 }, allow_nil: true
  validates :enabled, inclusion: { in: [ true, false ] }
  validates :discount_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :permalink, uniqueness: true, format: { with: /\A[a-zA-Z0-9]+(?:-[a-zA-Z0-9]+){2,}\z/ }
  validate :ensure_description_between_5_10_words
  # validate :price_greater_than_discount_price

  private

    def set_default_title
      self.title = "abc" if title.blank?
    end

    def set_default_discount_price
      self.discount_price = price if discount_price.blank?
    end

    # def price_greater_than_discount_price
    #   if price <= discount_price
    #    p self
    #     errors.add(:price, "price should be greater than discount price")
    #   end
    # end

    def ensure_description_between_5_10_words
      return if description.nil?

      word_count = description.split.size
      unless word_count.between?(5, 10)
        errors.add(:description, "must have 5 to 10 words")
      end
    end

    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      unless line_items.empty?
        errors.add(:base, "Line Items present")
        throw :abort
      end
    end
end
