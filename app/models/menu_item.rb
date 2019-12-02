class MenuItem < ApplicationRecord
  belongs_to :user
  belongs_to :menu
  belongs_to :item
  validates :user_id, presence: true
  validates :menu_id, presence: true
  validates :item_id, presence: true
  validates :weight, numericality: {
                       only_integer: true,
                       greater_than: 0,
                       less_than: 1000
                     },
                     allow_blank: true
  validates :reps, numericality: {
                     only_integer: true,
                     greater_than: 0,
                     less_than: 1000
                   },
                   allow_blank: true
  validates :seconds, numericality: {
                        only_integer: true,
                        greater_than: 0,
                        less_than: 1000
                      },
                      allow_blank: true
  validates :sets, numericality: {
                     only_integer: true,
                     greater_than: 0,
                     less_than: 1000
                   },
                   allow_blank: true                      
end
