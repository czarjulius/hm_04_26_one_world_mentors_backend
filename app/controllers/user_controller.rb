class UserController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :signup]
  def index
    render json: {message: 'Welcome to One world Mentor'}, status: 200
  end

  def signup
    @new_user = User.new(user_params)

    if @new_user.valid?
      @new_user.save

      render json: @new_user, status: 201
    else
      render json: @new_user.errors.details, status: 500

    end
  end

  def update_user
    current_user = User.find(params[:id])
    payload = JSON.parse(request.body.read)

    current_user.first_name = payload['first_name']
    current_user.email = payload['email']
    current_user.user_type = payload['last_name']
    current_user.user_type = payload['password']
    current_user.user_type = payload['user_type']
    
    
    if current_user.valid?
      current_user.save
      render json: current_user, status: 200
    else
      render json: current_user.errors.details, status: 500
    end

  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :user_type)
  end
end
