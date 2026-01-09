class ProfilesController < ApplicationController
  def show
    @user = User.find_by!(username: params[:username])
    @projects = @user.projects.where(public: true)
  end
end
