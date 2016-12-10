class Vote < ApplicationRecord
  validates :value, inclusion: { in: [-1, 1] }

  belongs_to :votable, polymorphic: true
end
