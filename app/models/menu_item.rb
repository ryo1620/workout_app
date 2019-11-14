class MenuItem < ApplicationRecord
  belongs_to :user
  belongs_to :menu
  belongs_to :item
end
