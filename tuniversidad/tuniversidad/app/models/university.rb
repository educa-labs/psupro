class University < ApplicationRecord
  validates_presence_of :website, :institution_id
  validates_uniqueness_of :institution_id
  belongs_to :institution
  belongs_to :university_type
  has_many :campus
  # DEPRECATED: institution model should be removed soon.
  delegate :title, to: :institution
  attr_accessor :get_profile_picture
  attr_accessor :get_cover_picture

  # Returns array of self's city ids.
  def cities
    self.campus.map {|x| x.city.id}
  end

  # Returns array of self's region ids.
  def regions
    self.campus.map {|x| x.city.region_id}
  end

  def u_type
    self.university_type.title
  end

  # Makes model searchable by solr.
  searchable do
    boolean :freeness
    text :nick
    text :title
    text :initials
    integer :id
    integer :cities, multiple: true
    integer :university_type_id
    integer :regions, multiple: true
  end

  # Returns string with base64 profile image for injection in html.
  def encoded_profile_picture
    "data:image/#{self.profile_extension};base64,#{File.open('public/images/universities/profile/' + self.profile_picture,'rb').read}"
  end

  # Returns string with base64 cover image for injection in html.
  def encoded_cover_picture
    "data:image/#{self.cover_extension};base64,#{File.open('public/images/universities/cover/' + self.cover_picture,'rb').read}"
  end

  # Creates file with base64 profile image data.
  def save_profile_picture(data)
    File.open('public/images/universities/'+ self.profile_picture,'w') do |f|
      f.write data
    end
  end

  # Creates file with base64 cover image data.
  def save_cover_picture(data)
    File.open('public/images/universities/'+ self.cover_picture,'w') do |f|
      f.write data
    end
  end
end
