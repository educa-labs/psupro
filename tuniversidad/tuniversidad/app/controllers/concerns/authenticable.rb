module Authenticable

  # Current user is set as authenticated user through Authorization header.
  def current_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

  # Method to require authentication on routes.
  def authenticate_with_token!
    render json: { errors: "authentication error" },
           status: :unauthorized unless current_user.present?
  end
end