class Api::V1::SearchController < ApplicationController
  #before_action :authenticate_with_token!, only: [:create]
  respond_to :json
  
  def index
    if params[:text]
      result = {}
      university_result = University.search(params[:text])
      minimize = ActiveModel::Type::Boolean.new.cast(params[:minimize])
      result[:universities] = minimize ? university_result.map { |x| {id: x[:_source][:id], title: x[:_source][:title]} } : university_result.map { |x| x[:_source] }
      if ActiveModel::Type::Boolean.new.cast(params[:pictures])
        result[:pictures] = University.profile_array(result[:universities].map { |x| x[:id]})
      end
      carreer_result = Carreer.search(params[:text])
      result[:carreers] = minimize ? carreer_result.map { |x| {id: x[:_source][:id], title: x[:_source][:title], university_title: x[:_source][:university][:title]} } : carreer_result.map { |x| x[:_source] }
      render json: result , status:200
    else
      render json:{errors:"no search params"}, status:422
    end
  end

end