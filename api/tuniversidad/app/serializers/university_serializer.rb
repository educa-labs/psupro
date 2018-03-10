class UniversitySerializer < ActiveModel::Serializer
  attributes :id,:title, :foundation,:website,:freeness,:motto,:nick,:description,
             :u_type,:initials,:students,:teachers,:degrees,:postgraduates,:doctorates,:institution_id
  #belongs_to :institution
end
