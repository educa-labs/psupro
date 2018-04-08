class University < ApplicationRecord

  validates_presence_of :website
  has_many :campus
  belongs_to :university_type
  searchkick language: "spanish"

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


  # Returns string with base64 profile image for injection in html.
  def encoded_profile_picture
    "data:image/#{self.profile_extension};base64,#{File.open('public/images/universities/profile/' + self.profile_picture,'rb').read}"
  end

  # Returns string with base64 cover image for injection in html.
  def encoded_cover_picture
    "data:image/#{self.cover_extension};base64,#{File.open('public/images/universities/cover/' + self.cover_picture,'rb').read}"
  end

  def self.profile_array(ids)
    universities = where(id:ids)
    return universities.map { |x| {id: x.id, picture:x.encoded_profile_picture}}
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
