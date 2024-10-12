class Project < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :swatches
end
