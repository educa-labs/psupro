
# DEPRECATED: Should be eliminated soon.
class Institution < ApplicationRecord
  validates_presence_of :title, :institution_type_id
  validates_uniqueness_of :title
  belongs_to :institution_type
  has_one  :university, validate: false
end
