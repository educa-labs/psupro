class Api::V1::NewsController < ApplicationController
  before_action :authenticate_with_token!, only: [:show,:index]

  def index
    render json:New.all.order("id DESC") , status:200
  end


  def show
    nw = New.find_by(id:params[:id])
    if nw
      if params[:image].nil?
          render json:nw, status:200
      else
        render json:{picture:nw.encoded_picture},status: 200 # Return base64 image string.
      end
    else
      render json:{errors:{new:"new_id doesn't exist"}}, status:200
    end
  end

end
