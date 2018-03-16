
# DEPRECATED: Should be eliminated soon.
class UniversityAnswer < ApplicationRecord
  validates_presence_of :university_question_id, :user_id, :answer
  belongs_to :university_question
  belongs_to :user
end
