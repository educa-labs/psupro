FactoryGirl.define do
  factory :institution do
    title {FFaker::Education.school}
    institution_type
    factory :institution_university do
      university
    end
  end
end
