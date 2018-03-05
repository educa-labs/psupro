require 'rails_helper'

RSpec.describe Institution, type: :model do
  before {@institution = FactoryGirl.build(:institution)}
  subject{@institution}

  it {should respond_to :title}
  it {should validate_uniqueness_of :title}
end