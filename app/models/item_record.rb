class ItemRecord < ApplicationRecord
  belongs_to :user
  belongs_to :menu_record
  validates :name, presence: true
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
  validates :date, presence: true
  validates :user_id, presence: true
  validates :menu_record_id, presence: true
end
