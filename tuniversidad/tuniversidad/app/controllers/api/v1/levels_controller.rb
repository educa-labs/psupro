# DEPRECATED
class Api::V1::LevelsController < ApplicationController

  def index
    render json:Level.all, status:200
  end
end
