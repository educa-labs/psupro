class InstitutionType < ApplicationRecord
  validates_presence_of :level_id
  belongs_to :level
end
