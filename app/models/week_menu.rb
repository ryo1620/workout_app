class WeekMenu < ApplicationRecord
  belongs_to :user
  belongs_to :menu
  validates :cwday, presence: true
  validates :user_id, presence: true
  validates :menu_id, presence: true
end
