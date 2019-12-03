class MenuRecord < ApplicationRecord
  belongs_to :user
  has_many :item_records, dependent: :destroy
  validates :name, presence: true
  validates :date, presence: true
  validates :user_id, presence: true
end
