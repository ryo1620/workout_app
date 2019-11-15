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
end
