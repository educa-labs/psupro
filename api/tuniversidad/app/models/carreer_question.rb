
# DEPRECATED: should be eliminated soon.
class CarreerQuestion < ApplicationRecord
  validates_presence_of :user_id, :carreer_id, :question
  belongs_to :user
  belongs_to :carreer
  has_many :carreer_answers
  attr_accessor :answers
end
