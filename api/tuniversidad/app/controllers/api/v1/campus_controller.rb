class Api::V1::CampusController < ApplicationController
  #before_action :authenticate_with_token!, only: [:show,:index]

  def show
    a = Campu.find_by(id: params[:id])
    if a
      render json:a, status:200
    else
      render json:{errors:"invalid id"}, status:404
    end
  end

  def index
    # Route cities/city_id/campus .
    if params[:city_id]
      render json:Campu.where(city_id: params[:city_id]), status:200
    # Route universities/university_id/campus .
    elsif params[:university_id]
      render json:Campu.where(university_id: params[:university_id]), status:200
    else
      render json:Campu.all, status:200
    end
  end

end
