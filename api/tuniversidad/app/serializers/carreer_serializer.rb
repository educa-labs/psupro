# DEPRECATED
class CarreerSerializer < ActiveModel::Serializer
  attributes :id, :title,:university_name,:campu_name,:campu_id,:certification, :area_id,:semesters,:price,:area_title,:schedule,:openings,:employability,:income, :university_id,
             :admission, :last_cut,:degree_type, :description

  has_one :weighing
end