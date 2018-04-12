class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :auth_token, :first_name, :last_name,:rut, :city_id,:phone,:admin, :preuniversity,:notifications,:level_id,:tutorial, :nem, :ranking
  attribute :birth_date_out, key: :birth_date
  
end
