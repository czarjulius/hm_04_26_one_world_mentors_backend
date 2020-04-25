class ApplicationController < ActionController::API
  before_action :authenticate_request, except: [:auth]
  attr_reader :current_user

  def authenticate_request
    @current_user ||= Authorization.authorize(request.headers)
    render json: { error: "Missing token or Not Authorized" }, status: 401 unless @current_user
  end
end
