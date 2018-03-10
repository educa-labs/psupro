
# DEPRECATED: Should be eliminated soon.
class CarreerAnswer < ApplicationRecord
  validates_presence_of :carreer_question_id, :user_id, :answer
  belongs_to :carreer_question
  belongs_to :user
end
