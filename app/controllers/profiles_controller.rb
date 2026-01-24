# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  def home
  end

  def show
    @user = User.find_by!(username: params[:username])
    if user_signed_in? && current_user == @user
      @projects = @user.projects.order(created_at: :desc)
    else
      @projects = @user.projects.where(public: true).order(created_at: :desc)
    end
  end
end