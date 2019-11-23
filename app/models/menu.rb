class Menu < ApplicationRecord
  belongs_to :user
  has_many :week_menus, dependent: :destroy
  has_many :menu_items, dependent: :destroy
  validates :name, presence: true, length: { maximum: 14 }
end
