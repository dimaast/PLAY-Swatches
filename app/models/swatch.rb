class Swatch < ApplicationRecord
  belongs_to :project
  has_many :fills
end
