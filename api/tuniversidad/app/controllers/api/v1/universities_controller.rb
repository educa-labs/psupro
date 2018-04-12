class Api::V1::UniversitiesController < ApplicationController
  #before_action :authenticate_with_token!, only: [:show,:index]
  respond_to :json

  def show
    u = University.find(params[:id])
    if u
      if params[:image].nil?
        u.visits += 1 # Update count for most popular.
        u.save
        render json:u, status: 200
      else
        render json:{university: u, cover:u.encoded_cover_picture,profile:u.encoded_profile_picture} # Return images.
      end
    else
      render json:{errors:"invalid id"}, status: 404
    end
  end

  def index
    # /cities/city_id/universities .
    if params[:city_id]
      render json:City.find_by(id: params[:city_id]).universities.includes(:university_type).order("title asc"), status:200
    else
      render json: University.all.includes(:university_type).order("title asc"), status:200
    end
  end
end