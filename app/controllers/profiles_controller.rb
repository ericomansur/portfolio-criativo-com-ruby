class ProfilesController < ApplicationController
  def home
  end

  def show
    @user = User.find_by!(username: params[:username])
  end
end