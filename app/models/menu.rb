class Menu < ApplicationRecord
  belongs_to :user
  has_many :menu_items
  validates :name, presence: true, length: { maximum: 14 }
end
