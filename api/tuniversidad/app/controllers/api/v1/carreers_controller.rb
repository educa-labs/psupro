class Api::V1::CarreersController < ApplicationController
  #before_action :authenticate_with_token!, only: [:show,:index]

  def show
    ca = Carreer.where(id:params[:id]).includes(:campu,:weighing,:area,:university).limit(1).first
    if ca
      ca.visits +=1 # Update visits count for most popular route.
      ca.save
      ca.render_picture = true
      render json:ca, status:200
    else
      render json: {errors: "invalid id"}, status:404
    end
  end

  def index
    # Route universities/university_id/carreers
    if params[:university_id]
      render json:Carreer.where(university_id: params[:university_id]).order("title ASC").includes(:campu,:weighing,:area,:university)
    else
      render json:Carreer.order("title ASC").includes(:campu,:weighing,:area,:university)
    end
  end
end