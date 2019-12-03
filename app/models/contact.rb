class Contact < ApplicationRecord
  validates :email, presence: true, length: {maximum:255}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX },
                    allow_blank: true
  validates :message, presence: true
end
