class User < ApplicationRecord
  attr_accessor :get_picture # DEPRECATED
  include ActiveModel::Validations
  validates :auth_token, uniqueness: true
  validates_presence_of :first_name,:last_name,:email
  validates_with RUTValidator # Chilean rut validator.
  validates :phone, :allow_blank => true, :format =>{with:/\A\+569\d{8}\Z/i} # Chilean phone validator.
  validates :nem, allow_blank:true, numericality: {less_than_or_equal_to: 826, greater_than_or_equal_to: 208}
  validates :ranking, allow_blank:true, numericality: {less_than_or_equal_to: 850, greater_than_or_equal_to: 200}
  validates :rut, allow_blank:true, uniqueness:true
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable # Devise utilities.
  before_create :generate_authentication_token! # Generates auth token.

  # Deprecated: Questions are deprecated.
  has_many :carreer_questions
  has_many :carreer_answers
  has_many :university_questions
  has_many :university_answers
  belongs_to :city, optional: true
  belongs_to :institution, optional: true
  belongs_to :level, optional: true
  has_and_belongs_to_many :carreers
  has_many :essays
  has_many :objectives
  has_many :recommendations

  # Creates unique auth token.
  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end

  # Returns well formatted birth date.
  def birth_date_out
    if self.birth_date
      self.birth_date.strftime("%d-%m-%Y")
    else
      nil
    end
  end

  # DEPRECATED: User pictures were never used.
  def encoded_picture
    "data:image/#{self.extension};base64,#{File.open('public/images/' + self.picture,'rb').read}"
  end

  # DEPRECATED: User pictures were never used.
  def save_picture(data)
    File.open('public/images/'+ self.picture,'w') do |f|
      f.write data
    end
  end

  # Checks if User has completed the tutorial. If it hasn't but does have the conditions sets the attribute to true.
  def validate_tutorial
    if self.tutorial
      return true
    end
    if self.rut.nil? || birth_date.nil? || city_id.nil? || phone.nil? || preuniversity.nil? || level_id.nil? || nem.nil?
        return false
    else
      self.tutorial = true
      self.save
    end
  end

end