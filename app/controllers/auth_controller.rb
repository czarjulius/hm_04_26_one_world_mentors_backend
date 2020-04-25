class AuthController < ApplicationController
  def create
    user = User.authenticate(login_params[:email], login_params[:password])
    if user
      token = JsonWebToken.encode({ "email" => user.email, "id" => user.id })
      render json: { "email": user.email, "token": token }, :status => :ok
    else
      render json: { error: "Invalid email or password", status: 403 }, :status => :forbidden
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
