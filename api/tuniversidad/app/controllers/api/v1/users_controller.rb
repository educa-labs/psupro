class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:show,:update, :destroy]
  respond_to :json

  # DEPRECATED
  def show
    current_user.get_picture = params[:get_picture]
    render json: current_user, status:200
  end

  def create
    # DEPRECATED: User pictures are deprecated
    user_hash,data = clear_params
    user = User.new(user_hash)
    if data
      user.save_picture(data)
    end
    if user.save
      user.generate_authentication_token!
      user.save
      render json: user, status: 201, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def update
    user = current_user
    user_hash,data = clear_params
    if user.update(user_hash)
      if data
        user.save_picture(data)
      end

      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    current_user.destroy
    head 204
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,:first_name,:last_name,:rut,:birth_date,:city_id,:phone,:writer,:institution_id,:admin,:preuniversity,:notifications,:level_id,:image_data,:image_name,:tutorial,:ranking,:nem)
  end

  # Sanitize and format user data.
  def clear_params
    user_hash = user_params
    if user_hash[:first_name]
      user_hash[:first_name] =user_hash[:first_name].downcase
      user_hash[:first_name] = user_hash[:first_name].capitalize
    end
    if user_hash[:last_name]
      user_hash[:last_name] =user_hash[:last_name].downcase
      user_hash[:last_name] = user_hash[:last_name].capitalize
    end
    if user_hash[:image_data]
      user_hash[:picture] = user_hash[:email]+ '_picture'
      user_hash[:extension] = File.extname(user_hash[:image_name])
      data = user_hash[:image_data]
      user_hash.except!(:image_data)
      user_hash.except!(:image_name)
      return user_hash,data
    end
    return user_hash,nil
  end


end
