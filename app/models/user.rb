class User < ApplicationRecord
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  has_secure_password

  validates :name, presence: true, uniqueness: true
  validates :email_address, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9]+@[a-zA-Z]+\.[a-zA-Z]+\z/ }

  before_destroy :ensure_admin_not_destroyed
  before_update :ensure_admin_not_updated
  after_create :send_user_mail
  after_destroy :ensure_an_admin_remains

  class Error < StandardError
  end

  private
    def send_user_mail
      UserMailer.welcome(self).deliver_later
    end

    def ensure_admin_not_destroyed
      return unless email_address == "admin@depot.com"

      errors.add(:base, "The admin user cannot be deleted")
      throw :abort
    end

    def ensure_admin_not_updated
      return unless email_address == "admin@depot.com"

      errors.add(:base, "The admin user cannot be updated")
      throw :abort
    end

    def ensure_an_admin_remains
      if User.count.zero?
        raise Error.new "Can't delete last user"
      end
    end
end
