
# Deprecated: Should be eliminated soon.
class UniversityQuestion < ApplicationRecord
  validates_presence_of :user_id, :university_id, :question
  belongs_to :user
  belongs_to :university
  has_many :university_answers
  attr_accessor :answers
end
