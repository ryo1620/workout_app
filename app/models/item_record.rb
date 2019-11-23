class ItemRecord < ApplicationRecord
  belongs_to :user
  belongs_to :menu_record
end
