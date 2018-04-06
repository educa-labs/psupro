class University < ApplicationRecord

  include Elasticsearch::Model 
  include Elasticsearch::Model::Callbacks

  validates_presence_of :website
  has_many :campus
  belongs_to :university_type

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

  index_name "universities"
  document_type self.name.downcase

  settings index: { number_of_shards: 1 } do 
    mapping dynamic: false do 
      indexes :nick, analyzer: 'spanish' 
      indexes :title, analyzer: 'spanish'
      indexes :initials, analyzer: 'spanish' 
    end 
  end

  def search(query)
    __elasticsearch__.search(
      { query:
        { multi_match: 
          { query: query, 
            fields: ['nick', 'title','initials'] 
          } 
        }
      })
  end

  # Makes model searchable by solr.
  # searchable do
  #   boolean :freeness
  #   text :nick
  #   text :title
  #   text :initials
  #   icnteger :id
  #   integer :cities, multiple: true
  #   integer :university_type_id
  #   integer :regions, multiple: true
  # end

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
