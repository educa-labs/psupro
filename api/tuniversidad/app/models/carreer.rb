class Carreer < ApplicationRecord

  searchkick

  validates_presence_of :university_id, :campu_id, :title
  belongs_to :university
  belongs_to :campu
  belongs_to :area
  has_many :carreer_questions
  has_and_belongs_to_many :users
  has_one :weighing
  delegate :city_id, to: :campu
  delegate :city, to: :campu
  delegate :title, to: :area, prefix: true

  def university_name
    self.university.title
  end

  def university_initials
    self.university.initials
  end

  def campu_name
    self.campu.title
  end

  def region_id
    self.city.region_id
  end

  # Returns true if self doesn't have the minimum valid weighings.
  def weighing?
    not(self.weighing.language.nil? || self.weighing.math.nil?)
  end


end
