# DEPRECATED
class UniversityQuestionSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :question, :details, :university_id
  has_many :university_answers , if: :answers
  def answers
    object.answers
  end
end
