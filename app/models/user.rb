class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_many :menus, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :week_menus, dependent: :destroy
  has_many :menu_items, dependent: :destroy
  has_many :menu_records, dependent: :destroy
  has_many :item_records, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }
  validates :height, numericality: { less_than: 1000 },
                     allow_blank: true
  validates :body_weight, numericality: { less_than: 1000 },
                          allow_blank: true
  validates :body_fat, numericality: { less_than: 100 },
                       allow_blank: true
  validates :bench_press, numericality: {
                            only_integer: true,
                            less_than: 1000
                          },
                          allow_blank: true
  validates :squat, numericality: {
                      only_integer: true,
                      less_than: 1000
                    },
                    allow_blank: true
  validates :deadlift, numericality: {
                         only_integer: true,
                         less_than: 1000
                       },
                       allow_blank: true
end
