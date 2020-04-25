class ProfileController < ApplicationController
  def show
    @profile = User.where(email: params.require(:email))
      .select('first_name', 'last_name', 'email').first
      render json:{profile: @profile}, status: 200
  end
end
