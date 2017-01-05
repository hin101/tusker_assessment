class Content < ApplicationRecord
  validates :content, presence: true

  has_many :box_contents
  has_many :boxes, through: :box_contents
end
