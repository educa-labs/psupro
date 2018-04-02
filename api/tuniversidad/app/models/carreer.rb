class Carreer < ApplicationRecord

  include Elasticsearch::Model 
  include Elasticsearch::Model::Callbacks

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

  index_name "carreers"
  document_type self.name.downcase
  
  settings index: { number_of_shards: 1 } do 
    mapping dynamic: false do 
      indexes :title, analyzer: 'spanish'
    end 
  end

  def search(query)
    __elasticsearch__.search(
      { query:
        { multi_match: 
          { query: query, 
            fields: ['title'] 
          } 
        }
      })
  end


# This makes the model searchable with solr.
#   searchable do
#     text :title
#     text :university do
#       university.title
#       university.initials
#     end
#     integer :semesters
#     integer :price
#     integer :area_id
#     integer :university_id
#     string :schedule
#     float :employability
#     integer :income
#     integer :last_cut
#     string :admission
#     integer :city_id
#     integer :region_id
#   end
end
