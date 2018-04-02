class Api::V1::SearchController < ApplicationController
  #before_action :authenticate_with_token!, only: [:create]
  respond_to :json
  
  def create
    if params[:text]
      result = {}
      university_result = University.search(params[:text])
      result[:universities] = university_result.map { |x| x[:_source] }
      carreer_result= Carreer.search(params[:text])
      result[:carreers] = carreer_result.map { |x| x[:_source] }

      render json: result , status:200
    else
      render json:{errors:"no search params"}, status:422
    end
  end

end