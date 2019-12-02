class Item < ApplicationRecord
  belongs_to :user
  belongs_to :part
  belongs_to :type
  has_many :menu_items, dependent: :destroy
  validates :name, presence: true, length: { maximum: 30 }
  validates :user_id, presence: true
end
