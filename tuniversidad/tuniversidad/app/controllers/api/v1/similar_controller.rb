class Api::V1::SimilarController < ApplicationController

  include RecommendationHelper

  # params ?carrer_id, ?k=(int)
  def index
    carreer_id = [params[:carreer_id].to_i]
    k = params[:k].to_i
    request_result = request_similar(carreer_id,k)
    
    render json:Carreer.where(id:request_result), status:200
  end

end
