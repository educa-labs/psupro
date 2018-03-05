
# DEPRECATED: Should be eliminated soon.
class Level < ApplicationRecord
  validates_presence_of :title
  has_many :institution_types
  has_many :institutions, through: :institution_types
end