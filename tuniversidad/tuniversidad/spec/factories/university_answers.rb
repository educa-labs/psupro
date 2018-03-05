FactoryGirl.define do
  factory :university_answer do
    university_question_id 1
    user_id 1
    answer "MyString"
    likes ""
    dislikes ""
    date "2017-03-24 00:32:01"
  end
end
