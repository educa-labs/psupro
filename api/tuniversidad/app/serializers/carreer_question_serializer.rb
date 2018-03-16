# DEPRECATED
class CarreerQuestionSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :question, :details, :carreer_id
  has_many :carreer_answers , if: :answers
  def answers
    object.answers
  end
end
