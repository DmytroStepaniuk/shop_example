class Api::SessionsController < ApplicationController
  skip_before_action :authenticate!, only: :create

  def create
    @resource = SignIn.new resource_params

    resource.save!
  end

  def destroy
    current_session.destroy!

    head :no_content
  end

  private

  def resource_params
    params.require(:session).permit(:email, :password)
  end
end
