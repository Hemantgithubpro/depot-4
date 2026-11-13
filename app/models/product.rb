class Product < ApplicationRecord
  has_many :line_items, dependent: :restrict_with_error

  after_initialize :set_default_title
  after_validation :set_default_discount_price

  # before_destroy :ensure_not_referenced_by_any_line_item

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
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }, if: -> { price.present? }
  validates :enabled, inclusion: { in: [ true, false ] }
  validates :discount_price, numericality: { greater_than_or_equal_to: 0, less_than: ->(product) { product.price } }, allow_blank: true
  validates :permalink, uniqueness: true, format: { with: /\A[a-zA-Z0-9]+(?:-[a-zA-Z0-9]+){2,}\z/ }
  validates :image_url, url: true, allow_blank: true
  validate :ensure_description_between_5_10_words
  # validate :discount_price_less_than_price

  private

    def set_default_title
      self.title = "abc" if title.blank?
    end

    def set_default_discount_price
      self.discount_price = price if discount_price.blank? && price.present?
    end

    # def discount_price_less_than_price
    #   return if discount_price.blank? || price.blank?
    #   return if price > discount_price

    #   errors.add(:discount_price, "discount price should be less than price")
    # end

    def ensure_description_between_5_10_words
      return if description.nil?

      word_count = description.split.size
      unless word_count.between?(5, 10)
        errors.add(:description, "must have 5 to 10 words")
      end
    end

  # def ensure_not_referenced_by_any_line_item
  #   unless line_items.empty?
  #     errors.add(:base, "Line Items present")
  #     throw :abort
  #   end
  # end
end
