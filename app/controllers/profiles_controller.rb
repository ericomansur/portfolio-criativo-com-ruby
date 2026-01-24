class ProfilesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to personalized_feed_path
    else
      redirect_to public_feed_path
    end
  end

  def show
    @user = User.find_by!(username: params[:username])
    @projects = @user.projects.where(public: true).order(created_at: :desc) || []
  end
end