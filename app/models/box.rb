class Box < ApplicationRecord
  validates :code, presence: true
  validates_uniqueness_of :code

  has_many :box_contents
  has_many :contents, through: :box_contents
end
