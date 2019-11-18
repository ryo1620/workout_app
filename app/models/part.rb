class Part < ApplicationRecord
  has_many :items, ->{ order(:id) }
end
