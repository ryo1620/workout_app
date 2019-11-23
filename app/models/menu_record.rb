class MenuRecord < ApplicationRecord
  belongs_to :user
  has_many :item_records, dependent: :destroy
end
